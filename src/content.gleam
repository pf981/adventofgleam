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
  Card(heading: String, image: Option(String), List(Content))
  Info(heading: String, List(Content))
  UList(List(List(InlineContent)))
}

pub type InlineContent {
  Code(String)
  Link(href: String, text: String)
  Text(String)
  Emphasis(String, Option(Color))
  EmphasisUL(String, Option(Color))
}

pub type Color {
  Red
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
      html.pre([attribute("data-lang", lang), class("clear-left")], [
        html.code([], [element.text(code)]),
      ])
    Card(heading, Some(image), content) ->
      html.div(
        [
          class(
            // "md:float-left md:mr-6 md:mb-6 sm:w-full md:max-w-sm rounded overflow-hidden shadow-lg",
            // "md:float-left md:mr-6 md:mb-6 sm:w-full md:max-w-screen-sm rounded overflow-hidden shadow-lg",
            "md:float-left md:mr-6 md:mb-6 sm:w-full md:max-w-md rounded overflow-hidden shadow-lg",
          ),
          class(
            "border-r border-b border-l border-t border-gray-400 rounded-b lg:rounded-b-none lg:rounded-r flex flex-col justify-between leading-normal",
            // "border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal",
          ),
        ],
        [
          html.div([class("px-6 py-4")], [
            html.div([class("font-bold text-xl mb-2")], [html.text(heading)]),
            html.p(
              [class("text-gray-700 text-base")],
              list.map(content, view(base_path, _)),
            ),
          ]),
          html.div(
            [class("w-full mx-0 px-0 bg-white border-t border-grey-lighter")],
            [
              html.img([
                attribute.alt(heading),
                attribute.src(base_path <> "/" <> image),
                class("w-full p-4"),
              ]),
            ],
          ),
        ],
      )
    Card(heading, None, content) -> todo
    // Info(heading, content) -> html.ul([], list.map(content, view(base_path, _)))
    Info(heading, content) ->
      html.div(
        [
          class("w-full rounded overflow-hidden shadow-lg"),
          attribute.class(
            "border-4 border-secondary rounded-b lg:rounded-b-none lg:rounded-r flex flex-col justify-between leading-normal",
            // "border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal",
          ),
        ],
        [
          html.div([], [
            html.div(
              // [
              //   class(
              //     "p-3 font-body text-2xl font-semibold text-white bg-secondary",
              //   ),
              // ],
              // [class("p-4 font-bold text-xl mb-2 bg-secondary text-white")],
              [class("px-6 py-4 font-semibold text-xl bg-secondary text-white")],
              [html.text(heading)],
            ),
            html.div(
              // [class("text-gray-700 text-base")],
              [class("px-6")],
              list.map(content, view(base_path, _)),
            ),
          ]),
        ],
      )
    UList(content) ->
      html.ul(
        // overflow-hidden makes bullets indented correctly when next to floating element
        [class("overflow-hidden")],
        // [class("list-inside")],
        content
          |> list.map(list.map(_, view_inline))
          |> list.map(html.li([], _)),
      )
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
    Some(Red) -> class("text-red")
    Some(Green) -> class("text-green")
    Some(Blue) -> class("text-blue")
    Some(Yellow) -> class("text-yellow-dark")
    None -> class("")
  }
}
