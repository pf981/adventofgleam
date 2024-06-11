import gleam/int
import lustre
import lustre/attribute.{class}
import lustre/element
import lustre/element/html
import lustre/event

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

pub type Model =
  Int

fn init(_flags) -> Model {
  0
}

pub type Msg {
  Increment
  Decrement
}

pub fn update(model: Model, msg: Msg) -> Model {
  case msg {
    Increment -> model + 1
    Decrement -> model - 1
  }
}

pub fn view(model: Model) -> element.Element(Msg) {
  let count = int.to_string(model)
  let header =
    html.header([class("p-4 bg-red-500 text-white")], [
      html.h1([class("w-full mx-auto max-w-screen-xl text-4xl font-bold")], [
        html.text("Advent of Gleam"),
      ]),
    ])

  html.div([], [
    header,
    html.button(
      [
        class(
          "text-white bg-blue-700 hover:bg-blue-800 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center me-2 dark:bg-blue-600 dark:hover:bg-blue-700",
        ),
        event.on_click(Increment),
      ],
      [element.text("+")],
    ),
    element.text(count),
    html.button(
      [
        class(
          "text-white bg-blue-700 hover:bg-blue-800 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center me-2 dark:bg-blue-600 dark:hover:bg-blue-700",
        ),
        event.on_click(Decrement),
      ],
      [element.text("-")],
    ),
  ])
}
//
