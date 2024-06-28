import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

import lustre/ssg

// import lustre/ui
// import lustre/ui/util/cn

import tailwind

import posts
import templates

pub fn main() {
  let posts = posts.all()

  let build =
    ssg.new("./dist")
    |> ssg.add_static_route("/", templates.render_home("."))
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
          templates.render_post("../..", post),
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
