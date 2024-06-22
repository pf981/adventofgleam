import gleam/int
import gleam/io
import gleam/list
import gleam/string

import lustre/attribute.{attribute}
import lustre/element.{type Element}

import lustre/element/html.{html, text}
import lustre/ssg

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
    html.body([], [text("Hello world!")]),
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
