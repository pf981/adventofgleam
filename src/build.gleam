import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

import lustre/element.{type Element}

import lustre/element/html.{html}
import lustre/ssg

// import lustre/ui
// import lustre/ui/util/cn

import tailwind

import content
import post.{type Post}
import posts
import templates

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
    |> result.map_error(fn(e) { string.inspect(e) })
    |> result.try(fn(_) {
      [
        "--config=tailwind.config.js", "--input=./src/css/app.css",
        "--output=./dist/css/app.css",
      ]
      |> tailwind.run()
    })

  case build {
    Ok(_) -> io.println("Build succeeded!")
    Error(e) -> {
      io.debug(e)
      io.println("Build failed!")
      panic as "Build failed!"
    }
  }
}

fn render_post(post: Post) -> Element(msg) {
  let title = int.to_string(post.year) <> "/" <> int.to_string(post.day)
  let description =
    "Advent of code "
    <> int.to_string(post.year)
    <> " day "
    <> int.to_string(post.day)
    <> " in Gleam. "
    <> post.description

  templates.html(
    "../..",
    title,
    description,
    html.article([], list.map(post.content, content.view)),
  )
}

fn page(title: String) -> Element(msg) {
  templates.html(
    ".",
    title,
    "Explore creative solutions to Advent of Code challenges using the Gleam programming language
    on Advent of Gleam. Dive into detailed problem-solving techniques and enhance your coding
    skills.",
    templates.home_content("."),
  )
}
