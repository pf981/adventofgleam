import gleam/list
import gleam/option.{type Option, None, Some}

import lustre/attribute.{attribute, class}
import lustre/element.{type Element}
import lustre/element/html

pub type Content {
  Title(String)
  Heading(String)
  DualHeading(String, String)
  Subheading(String)
  Section(List(InlineContent))
  Snippet(lang: String, code: String)
  Card(heading: String, image: Option(String), List(InlineContent))
}

pub type InlineContent {
  Code(String)
  Link(href: String, text: String)
  Text(String)
  Emphasis(String, Option(Color))
  EmphasisUL(String, Option(Color))
}

// pub type Emphasis {
//   Emphasis(String, Option(Color))
//   EmphasisUL(String, Option(Color))
// }

pub type Color {
  Green
  Blue
  Yellow
}

pub fn view(base_path: String, content: Content) -> Element(msg) {
  case content {
    Title(text) -> html.h1([], [element.text(text)])
    Heading(text) -> html.h2([], [element.text(text)])
    DualHeading(first, second) ->
      html.h2([], [
        element.text(first),
        html.small([class("inline-block indent-3")], [element.text(second)]),
      ])
    Subheading(text) -> html.h3([], [element.text(text)])
    Section(content) -> html.p([], list.map(content, view_inline))
    Snippet(lang, code) ->
      html.pre([attribute("data-lang", lang)], [
        html.code([], [element.text(code)]),
      ])
    Card(heading, Some(image), content) ->
      html.div(
        [
          class("max-w-sm rounded overflow-hidden shadow-lg"),
          attribute.class(
            "border-r border-b border-l border-t border-gray-400 rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal",
            // "border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal",
          ),
        ],
        [
          html.img([
            attribute.alt(heading),
            attribute.src(base_path <> "/" <> image),
            class("w-full"),
            class("bg-white"),
          ]),
          html.div([class("px-6 py-4")], [
            html.div([class("font-bold text-xl mb-2")], [html.text(heading)]),
            html.p(
              [class("text-gray-700 text-base")],
              list.map(content, view_inline),
            ),
          ]),
        ],
      )
    // html.div([attribute.class("max-w-sm w-full lg:max-w-full lg:flex")], [
    //   html.div(
    //     [
    //       attribute("title", "Woman holding a mug"),
    //       attribute(
    //         "style",
    //         "background-image: url('" <> base_path <> "/" <> image <> "')",
    //       ),
    //       attribute.class(
    //         "h-48 lg:h-auto lg:w-48 flex-none bg-cover rounded-t lg:rounded-t-none lg:rounded-l text-center overflow-hidden",
    //       ),
    //     ],
    //     [],
    //   ),
    //   html.div(
    //     [
    //       attribute.class(
    //         "border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal",
    //       ),
    //     ],
    //     [
    //       html.div([attribute.class("mb-8")], [
    //         html.div(
    //           [attribute.class("text-gray-900 font-bold text-xl mb-2")],
    //           [element.text("Can coffee make you a better developer?")],
    //         ),
    //         html.p([attribute.class("text-gray-700 text-base")], [
    //           element.text(
    //             "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatibus quia, nulla! Maiores et perferendis eaque, exercitationem praesentium nihil.",
    //           ),
    //         ]),
    //       ]),
    //       html.div([attribute.class("flex items-center")], [
    //         html.img([
    //           attribute.alt("Avatar of Jonathan Reinink"),
    //           attribute.src("/img/jonathan.jpg"),
    //           attribute.class("w-10 h-10 rounded-full mr-4"),
    //         ]),
    //         html.div([attribute.class("text-sm")], [
    //           html.p([attribute.class("text-gray-900 leading-none")], [
    //             element.text("Jonathan Reinink"),
    //           ]),
    //           html.p([attribute.class("text-gray-600")], [
    //             element.text("Aug 18"),
    //           ]),
    //         ]),
    //       ]),
    //     ],
    //   ),
    // ])
    Card(heading, None, content) -> todo
  }
}

fn view_inline(content: InlineContent) -> Element(msg) {
  case content {
    Code(text) -> html.code([], [element.text(text)])
    Link(href, text) -> html.a([attribute("href", href)], [element.text(text)])
    Text(text) -> element.text(text)
    Emphasis(text, color) ->
      html.strong([color_class(color)], [element.text(text)])
    EmphasisUL(text, color) ->
      html.strong([class("underline"), color_class(color)], [element.text(text)])
  }
}

fn color_class(color: Option(Color)) -> attribute.Attribute(a) {
  case color {
    Some(Green) -> class("text-green")
    Some(Blue) -> class("text-blue")
    Some(Yellow) -> class("text-yellow-dark")
    None -> class("")
  }
}
