import gleam/int
import gleam/io
import gleam/list
import gleam/string

import lustre/attribute.{attribute}
import lustre/element.{type Element}

import lustre/element/html.{html, text}
import lustre/ssg
import lustre/ui
import lustre/ui/util/cn

import content
import post.{type Post}
import posts

pub fn main() {
  let posts = posts.all()

  let build =
    ssg.new("./dist")
    |> ssg.add_static_route("/", page("Home"))
    |> list.fold(
      posts,
      _,
      fn(config, post) {
        ssg.add_static_route(
          config,
          "/"
            <> int.to_string(post.year)
            <> "/"
            <> string.pad_left(int.to_string(post.day), 2, "0"),
          render_post(post),
        )
      },
    )
    |> ssg.add_static_dir("./static")
    |> ssg.use_index_routes
    |> ssg.build

  case build {
    Ok(_) -> io.println("Build succeeded!")
    Error(e) -> {
      io.debug(e)
      io.println("Build failed!")
    }
  }
}

fn page(title: String) -> Element(msg) {
  let content =
    ui.stack([attribute.style([#("width", "60ch"), #("margin", "auto")])], [
      html.h1([cn.text_2xl()], [html.text("Universal components")]),
      html.p([], [
        html.text("In Lustre, applications are built around the "),
        html.text("MVU architecture with a model representing "),
        html.text("program state, a view function to render "),
        html.text("that state, and an update function to handle "),
        html.text("events and update that state."),
      ]),
      html.p([], [
        html.text("These three building blocks are encapsulated "),
        html.text("by the `App` type. Lustre's secret weapon is "),
        html.text("that the same app can be run multiple ways "),
        html.text("without changing the core app code."),
      ]),
      html.p([], [
        html.text("Below, we have a counter app rendered three "),
        html.text("different ways. Once as a traditional client "),
        html.text("side app - suitable as a SPA. Then that "),
        html.text("counter has been bundled as a Custom Element "),
        html.text("and rendered as a <counter-component>. And "),
        html.text("finally as a server component. Here all of "),
        html.text("component's logic and rendering happens on "),
        html.text("the server and a tiny (<6kb!) runtime "),
        html.text("patches the DOM in the browser."),
      ]),
      html.p([], [
        html.text("For the two component versions of the app, "),
        html.text("try opening your browser's dev tools and "),
        html.text("setting the `count` attribute for each "),
        html.text("component. You can also attach event "),
        html.text("listeners and listen for 'incr' and 'decr' "),
        html.text("events."),
      ]),
    ])

  html([attribute("lang", "en"), attribute.class("overflow-x-hidden")], [
    html.head([], [
      html.title([], title),
      html.meta([attribute("charset", "utf-8")]),
      html.meta([
        attribute("name", "viewport"),
        attribute("content", "width=device-width, initial-scale=1"),
      ]),
      html.link([attribute.href("./pico.min.css"), attribute.rel("stylesheet")]),
      html.link([attribute.href("./lustre-ui.css"), attribute.rel("stylesheet")]),
      html.style(
        [],
        " body > div {
                max-width: 60ch;
                margin: 0 auto;
                padding-top: 2rem;
              }
            ",
      ),
    ]),
    html.body([], [content]),
    // html.body([], [text("Hello world!")]),
  ])
}

fn render_post(post: Post) -> Element(msg) {
  let title = int.to_string(post.year) <> "/" <> int.to_string(post.day)

  html([attribute("lang", "en"), attribute.class("overflow-x-hidden")], [
    html.head([], [
      html.title([], title),
      html.meta([attribute("charset", "utf-8")]),
      html.meta([
        attribute("name", "viewport"),
        attribute("content", "width=device-width, initial-scale=1"),
      ]),
      html.link([attribute.href("/pico.min.css"), attribute.rel("stylesheet")]),
      html.style(
        [],
        " body > div {
                max-width: 60ch;
                margin: 0 auto;
                padding-top: 2rem;
              }
            ",
      ),
    ]),
    html.body([], [html.div([], list.map(post.content, content.view))]),
  ])
}
