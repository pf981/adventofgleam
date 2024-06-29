import gleam/int
import gleam/list

import lustre/attribute.{attribute, class, href}
import lustre/element.{type Element, element}
import lustre/element/html.{
  a, div, h1, h2, h3, h4, i, img, li, p, span, text, ul,
}

import content
import post.{type Post}

pub fn render_home(base_path: String) -> Element(msg) {
  html(
    ".",
    "Advent of Gleam",
    "Explore creative solutions to Advent of Code challenges using the Gleam programming language
    on Advent of Gleam. Dive into detailed problem-solving techniques and enhance your coding
    skills.",
    home_content(base_path),
  )
}

pub fn render_post(base_path: String, post: Post) -> Element(msg) {
  let title =
    int.to_string(post.year)
    <> " Day "
    <> int.to_string(post.day)
    <> " | Advent of Gleam"
  let description =
    "Advent of code "
    <> int.to_string(post.year)
    <> " day "
    <> int.to_string(post.day)
    <> " in Gleam. "
    <> post.description

  html(
    base_path,
    title,
    description,
    html.div([class("container mx-auto")], [
      html.article([], [
        div([class("pt-16 lg:pt-20")], [
          post_title_block(post),
          div(
            [
              class(
                "prose prose max-w-none border-b border-grey-lighter py-8 dark:prose-dark sm:py-12",
              ),
            ],
            list.map(post.content, content.view(base_path, _)),
          ),
        ]),
      ]),
      // Full Solution Modal: https://tailwindcomponents.com/component/alpine-modal
      html.div([attribute("x-data", "{ modelOpen: false }")], [
        // Buttons
        html.span([class("flex justify-end space-x-4 pt-3 pb-3")], [
          a(
            [
              attribute.target("_blank"),
              href(
                "https://adventofcode.com/"
                <> int.to_string(post.year)
                <> "/day/"
                <> int.to_string(post.day),
              ),
              class(
                "block bg-secondary p-3 text-center font-body text-base font-medium text-white transition-colors hover:bg-green",
              ),
            ],
            [i([class("bx bx-link-external pr-1")], []), text("Problem")],
          ),
          html.button(
            [
              class(
                "block bg-secondary p-3 text-center font-body text-base font-medium text-white transition-colors hover:bg-green",
              ),
              attribute("@click", "modelOpen = !modelOpen"),
            ],
            [i([class("bx bx-code-alt pr-1")], []), text("Full Solution")],
          ),
        ]),
        // Prevent modal from briefly showing on page load: https://stackoverflow.com/questions/64430464/how-to-prevent-alpine-js-modal-from-showing-every-time-i-refresh-the-page
        // html.template([attribute("x-if", "true")], [
        html.div(
          [
            attribute("aria-modal", "true"),
            attribute.role("dialog"),
            attribute("aria-labelledby", "modal-title"),
            attribute.class("fixed inset-0 z-50 overflow-y-auto"),
            attribute("x-show", "modelOpen"),
          ],
          [
            html.div(
              [
                attribute.class(
                  "flex items-end justify-center min-h-screen px-4 text-center md:items-center sm:block sm:p-0",
                ),
              ],
              [
                html.div(
                  [
                    attribute("aria-hidden", "true"),
                    attribute.class(
                      "fixed inset-0 transition-opacity bg-gray-500 bg-opacity-40",
                    ),
                    attribute("x-transition:leave-end", "opacity-0"),
                    attribute("x-transition:leave-start", "opacity-100"),
                    attribute(
                      "x-transition:leave",
                      "transition ease-in duration-200 transform",
                    ),
                    attribute("x-transition:enter-end", "opacity-100"),
                    attribute("x-transition:enter-start", "opacity-0"),
                    attribute(
                      "x-transition:enter",
                      "transition ease-out duration-300 transform",
                    ),
                    attribute("x-show", "modelOpen"),
                    attribute("@click", "modelOpen = false"),
                    attribute("x-cloak", ""),
                  ],
                  [],
                ),
                html.div(
                  [
                    attribute.class(
                      "inline-block w-full max-w-xl p-8 my-20 overflow-hidden text-left transition-all transform bg-white rounded-lg shadow-xl 2xl:max-w-2xl",
                    ),
                    attribute(
                      "x-transition:leave-end",
                      "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
                    ),
                    attribute(
                      "x-transition:leave-start",
                      "opacity-100 translate-y-0 sm:scale-100",
                    ),
                    attribute(
                      "x-transition:leave",
                      "transition ease-in duration-200 transform",
                    ),
                    attribute(
                      "x-transition:enter-end",
                      "opacity-100 translate-y-0 sm:scale-100",
                    ),
                    attribute(
                      "x-transition:enter-start",
                      "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
                    ),
                    attribute(
                      "x-transition:enter",
                      "transition ease-out duration-300 transform",
                    ),
                    attribute("x-show", "modelOpen"),
                    attribute("x-cloak", ""),
                  ],
                  [
                    html.div(
                      [
                        attribute.class(
                          "flex items-center justify-between space-x-4",
                        ),
                      ],
                      [
                        html.h1(
                          [
                            attribute.class(
                              "text-xl font-medium text-gray-800 ",
                            ),
                          ],
                          [
                            text(
                              int.to_string(post.year)
                              <> " Day "
                              <> int.to_string(post.day)
                              <> " Full Solution",
                            ),
                          ],
                        ),
                        html.button(
                          [
                            attribute.class(
                              "text-gray-600 focus:outline-none hover:text-gray-700",
                            ),
                            attribute("@click", "modelOpen = false"),
                          ],
                          [
                            html.svg(
                              [
                                attribute("stroke", "currentColor"),
                                attribute("viewBox", "0 0 24 24"),
                                attribute("fill", "none"),
                                attribute.class("w-6 h-6"),
                                attribute("xmlns", "http://www.w3.org/2000/svg"),
                              ],
                              [
                                element(
                                  "path",
                                  [
                                    attribute(
                                      "d",
                                      "M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z",
                                    ),
                                    attribute("stroke-width", "2"),
                                    attribute("stroke-linejoin", "round"),
                                    attribute("stroke-linecap", "round"),
                                  ],
                                  [],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    html.p([attribute.class("mt-2 text-sm text-gray-500 ")], [
                      text(
                        "Add your teammate to your team and start work to get things done
                ",
                      ),
                    ]),
                    html.form([attribute.class("mt-5")], [
                      html.div([], [
                        html.label(
                          [
                            attribute.class(
                              "block text-sm text-gray-700 capitalize dark:text-gray-200",
                            ),
                            attribute.for("user name"),
                          ],
                          [text("Teammate name")],
                        ),
                        html.input([
                          attribute.class(
                            "block w-full px-3 py-2 mt-2 text-gray-600 placeholder-gray-400 bg-white border border-gray-200 rounded-md focus:border-indigo-400 focus:outline-none focus:ring focus:ring-indigo-300 focus:ring-opacity-40",
                          ),
                          attribute.type_("text"),
                          attribute.placeholder("Arthur Melo"),
                        ]),
                      ]),
                      html.div([attribute.class("mt-4")], [
                        html.label(
                          [
                            attribute.class(
                              "block text-sm text-gray-700 capitalize dark:text-gray-200",
                            ),
                            attribute.for("email"),
                          ],
                          [text("Teammate email")],
                        ),
                        html.input([
                          attribute.class(
                            "block w-full px-3 py-2 mt-2 text-gray-600 placeholder-gray-400 bg-white border border-gray-200 rounded-md focus:border-indigo-400 focus:outline-none focus:ring focus:ring-indigo-300 focus:ring-opacity-40",
                          ),
                          attribute.type_("email"),
                          attribute.placeholder("arthurmelo@example.app"),
                        ]),
                      ]),
                      html.div([attribute.class("mt-4")], [
                        html.h1(
                          [
                            attribute.class(
                              "text-xs font-medium text-gray-400 uppercase",
                            ),
                          ],
                          [text("Permissions")],
                        ),
                        html.div([attribute.class("mt-4 space-y-5")], [
                          html.div(
                            [
                              attribute("@click", "show =!show"),
                              attribute("x-data", "{ show: true }"),
                              attribute.class(
                                "flex items-center space-x-3 cursor-pointer",
                              ),
                            ],
                            [
                              html.div(
                                [
                                  attribute(
                                    ":class",
                                    "[show ? 'bg-indigo-500' : 'bg-gray-300']",
                                  ),
                                  attribute.class(
                                    "relative w-10 h-5 transition duration-200 ease-linear rounded-full",
                                  ),
                                ],
                                [
                                  html.label(
                                    [
                                      attribute(
                                        ":class",
                                        "[show ? 'translate-x-full border-indigo-500' : 'translate-x-0 border-gray-300']",
                                      ),
                                      attribute.class(
                                        "absolute left-0 w-5 h-5 mb-2 transition duration-100 ease-linear transform bg-white border-2 rounded-full cursor-pointer",
                                      ),
                                      attribute("@click", "show =!show"),
                                      attribute.for("show"),
                                    ],
                                    [],
                                  ),
                                  html.input([
                                    attribute.class(
                                      "hidden w-full h-full rounded-full appearance-none active:outline-none focus:outline-none",
                                    ),
                                    attribute.name("show"),
                                    attribute.type_("checkbox"),
                                  ]),
                                ],
                              ),
                              html.p([attribute.class("text-gray-500")], [
                                text("Can make task"),
                              ]),
                            ],
                          ),
                          html.div(
                            [
                              attribute("@click", "show =!show"),
                              attribute("x-data", "{ show: false }"),
                              attribute.class(
                                "flex items-center space-x-3 cursor-pointer",
                              ),
                            ],
                            [
                              html.div(
                                [
                                  attribute(
                                    ":class",
                                    "[show ? 'bg-indigo-500' : 'bg-gray-300']",
                                  ),
                                  attribute.class(
                                    "relative w-10 h-5 transition duration-200 ease-linear rounded-full",
                                  ),
                                ],
                                [
                                  html.label(
                                    [
                                      attribute(
                                        ":class",
                                        "[show ? 'translate-x-full border-indigo-500' : 'translate-x-0 border-gray-300']",
                                      ),
                                      attribute.class(
                                        "absolute left-0 w-5 h-5 mb-2 transition duration-100 ease-linear transform bg-white border-2 rounded-full cursor-pointer",
                                      ),
                                      attribute("@click", "show =!show"),
                                      attribute.for("show"),
                                    ],
                                    [],
                                  ),
                                  html.input([
                                    attribute.class(
                                      "hidden w-full h-full rounded-full appearance-none active:outline-none focus:outline-none",
                                    ),
                                    attribute.name("show"),
                                    attribute.type_("checkbox"),
                                  ]),
                                ],
                              ),
                              html.p([attribute.class("text-gray-500")], [
                                text("Can delete task"),
                              ]),
                            ],
                          ),
                          html.div(
                            [
                              attribute("@click", "show =!show"),
                              attribute("x-data", "{ show: true }"),
                              attribute.class(
                                "flex items-center space-x-3 cursor-pointer",
                              ),
                            ],
                            [
                              html.div(
                                [
                                  attribute(
                                    ":class",
                                    "[show ? 'bg-indigo-500' : 'bg-gray-300']",
                                  ),
                                  attribute.class(
                                    "relative w-10 h-5 transition duration-200 ease-linear rounded-full",
                                  ),
                                ],
                                [
                                  html.label(
                                    [
                                      attribute(
                                        ":class",
                                        "[show ? 'translate-x-full border-indigo-500' : 'translate-x-0 border-gray-300']",
                                      ),
                                      attribute.class(
                                        "absolute left-0 w-5 h-5 mb-2 transition duration-100 ease-linear transform bg-white border-2 rounded-full cursor-pointer",
                                      ),
                                      attribute("@click", "show =!show"),
                                      attribute.for("show"),
                                    ],
                                    [],
                                  ),
                                  html.input([
                                    attribute.class(
                                      "hidden w-full h-full rounded-full appearance-none active:outline-none focus:outline-none",
                                    ),
                                    attribute.name("show"),
                                    attribute.type_("checkbox"),
                                  ]),
                                ],
                              ),
                              html.p([attribute.class("text-gray-500")], [
                                text("Can edit task"),
                              ]),
                            ],
                          ),
                        ]),
                      ]),
                      html.div([attribute.class("flex justify-end mt-6")], [
                        html.button(
                          [
                            attribute.class(
                              "px-3 py-2 text-sm tracking-wide text-white capitalize transition-colors duration-200 transform bg-indigo-500 rounded-md dark:bg-indigo-600 dark:hover:bg-indigo-700 dark:focus:bg-indigo-700 hover:bg-indigo-600 focus:outline-none focus:bg-indigo-500 focus:ring focus:ring-indigo-300 focus:ring-opacity-50",
                            ),
                            attribute.type_("button"),
                          ],
                          [
                            text(
                              "Invite Member
                        ",
                            ),
                          ],
                        ),
                      ]),
                    ]),
                  ],
                ),
              ],
            ),
          ],
        ),
        // ]),
      ]),
    ]),
  )
}

fn format_date(date: post.Date) -> String {
  let month = case date.month {
    1 -> "January"
    2 -> "February"
    3 -> "March"
    4 -> "April"
    5 -> "May"
    6 -> "June"
    7 -> "July"
    8 -> "August"
    9 -> "September"
    10 -> "October"
    11 -> "November"
    12 -> "December"
    _ -> panic as "Unknown month"
  }

  month <> " " <> int.to_string(date.day) <> ", " <> int.to_string(date.year)
}

fn difficulty_span(difficulty: post.Difficulty) -> Element(msg) {
  let #(name, color) = case difficulty {
    post.Easy -> #("Easy", "green")
    post.Medium -> #("Medium", "yellow")
    post.Hard -> #("Hard", "red")
  }
  span(
    [
      class(
        "mb-5 inline-block rounded-full bg-"
        <> color
        <> "-light px-2 py-1 font-body text-sm text-"
        <> color
        <> " sm:mb-8",
      ),
    ],
    [text(name)],
  )
}

fn post_title_block(post: Post) -> Element(msg) {
  div([class("border-b border-grey-lighter pb-8 sm:pb-12")], [
    difficulty_span(post.difficulty),
    h2(
      [
        class(
          "block font-body text-3xl font-semibold leading-tight text-primary dark:text-white sm:text-4xl md:text-5xl",
        ),
      ],
      [
        text(
          "Advent of Code "
          <> int.to_string(post.year)
          <> " Day "
          <> int.to_string(post.day),
        ),
      ],
    ),
    h3(
      [
        class(
          "block font-body text-2xl font-medium leading-tight text-primary dark:text-white sm:text-3xl md:text-4xl",
        ),
      ],
      [text(post.title)],
    ),
    div([class("pr-2 pt-3")], [
      span(
        [class("font-body text-xl font-light text-primary dark:text-white")],
        [text(post.description)],
      ),
    ]),
    div([class("flex items-center pt-5 sm:pt-8")], [
      p([class("pr-2 font-body font-light text-primary dark:text-white")], [
        text(format_date(post.post_date)),
      ]),
      span([class("vdark:text-white font-body text-grey")], [text("//")]),
      p([class("pl-2 font-body font-light text-primary dark:text-white")], [
        text(post.author),
      ]),
    ]),
  ])
}

fn html(
  base_path: String,
  title: String,
  description: String,
  content: Element(msg),
) -> Element(msg) {
  html.html([attribute("lang", "en")], [
    head(base_path, title, description),
    html.body(
      [
        class("dark:bg-primary"),
        attribute(
          ":class",
          "isMobileMenuOpen ? 'max-h-screen overflow-hidden relative' : ''",
        ),
        attribute("x-init", "themeInit()"),
        attribute("x-data", "global()"),
      ],
      [
        div([attribute.id("main")], [nav(base_path), content, footer(base_path)]),
        html.script([attribute.src(base_path <> "/js/main.js")], ""),
      ],
    ),
  ])
}

fn home_content(base_path: String) -> Element(msg) {
  div([], [
    div([class("container mx-auto")], [
      div([class("border-b border-grey-lighter py-16 lg:py-20")], [
        div([], [
          img([
            attribute.alt("author"),
            class("h-16 w-16"),
            attribute.src(base_path <> "/img/author.png"),
          ]),
        ]),
        h1(
          [
            class(
              "pt-3 font-body text-4xl font-semibold text-primary dark:text-white md:text-5xl lg:text-6xl",
            ),
          ],
          [text("Hi, I’m John Doe.")],
        ),
        p(
          [
            class(
              "pt-3 font-body text-xl font-light text-primary dark:text-white",
            ),
          ],
          [
            text(
              "A software engineer and open-source advocate enjoying the sunny life in Barcelona, Spain.",
            ),
          ],
        ),
        a(
          [
            class(
              "mt-12 block bg-secondary px-10 py-4 text-center font-body text-xl font-semibold text-white transition-colors hover:bg-green sm:inline-block sm:text-left sm:text-2xl",
            ),
            href("/"),
          ],
          [text("Say Hello!")],
        ),
      ]),
      div([class("border-b border-grey-lighter py-16 lg:py-20")], [
        div([class("flex items-center pb-6")], [
          img([
            attribute.alt("icon story"),
            attribute.src(base_path <> "/img/icon-story.png"),
          ]),
          h3(
            [
              class(
                "ml-3 font-body text-2xl font-semibold text-primary dark:text-white",
              ),
            ],
            [text("My Story")],
          ),
        ]),
        div([], [
          p([class("font-body font-light text-primary dark:text-white")], [
            text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
            ),
            html.br([]),
            html.br([]),
            text(
              "Maecenas accumsan lacus vel facilisis. Eget egestas purus viverra",
            ),
          ]),
        ]),
      ]),
      div([class("py-16 lg:py-20")], [
        div([class("flex items-center pb-6")], [
          img([
            attribute.alt("icon story"),
            attribute.src(base_path <> "/img/icon-story.png"),
          ]),
          h3(
            [
              class(
                "ml-3 font-body text-2xl font-semibold text-primary dark:text-white",
              ),
            ],
            [text("My Story")],
          ),
          a(
            [
              class(
                "flex items-center pl-10 font-body italic text-green transition-colors hover:text-secondary dark:text-green-light dark:hover:text-secondary",
              ),
              href(base_path <> "/blog"),
            ],
            [
              text("All posts"),
              img([
                attribute.alt("arrow right"),
                class("ml-3"),
                attribute.src("./img/long-arrow-right.png"),
              ]),
            ],
          ),
        ]),
        div([class("pt-8")], [
          div([class("border-b border-grey-lighter pb-8")], [
            span(
              [
                class(
                  "mb-4 inline-block rounded-full bg-green-light px-2 py-1 font-body text-sm text-green",
                ),
              ],
              [text("category")],
            ),
            a(
              [
                class(
                  "block font-body text-lg font-semibold text-primary transition-colors hover:text-green dark:text-white dark:hover:text-secondary",
                ),
                href(base_path <> "/post"),
              ],
              [
                text(
                  "Quis hendrerit dolor magna eget est lorem ipsum dolor sit",
                ),
              ],
            ),
            div([class("flex items-center pt-4")], [
              p(
                [
                  class(
                    "pr-2 font-body font-light text-primary dark:text-white",
                  ),
                ],
                [text("July 19, 2020")],
              ),
              span([class("font-body text-grey dark:text-white")], [text("//")]),
              p(
                [
                  class(
                    "pl-2 font-body font-light text-primary dark:text-white",
                  ),
                ],
                [text("4 min read")],
              ),
            ]),
          ]),
          div([class("border-b border-grey-lighter pt-10 pb-8")], [
            div([class("flex items-center")], [
              span(
                [
                  class(
                    "mb-4 inline-block rounded-full bg-grey-light px-2 py-1 font-body text-sm text-blue-dark",
                  ),
                ],
                [text("category")],
              ),
              span(
                [
                  class(
                    "mb-4 ml-4 inline-block rounded-full bg-yellow-light px-2 py-1 font-body text-sm text-yellow-dark",
                  ),
                ],
                [text("category")],
              ),
            ]),
            a(
              [
                class(
                  "block font-body text-lg font-semibold text-primary transition-colors hover:text-green dark:text-white dark:hover:text-secondary",
                ),
                href(base_path <> "/post"),
              ],
              [
                text(
                  "Senectus et netus et malesuada fames ac turpis egestas integer",
                ),
              ],
            ),
            div([class("flex items-center pt-4")], [
              p(
                [
                  class(
                    "pr-2 font-body font-light text-primary dark:text-white",
                  ),
                ],
                [text("June 30, 2020")],
              ),
              span([class("font-body text-grey dark:text-white")], [text("//")]),
              p(
                [
                  class(
                    "pl-2 font-body font-light text-primary dark:text-white",
                  ),
                ],
                [text("5 min read")],
              ),
            ]),
          ]),
          div([class("border-b border-grey-lighter pt-10 pb-8")], [
            span(
              [
                class(
                  "mb-4 inline-block rounded-full bg-blue-light px-2 py-1 font-body text-sm text-blue",
                ),
              ],
              [text("category")],
            ),
            a(
              [
                class(
                  "block font-body text-lg font-semibold text-primary transition-colors hover:text-green dark:text-white dark:hover:text-secondary",
                ),
                href(base_path <> "/post"),
              ],
              [
                text(
                  "Vulputate ut pharetra sit amet aliquam id diam maecenas ultricies",
                ),
              ],
            ),
            div([class("flex items-center pt-4")], [
              p(
                [
                  class(
                    "pr-2 font-body font-light text-primary dark:text-white",
                  ),
                ],
                [text("June 26, 2020")],
              ),
              span([class("font-body text-grey dark:text-white")], [text("//")]),
              p(
                [
                  class(
                    "pl-2 font-body font-light text-primary dark:text-white",
                  ),
                ],
                [text("3 min read")],
              ),
            ]),
          ]),
        ]),
      ]),
      div([class("pb-16 lg:pb-20")], [
        div([class("flex items-center pb-6")], [
          img([
            attribute.alt("icon story"),
            attribute.src("./img/icon-project.png"),
          ]),
          h3(
            [
              class(
                "ml-3 font-body text-2xl font-semibold text-primary dark:text-white",
              ),
            ],
            [text("My Projects")],
          ),
        ]),
        div([], [
          a(
            [
              class(
                "mb-6 flex items-center justify-between border border-grey-lighter px-4 py-4 sm:px-6",
              ),
              href(" / "),
            ],
            [
              span([class("w-9/10 pr-8")], [
                h4(
                  [
                    class(
                      "font-body text-lg font-semibold text-primary dark:text-white",
                    ),
                  ],
                  [text("TailwindCSS")],
                ),
                p([class("font-body font-light text-primary dark:text-white")], [
                  text(
                    "Rapidly build modern websites without ever leaving your HTML.",
                  ),
                ]),
              ]),
              span([class("w-1/10")], [
                img([
                  attribute.alt("chevron right"),
                  class("mx-auto"),
                  attribute.src("./img/chevron-right.png"),
                ]),
              ]),
            ],
          ),
          a(
            [
              class(
                "mb-6 flex items-center justify-between border border-grey-lighter px-4 py-4 sm:px-6",
              ),
              href(" / "),
            ],
            [
              span([class("w-9/10 pr-8")], [
                h4(
                  [
                    class(
                      "font-body text-lg font-semibold text-primary dark:text-white",
                    ),
                  ],
                  [text("Maizzle")],
                ),
                p([class("font-body font-light text-primary dark:text-white")], [
                  text("Framework for Rapid Email Prototyping"),
                ]),
              ]),
              span([class("w-1/10")], [
                img([
                  attribute.alt("chevron right"),
                  class("mx-auto"),
                  attribute.src("./img/chevron-right.png"),
                ]),
              ]),
            ],
          ),
          a(
            [
              class(
                "mb-6 flex items-center justify-between border border-grey-lighter px-4 py-4 sm:px-6",
              ),
              href(" / "),
            ],
            [
              span([class("w-9/10 pr-8")], [
                h4(
                  [
                    class(
                      "font-body text-lg font-semibold text-primary dark:text-white",
                    ),
                  ],
                  [text("Alpine.js")],
                ),
                p([class("font-body font-light text-primary dark:text-white")], [
                  text("Think of it like Tailwind for JavaScript."),
                ]),
              ]),
              span([class("w-1/10")], [
                img([
                  attribute.alt("chevron right"),
                  class("mx-auto"),
                  attribute.src("./img/chevron-right.png"),
                ]),
              ]),
            ],
          ),
          a(
            [
              class(
                "mb-6 flex items-center justify-between border border-grey-lighter px-4 py-4 sm:px-6",
              ),
              href(" / "),
            ],
            [
              span([class("w-9/10 pr-8")], [
                h4(
                  [
                    class(
                      "font-body text-lg font-semibold text-primary dark:text-white",
                    ),
                  ],
                  [text("PostCSS")],
                ),
                p([class("font-body font-light text-primary dark:text-white")], [
                  text("A tool for transforming CSS with JavaScript"),
                ]),
              ]),
              span([class("w-1/10")], [
                img([
                  attribute.alt("chevron right"),
                  class("mx-auto"),
                  attribute.src("./img/chevron-right.png"),
                ]),
              ]),
            ],
          ),
        ]),
      ]),
    ]),
  ])
}

fn head(base_path: String, title: String, description: String) -> Element(msg) {
  html.head([], [
    html.meta([attribute("charset", "utf-8")]),
    html.meta([
      attribute("http-equiv", "X-UA-Compatible"),
      attribute("content", "IE=edge,chrome=1"),
    ]),
    html.meta([
      attribute.name("viewport"),
      attribute(
        "content",
        "width=device-width, initial-scale=1, shrink-to-fit=no",
      ),
    ]),
    html.title([], title),
    html.meta([attribute("content", title), attribute("property", "og:title")]),
    html.meta([
      attribute("content", "en_US"),
      attribute("property", "og:locale"),
    ]),
    html.meta([attribute("content", description), attribute.name("description")]),
    html.link([
      href(base_path <> "/img/favicon.png"),
      attribute.type_("image/png"),
      attribute.rel("icon"),
    ]),
    html.meta([
      attribute("content", "Advent of Gleam"),
      attribute("property", "og:site_name"),
    ]),
    html.link([
      attribute.rel("preconnect"),
      href("https://fonts.gstatic.com"),
      attribute("crossorigin", "crossorigin"),
    ]),
    html.link([
      attribute.rel("preload"),
      href(
        "https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap",
      ),
      attribute("as", "style"),
    ]),
    html.link([
      attribute.rel("stylesheet"),
      href(
        "https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap",
      ),
    ]),
    html.link([
      href("https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css"),
      attribute.rel("stylesheet"),
    ]),
    html.link([
      attribute.rel("stylesheet"),
      attribute("media", "screen"),
      href(base_path <> "/css/app.css"),
      // attribute("crossorigin", "anonymous"),
    ]),
    html.script(
      [
        attribute.src(
          "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.5.0/highlight.min.js",
        ),
      ],
      "",
    ),
    html.link([
      href(
        "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.5.0/styles/atom-one-dark.min.css",
      ),
      attribute.rel("stylesheet"),
    ]),
    html.script([], "hljs.initHighlightingOnLoad();"),
    html.script(
      [
        attribute("defer", ""),
        attribute.src("https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"),
      ],
      "",
    ),
    html.style([], "[x-cloak] { display: none }"),
  ])
}

fn nav(base_path: String) -> Element(msg) {
  html.nav([], [
    div([class("container mx-auto")], [
      div([class("flex items-center justify-between py-6 lg:py-10")], [
        a([class("flex items-center"), href("/")], [
          span([class("mr-2"), href("/")], [
            img([
              attribute.alt("logo"),
              attribute.src(base_path <> "/img/logo.svg"),
            ]),
          ]),
          p(
            [
              class(
                "hidden font-body text-2xl font-bold text-primary dark:text-white lg:block",
              ),
            ],
            [text("Advent of Gleam")],
          ),
        ]),
        div([class("flex items-center lg:hidden")], [
          i(
            [
              attribute(":class", "isDarkMode ? 'bxs-sun' : 'bxs-moon'"),
              attribute("@click", "themeSwitch()"),
              class(
                "bx mr-8 cursor-pointer text-3xl text-primary dark:text-white",
              ),
            ],
            [],
          ),
          html.svg(
            [
              class("fill-current text-primary dark:text-white"),
              attribute("@click", "isMobileMenuOpen = true"),
              attribute("xmlns", "http://www.w3.org/2000/svg"),
              attribute.height(15),
              attribute.width(24),
            ],
            [
              element("g", [attribute("fill-rule", "evenodd")], [
                element(
                  "rect",
                  [
                    attribute("rx", "1.5"),
                    attribute.height(3),
                    attribute.width(24),
                  ],
                  [],
                ),
                element(
                  "rect",
                  [
                    attribute("rx", "1.5"),
                    attribute.height(3),
                    attribute.width(16),
                    attribute("y", "6"),
                    attribute("x", "8"),
                  ],
                  [],
                ),
                element(
                  "rect",
                  [
                    attribute("rx", "1.5"),
                    attribute.height(3),
                    attribute.width(20),
                    attribute("y", "12"),
                    attribute("x", "4"),
                  ],
                  [],
                ),
              ]),
            ],
          ),
        ]),
        div([class("hidden lg:block")], [
          ul([class("flex items-center")], [
            li([class("group relative mr-6 mb-1")], [
              div(
                [
                  class(
                    "absolute left-0 bottom-0 z-20 h-0 w-full opacity-75 transition-all group-hover:h-2 group-hover:bg-yellow",
                  ),
                ],
                [],
              ),
              a(
                [
                  class(
                    "relative z-30 block px-2 font-body text-lg font-medium text-primary transition-colors group-hover:text-green dark:text-white dark:group-hover:text-secondary",
                  ),
                  href("/"),
                ],
                [text("Intro")],
              ),
            ]),
            li([class("group relative mr-6 mb-1")], [
              div(
                [
                  class(
                    "absolute left-0 bottom-0 z-20 h-0 w-full opacity-75 transition-all group-hover:h-2 group-hover:bg-yellow",
                  ),
                ],
                [],
              ),
              a(
                [
                  class(
                    "relative z-30 block px-2 font-body text-lg font-medium text-primary transition-colors group-hover:text-green dark:text-white dark:group-hover:text-secondary",
                  ),
                  href(base_path <> "/blog"),
                ],
                [text("Blog")],
              ),
            ]),
            li([class("group relative mr-6 mb-1")], [
              div(
                [
                  class(
                    "absolute left-0 bottom-0 z-20 h-0 w-full opacity-75 transition-all group-hover:h-2 group-hover:bg-yellow",
                  ),
                ],
                [],
              ),
              a(
                [
                  class(
                    "relative z-30 block px-2 font-body text-lg font-medium text-primary transition-colors group-hover:text-green dark:text-white dark:group-hover:text-secondary",
                  ),
                  href(base_path <> "/uses"),
                ],
                [text("Uses")],
              ),
            ]),
            li([class("group relative mr-6 mb-1")], [
              div(
                [
                  class(
                    "absolute left-0 bottom-0 z-20 h-0 w-full opacity-75 transition-all group-hover:h-2 group-hover:bg-yellow",
                  ),
                ],
                [],
              ),
              a(
                [
                  class(
                    "relative z-30 block px-2 font-body text-lg font-medium text-primary transition-colors group-hover:text-green dark:text-white dark:group-hover:text-secondary",
                  ),
                  href(base_path <> "/contact"),
                ],
                [text("Contact")],
              ),
            ]),
            li([], [
              i(
                [
                  attribute(":class", "isDarkMode ? 'bxs-sun' : 'bxs-moon'"),
                  attribute("@click", "themeSwitch()"),
                  class(
                    "bx cursor-pointer text-3xl text-primary dark:text-white",
                  ),
                ],
                [],
              ),
            ]),
          ]),
        ]),
      ]),
    ]),
    div(
      [
        attribute(
          ":class",
          "isMobileMenuOpen ? 'opacity-100 pointer-events-auto' : ''",
        ),
        class(
          "pointer-events-none fixed inset-0 z-50 flex bg-black bg-opacity-80 opacity-0 transition-opacity lg:hidden",
        ),
      ],
      [
        div([class("ml-auto w-2/3 bg-green p-4 md:w-1/3")], [
          i(
            [
              attribute("@click", "isMobileMenuOpen = false"),
              class(
                "bx bx-x absolute top-0 right-0 mt-4 mr-4 text-4xl text-white",
              ),
            ],
            [],
          ),
          ul([class("mt-8 flex flex-col")], [
            li([class("")], [
              a(
                [
                  class(
                    "mb-3 block px-2 font-body text-lg font-medium text-white",
                  ),
                  href(base_path <> "/"),
                ],
                [text("Intro")],
              ),
            ]),
            li([class("")], [
              a(
                [
                  class(
                    "mb-3 block px-2 font-body text-lg font-medium text-white",
                  ),
                  href(base_path <> "/blog"),
                ],
                [text("Blog")],
              ),
            ]),
            li([class("")], [
              a(
                [
                  class(
                    "mb-3 block px-2 font-body text-lg font-medium text-white",
                  ),
                  href(base_path <> "/uses"),
                ],
                [text("Uses")],
              ),
            ]),
            li([class("")], [
              a(
                [
                  class(
                    "mb-3 block px-2 font-body text-lg font-medium text-white",
                  ),
                  href(base_path <> "/contact"),
                ],
                [text("Contact")],
              ),
            ]),
          ]),
        ]),
      ],
    ),
  ])
}

fn footer(base_path: String) -> Element(msg) {
  div([class("container mx-auto")], [
    div(
      [
        class(
          "flex flex-col items-center justify-between border-t border-grey-lighter py-10 sm:flex-row sm:py-12",
        ),
      ],
      [
        div([class("mr-auto flex flex-col items-center sm:flex-row")], [
          a([class("mr-auto sm:mr-6"), href(base_path <> "/")], [
            img([
              attribute.alt("logo"),
              attribute.src(base_path <> "/img/logo.svg"),
            ]),
          ]),
          p(
            [
              class(
                "pt-5 font-body font-light text-primary dark:text-white sm:pt-0",
              ),
            ],
            [text("©2024 Paul Foster.")],
          ),
        ]),
        div([class("mr-auto flex items-center pt-5 sm:mr-0 sm:pt-0")], [
          a([attribute.target("_blank"), href("https://github.com/pf981 ")], [
            i(
              [
                class(
                  "text-4xl text-primary dark:text-white pl-5 hover:text-secondary dark:hover:text-secondary transition-colors bx bxl-github",
                ),
              ],
              [],
            ),
          ]),
          a(
            [
              attribute.target("_blank"),
              href("https://stackoverflow.com/users/1751961/paul"),
            ],
            [
              i(
                [
                  class(
                    "text-4xl text-primary dark:text-white pl-5 hover:text-secondary dark:hover:text-secondary transition-colors bx bxl-stack-overflow",
                  ),
                ],
                [],
              ),
            ],
          ),
          a(
            [
              attribute.target("_blank"),
              href("https://www.linkedin.com/in/paulfoster01/"),
            ],
            [
              i(
                [
                  class(
                    "text-4xl text-primary dark:text-white pl-5 hover:text-secondary dark:hover:text-secondary transition-colors bx bxl-linkedin",
                  ),
                ],
                [],
              ),
            ],
          ),
        ]),
      ],
    ),
  ])
}
