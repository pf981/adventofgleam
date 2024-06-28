import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

import lustre/attribute.{attribute}
import lustre/element.{type Element, element}

import lustre/element/html.{html, text}
import lustre/ssg

// import lustre/ui
// import lustre/ui/util/cn

import tailwind

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
    }
  }
}

// fn page(title: String) -> Element(msg) {
//   let content =
//     ui.stack([attribute.style([#("width", "60ch"), #("margin", "auto")])], [
//       html.h1([cn.text_2xl()], [html.text("Universal components")]),
//       html.p([], [
//         html.text("In Lustre, applications are built around the "),
//         html.text("MVU architecture with a model representing "),
//         html.text("program state, a view function to render "),
//         html.text("that state, and an update function to handle "),
//         html.text("events and update that state."),
//       ]),
//       html.p([], [
//         html.text("These three building blocks are encapsulated "),
//         html.text("by the `App` type. Lustre's secret weapon is "),
//         html.text("that the same app can be run multiple ways "),
//         html.text("without changing the core app code."),
//       ]),
//       html.p([attribute.class("bg-black")], [
//         html.text("Below, we have a counter app rendered three "),
//         html.text("different ways. Once as a traditional client "),
//         html.text("side app - suitable as a SPA. Then that "),
//         html.text("counter has been bundled as a Custom Element "),
//         html.text("and rendered as a <counter-component>. And "),
//         html.text("finally as a server component. Here all of "),
//         html.text("component's logic and rendering happens on "),
//         html.text("the server and a tiny (<6kb!) runtime "),
//         html.text("patches the DOM in the browser."),
//       ]),
//       html.p([], [
//         html.text("For the two component versions of the app, "),
//         html.text("try opening your browser's dev tools and "),
//         html.text("setting the `count` attribute for each "),
//         html.text("component. You can also attach event "),
//         html.text("listeners and listen for 'incr' and 'decr' "),
//         html.text("events."),
//       ]),
//     ])

//   html([attribute("lang", "en"), attribute.class("overflow-x-hidden")], [
//     html.head([], [
//       html.title([], title),
//       html.meta([attribute("charset", "utf-8")]),
//       html.meta([
//         attribute("name", "viewport"),
//         attribute("content", "width=device-width, initial-scale=1"),
//       ]),
//       // html.link([attribute.href("./pico.min.css"), attribute.rel("stylesheet")]),
//       // html.link([attribute.href("./lustre-ui.css"), attribute.rel("stylesheet")]),
//       html.link([attribute.href("./css/app.css"), attribute.rel("stylesheet")]),
//       html.style(
//         [],
//         " body > div {
//                 max-width: 60ch;
//                 margin: 0 auto;
//                 padding-top: 2rem;
//               }
//             ",
//       ),
//     ]),
//     html.body([], [content]),
//     // html.body([], [text("Hello world!")]),
//   ])
// }

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

fn page(title: String) -> Element(msg) {
  html.html([attribute("lang", "en")], [
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
      html.title([], "Homepage | Atlas Template"),
      html.meta([
        attribute("content", "Homepage | Atlas Template"),
        attribute("property", "og:title"),
      ]),
      html.meta([
        attribute("content", "en_US"),
        attribute("property", "og:locale"),
      ]),
      html.link([
        attribute.href("https://atlas.tailwindmade.com/"),
        attribute.rel("canonical"),
      ]),
      html.meta([
        attribute("content", "https://atlas.tailwindmade.com/"),
        attribute("property", "og:url"),
      ]),
      html.meta([
        attribute(
          "content",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        ),
        attribute.name("description"),
      ]),
      html.link([
        attribute.href("./img/favicon.png"),
        attribute.type_("image/png"),
        attribute.rel("icon"),
      ]),
      html.meta([
        attribute("content", "Atlas Template"),
        attribute("property", "og:site_name"),
      ]),
      html.meta([
        attribute("content", "https://atlas.tailwindmade.com./img/social.jpg"),
        attribute("property", "og:image"),
      ]),
      html.meta([
        attribute("content", "summary_large_image"),
        attribute.name("twitter:card"),
      ]),
      html.meta([
        attribute("content", "@tailwindmade"),
        attribute.name("twitter:site"),
      ]),
      html.link([
        attribute.rel("preconnect"),
        attribute.href("https://fonts.gstatic.com"),
        attribute("crossorigin", "crossorigin"),
      ]),
      html.link([
        attribute.rel("preload"),
        attribute.href(
          "https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap",
        ),
        attribute("as", "style"),
      ]),
      html.link([
        attribute.rel("stylesheet"),
        attribute.href(
          "https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap",
        ),
      ]),
      html.link([
        attribute.href("https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css"),
        attribute.rel("stylesheet"),
      ]),
      html.link([
        attribute.rel("stylesheet"),
        attribute("media", "screen"),
        attribute.href("./css/app.css"),
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
        attribute.href(
          "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.5.0/styles/atom-one-dark.min.css",
        ),
        attribute.rel("stylesheet"),
      ]),
      html.script(
        [],
        "hljs.initHighlightingOnLoad();
  ",
      ),
      html.script(
        [
          attribute("defer", ""),
          attribute.src("https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"),
        ],
        "",
      ),
    ]),
    html.body(
      [
        attribute.class("dark:bg-primary"),
        attribute(
          ":class",
          "isMobileMenuOpen ? 'max-h-screen overflow-hidden relative' : ''",
        ),
        attribute("x-init", "themeInit()"),
        attribute("x-data", "global()"),
      ],
      [
        html.div([attribute.id("main")], [
          html.div([attribute.class("container mx-auto")], [
            html.div(
              [
                attribute.class(
                  "flex items-center justify-between py-6 lg:py-10",
                ),
              ],
              [
                html.a(
                  [attribute.class("flex items-center"), attribute.href("/")],
                  [
                    html.span([attribute.class("mr-2"), attribute.href("/")], [
                      html.img([
                        attribute.alt("logo"),
                        attribute.src("./img/logo.svg"),
                      ]),
                    ]),
                    html.p(
                      [
                        attribute.class(
                          "hidden font-body text-2xl font-bold text-primary dark:text-white lg:block",
                        ),
                      ],
                      [
                        text(
                          "John Doe
      ",
                        ),
                      ],
                    ),
                  ],
                ),
                html.div([attribute.class("flex items-center lg:hidden")], [
                  html.i(
                    [
                      attribute(":class", "isDarkMode ? 'bxs-sun' : 'bxs-moon'"),
                      attribute("@click", "themeSwitch()"),
                      attribute.class(
                        "bx mr-8 cursor-pointer text-3xl text-primary dark:text-white",
                      ),
                    ],
                    [],
                  ),
                  html.svg(
                    [
                      attribute.class(
                        "fill-current text-primary dark:text-white",
                      ),
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
                html.div([attribute.class("hidden lg:block")], [
                  html.ul([attribute.class("flex items-center")], [
                    html.li([attribute.class("group relative mr-6 mb-1")], [
                      html.div(
                        [
                          attribute.class(
                            "absolute left-0 bottom-0 z-20 h-0 w-full opacity-75 transition-all group-hover:h-2 group-hover:bg-yellow",
                          ),
                        ],
                        [],
                      ),
                      html.a(
                        [
                          attribute.class(
                            "relative z-30 block px-2 font-body text-lg font-medium text-primary transition-colors group-hover:text-green dark:text-white dark:group-hover:text-secondary",
                          ),
                          attribute.href("/"),
                        ],
                        [text("Intro")],
                      ),
                    ]),
                    html.li([attribute.class("group relative mr-6 mb-1")], [
                      html.div(
                        [
                          attribute.class(
                            "absolute left-0 bottom-0 z-20 h-0 w-full opacity-75 transition-all group-hover:h-2 group-hover:bg-yellow",
                          ),
                        ],
                        [],
                      ),
                      html.a(
                        [
                          attribute.class(
                            "relative z-30 block px-2 font-body text-lg font-medium text-primary transition-colors group-hover:text-green dark:text-white dark:group-hover:text-secondary",
                          ),
                          attribute.href("/blog"),
                        ],
                        [text("Blog")],
                      ),
                    ]),
                    html.li([attribute.class("group relative mr-6 mb-1")], [
                      html.div(
                        [
                          attribute.class(
                            "absolute left-0 bottom-0 z-20 h-0 w-full opacity-75 transition-all group-hover:h-2 group-hover:bg-yellow",
                          ),
                        ],
                        [],
                      ),
                      html.a(
                        [
                          attribute.class(
                            "relative z-30 block px-2 font-body text-lg font-medium text-primary transition-colors group-hover:text-green dark:text-white dark:group-hover:text-secondary",
                          ),
                          attribute.href("/uses"),
                        ],
                        [text("Uses")],
                      ),
                    ]),
                    html.li([attribute.class("group relative mr-6 mb-1")], [
                      html.div(
                        [
                          attribute.class(
                            "absolute left-0 bottom-0 z-20 h-0 w-full opacity-75 transition-all group-hover:h-2 group-hover:bg-yellow",
                          ),
                        ],
                        [],
                      ),
                      html.a(
                        [
                          attribute.class(
                            "relative z-30 block px-2 font-body text-lg font-medium text-primary transition-colors group-hover:text-green dark:text-white dark:group-hover:text-secondary",
                          ),
                          attribute.href("/contact"),
                        ],
                        [text("Contact")],
                      ),
                    ]),
                    html.li([], [
                      html.i(
                        [
                          attribute(
                            ":class",
                            "isDarkMode ? 'bxs-sun' : 'bxs-moon'",
                          ),
                          attribute("@click", "themeSwitch()"),
                          attribute.class(
                            "bx cursor-pointer text-3xl text-primary dark:text-white",
                          ),
                        ],
                        [],
                      ),
                    ]),
                  ]),
                ]),
              ],
            ),
          ]),
          html.div(
            [
              attribute(
                ":class",
                "isMobileMenuOpen ? 'opacity-100 pointer-events-auto' : ''",
              ),
              attribute.class(
                "pointer-events-none fixed inset-0 z-50 flex bg-black bg-opacity-80 opacity-0 transition-opacity lg:hidden",
              ),
            ],
            [
              html.div(
                [attribute.class("ml-auto w-2/3 bg-green p-4 md:w-1/3")],
                [
                  html.i(
                    [
                      attribute("@click", "isMobileMenuOpen = false"),
                      attribute.class(
                        "bx bx-x absolute top-0 right-0 mt-4 mr-4 text-4xl text-white",
                      ),
                    ],
                    [],
                  ),
                  html.ul([attribute.class("mt-8 flex flex-col")], [
                    html.li([attribute.class("")], [
                      html.a(
                        [
                          attribute.class(
                            "mb-3 block px-2 font-body text-lg font-medium text-white",
                          ),
                          attribute.href("/"),
                        ],
                        [text("Intro")],
                      ),
                    ]),
                    html.li([attribute.class("")], [
                      html.a(
                        [
                          attribute.class(
                            "mb-3 block px-2 font-body text-lg font-medium text-white",
                          ),
                          attribute.href("/blog"),
                        ],
                        [text("Blog")],
                      ),
                    ]),
                    html.li([attribute.class("")], [
                      html.a(
                        [
                          attribute.class(
                            "mb-3 block px-2 font-body text-lg font-medium text-white",
                          ),
                          attribute.href("/uses"),
                        ],
                        [text("Uses")],
                      ),
                    ]),
                    html.li([attribute.class("")], [
                      html.a(
                        [
                          attribute.class(
                            "mb-3 block px-2 font-body text-lg font-medium text-white",
                          ),
                          attribute.href("/contact"),
                        ],
                        [text("Contact")],
                      ),
                    ]),
                  ]),
                ],
              ),
            ],
          ),
          html.div([], [
            html.div([attribute.class("container mx-auto")], [
              html.div(
                [attribute.class("border-b border-grey-lighter py-16 lg:py-20")],
                [
                  html.div([], [
                    html.img([
                      attribute.alt("author"),
                      attribute.class("h-16 w-16"),
                      attribute.src("./img/author.png"),
                    ]),
                  ]),
                  html.h1(
                    [
                      attribute.class(
                        "pt-3 font-body text-4xl font-semibold text-primary dark:text-white md:text-5xl lg:text-6xl",
                      ),
                    ],
                    [
                      text(
                        "Hi, I’m John Doe.
    ",
                      ),
                    ],
                  ),
                  html.p(
                    [
                      attribute.class(
                        "pt-3 font-body text-xl font-light text-primary dark:text-white",
                      ),
                    ],
                    [
                      text(
                        "A software engineer and open-source advocate enjoying the sunny life in Barcelona, Spain.
    ",
                      ),
                    ],
                  ),
                  html.a(
                    [
                      attribute.class(
                        "mt-12 block bg-secondary px-10 py-4 text-center font-body text-xl font-semibold text-white transition-colors hover:bg-green sm:inline-block sm:text-left sm:text-2xl",
                      ),
                      attribute.href("/"),
                    ],
                    [
                      text(
                        "Say Hello!
    ",
                      ),
                    ],
                  ),
                ],
              ),
              html.div(
                [attribute.class("border-b border-grey-lighter py-16 lg:py-20")],
                [
                  html.div([attribute.class("flex items-center pb-6")], [
                    html.img([
                      attribute.alt("icon story"),
                      attribute.src("./img/icon-story.png"),
                    ]),
                    html.h3(
                      [
                        attribute.class(
                          "ml-3 font-body text-2xl font-semibold text-primary dark:text-white",
                        ),
                      ],
                      [
                        text(
                          "My Story
      ",
                        ),
                      ],
                    ),
                  ]),
                  html.div([], [
                    html.p(
                      [
                        attribute.class(
                          "font-body font-light text-primary dark:text-white",
                        ),
                      ],
                      [
                        text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Nibh mauris cursus
        mattis molestie. Et leo duis ut diam. Sit amet tellus cras adipiscing
        enim eu turpis. Adipiscing at in tellus integer feugiat.
        ",
                        ),
                        html.br([]),
                        html.br([]),
                        text(
                          "Maecenas accumsan lacus vel facilisis. Eget egestas purus viverra
        accumsan in nisl nisi scelerisque eu. Non tellus orci ac auctor augue
        mauris augue neque gravida. Auctor augue mauris augue neque gravida in
        fermentum et sollicitudin. Tempus urna et pharetra pharetra massa massa
        ultricies mi quis. Amet mauris commodo quis imperdiet massa. Integer
        vitae justo eget magna fermentum iaculis eu non.
      ",
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
              html.div([attribute.class("py-16 lg:py-20")], [
                html.div([attribute.class("flex items-center pb-6")], [
                  html.img([
                    attribute.alt("icon story"),
                    attribute.src("./img/icon-story.png"),
                  ]),
                  html.h3(
                    [
                      attribute.class(
                        "ml-3 font-body text-2xl font-semibold text-primary dark:text-white",
                      ),
                    ],
                    [
                      text(
                        "My Story
      ",
                      ),
                    ],
                  ),
                  html.a(
                    [
                      attribute.class(
                        "flex items-center pl-10 font-body italic text-green transition-colors hover:text-secondary dark:text-green-light dark:hover:text-secondary",
                      ),
                      attribute.href("/blog"),
                    ],
                    [
                      text(
                        "All posts
        ",
                      ),
                      html.img([
                        attribute.alt("arrow right"),
                        attribute.class("ml-3"),
                        attribute.src("./img/long-arrow-right.png"),
                      ]),
                    ],
                  ),
                ]),
                html.div([attribute.class("pt-8")], [
                  html.div(
                    [attribute.class("border-b border-grey-lighter pb-8")],
                    [
                      html.span(
                        [
                          attribute.class(
                            "mb-4 inline-block rounded-full bg-green-light px-2 py-1 font-body text-sm text-green",
                          ),
                        ],
                        [text("category")],
                      ),
                      html.a(
                        [
                          attribute.class(
                            "block font-body text-lg font-semibold text-primary transition-colors hover:text-green dark:text-white dark:hover:text-secondary",
                          ),
                          attribute.href("/post"),
                        ],
                        [
                          text(
                            "Quis hendrerit dolor magna eget est lorem ipsum dolor sit",
                          ),
                        ],
                      ),
                      html.div([attribute.class("flex items-center pt-4")], [
                        html.p(
                          [
                            attribute.class(
                              "pr-2 font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "July 19, 2020
          ",
                            ),
                          ],
                        ),
                        html.span(
                          [
                            attribute.class(
                              "font-body text-grey dark:text-white",
                            ),
                          ],
                          [text("//")],
                        ),
                        html.p(
                          [
                            attribute.class(
                              "pl-2 font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "4 min read
          ",
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                  html.div(
                    [attribute.class("border-b border-grey-lighter pt-10 pb-8")],
                    [
                      html.div([attribute.class("flex items-center")], [
                        html.span(
                          [
                            attribute.class(
                              "mb-4 inline-block rounded-full bg-grey-light px-2 py-1 font-body text-sm text-blue-dark",
                            ),
                          ],
                          [text("category")],
                        ),
                        html.span(
                          [
                            attribute.class(
                              "mb-4 ml-4 inline-block rounded-full bg-yellow-light px-2 py-1 font-body text-sm text-yellow-dark",
                            ),
                          ],
                          [text("category")],
                        ),
                      ]),
                      html.a(
                        [
                          attribute.class(
                            "block font-body text-lg font-semibold text-primary transition-colors hover:text-green dark:text-white dark:hover:text-secondary",
                          ),
                          attribute.href("/post"),
                        ],
                        [
                          text(
                            "Senectus et netus et malesuada fames ac turpis egestas integer",
                          ),
                        ],
                      ),
                      html.div([attribute.class("flex items-center pt-4")], [
                        html.p(
                          [
                            attribute.class(
                              "pr-2 font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "June 30, 2020
          ",
                            ),
                          ],
                        ),
                        html.span(
                          [
                            attribute.class(
                              "font-body text-grey dark:text-white",
                            ),
                          ],
                          [text("//")],
                        ),
                        html.p(
                          [
                            attribute.class(
                              "pl-2 font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "5 min read
          ",
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                  html.div(
                    [attribute.class("border-b border-grey-lighter pt-10 pb-8")],
                    [
                      html.span(
                        [
                          attribute.class(
                            "mb-4 inline-block rounded-full bg-blue-light px-2 py-1 font-body text-sm text-blue",
                          ),
                        ],
                        [text("category")],
                      ),
                      html.a(
                        [
                          attribute.class(
                            "block font-body text-lg font-semibold text-primary transition-colors hover:text-green dark:text-white dark:hover:text-secondary",
                          ),
                          attribute.href("/post"),
                        ],
                        [
                          text(
                            "Vulputate ut pharetra sit amet aliquam id diam maecenas ultricies",
                          ),
                        ],
                      ),
                      html.div([attribute.class("flex items-center pt-4")], [
                        html.p(
                          [
                            attribute.class(
                              "pr-2 font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "June 26, 2020
          ",
                            ),
                          ],
                        ),
                        html.span(
                          [
                            attribute.class(
                              "font-body text-grey dark:text-white",
                            ),
                          ],
                          [text("//")],
                        ),
                        html.p(
                          [
                            attribute.class(
                              "pl-2 font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "3 min read
          ",
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ]),
              ]),
              html.div([attribute.class("pb-16 lg:pb-20")], [
                html.div([attribute.class("flex items-center pb-6")], [
                  html.img([
                    attribute.alt("icon story"),
                    attribute.src("./img/icon-project.png"),
                  ]),
                  html.h3(
                    [
                      attribute.class(
                        "ml-3 font-body text-2xl font-semibold text-primary dark:text-white",
                      ),
                    ],
                    [
                      text(
                        "My Projects
      ",
                      ),
                    ],
                  ),
                ]),
                html.div([], [
                  html.a(
                    [
                      attribute.class(
                        "mb-6 flex items-center justify-between border border-grey-lighter px-4 py-4 sm:px-6",
                      ),
                      attribute.href(" / "),
                    ],
                    [
                      html.span([attribute.class("w-9/10 pr-8")], [
                        html.h4(
                          [
                            attribute.class(
                              "font-body text-lg font-semibold text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "TailwindCSS
          ",
                            ),
                          ],
                        ),
                        html.p(
                          [
                            attribute.class(
                              "font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "Rapidly build modern websites without ever leaving your HTML.
          ",
                            ),
                          ],
                        ),
                      ]),
                      html.span([attribute.class("w-1/10")], [
                        html.img([
                          attribute.alt("chevron right"),
                          attribute.class("mx-auto"),
                          attribute.src("./img/chevron-right.png"),
                        ]),
                      ]),
                    ],
                  ),
                  html.a(
                    [
                      attribute.class(
                        "mb-6 flex items-center justify-between border border-grey-lighter px-4 py-4 sm:px-6",
                      ),
                      attribute.href(" / "),
                    ],
                    [
                      html.span([attribute.class("w-9/10 pr-8")], [
                        html.h4(
                          [
                            attribute.class(
                              "font-body text-lg font-semibold text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "Maizzle
          ",
                            ),
                          ],
                        ),
                        html.p(
                          [
                            attribute.class(
                              "font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "Framework for Rapid Email Prototyping
          ",
                            ),
                          ],
                        ),
                      ]),
                      html.span([attribute.class("w-1/10")], [
                        html.img([
                          attribute.alt("chevron right"),
                          attribute.class("mx-auto"),
                          attribute.src("./img/chevron-right.png"),
                        ]),
                      ]),
                    ],
                  ),
                  html.a(
                    [
                      attribute.class(
                        "mb-6 flex items-center justify-between border border-grey-lighter px-4 py-4 sm:px-6",
                      ),
                      attribute.href(" / "),
                    ],
                    [
                      html.span([attribute.class("w-9/10 pr-8")], [
                        html.h4(
                          [
                            attribute.class(
                              "font-body text-lg font-semibold text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "Alpine.js
          ",
                            ),
                          ],
                        ),
                        html.p(
                          [
                            attribute.class(
                              "font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "Think of it like Tailwind for JavaScript.
          ",
                            ),
                          ],
                        ),
                      ]),
                      html.span([attribute.class("w-1/10")], [
                        html.img([
                          attribute.alt("chevron right"),
                          attribute.class("mx-auto"),
                          attribute.src("./img/chevron-right.png"),
                        ]),
                      ]),
                    ],
                  ),
                  html.a(
                    [
                      attribute.class(
                        "mb-6 flex items-center justify-between border border-grey-lighter px-4 py-4 sm:px-6",
                      ),
                      attribute.href(" / "),
                    ],
                    [
                      html.span([attribute.class("w-9/10 pr-8")], [
                        html.h4(
                          [
                            attribute.class(
                              "font-body text-lg font-semibold text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "PostCSS
          ",
                            ),
                          ],
                        ),
                        html.p(
                          [
                            attribute.class(
                              "font-body font-light text-primary dark:text-white",
                            ),
                          ],
                          [
                            text(
                              "A tool for transforming CSS with JavaScript
          ",
                            ),
                          ],
                        ),
                      ]),
                      html.span([attribute.class("w-1/10")], [
                        html.img([
                          attribute.alt("chevron right"),
                          attribute.class("mx-auto"),
                          attribute.src("./img/chevron-right.png"),
                        ]),
                      ]),
                    ],
                  ),
                ]),
              ]),
            ]),
          ]),
          html.div([attribute.class("container mx-auto")], [
            html.div(
              [
                attribute.class(
                  "flex flex-col items-center justify-between border-t border-grey-lighter py-10 sm:flex-row sm:py-12",
                ),
              ],
              [
                html.div(
                  [
                    attribute.class(
                      "mr-auto flex flex-col items-center sm:flex-row",
                    ),
                  ],
                  [
                    html.a(
                      [attribute.class("mr-auto sm:mr-6"), attribute.href("/")],
                      [
                        html.img([
                          attribute.alt("logo"),
                          attribute.src("./img/logo.svg"),
                        ]),
                      ],
                    ),
                    html.p(
                      [
                        attribute.class(
                          "pt-5 font-body font-light text-primary dark:text-white sm:pt-0",
                        ),
                      ],
                      [
                        text(
                          "©2020 John Doe.
      ",
                        ),
                      ],
                    ),
                  ],
                ),
                html.div(
                  [
                    attribute.class(
                      "mr-auto flex items-center pt-5 sm:mr-0 sm:pt-0",
                    ),
                  ],
                  [
                    html.a(
                      [
                        attribute.target("_blank"),
                        attribute.href("https://github.com/ "),
                      ],
                      [
                        html.i(
                          [
                            attribute.class(
                              "text-4xl text-primary dark:text-white pl-5 hover:text-secondary dark:hover:text-secondary transition-colors bx bxl-github",
                            ),
                          ],
                          [],
                        ),
                      ],
                    ),
                    html.a(
                      [
                        attribute.target("_blank"),
                        attribute.href("https://codepen.io/ "),
                      ],
                      [
                        html.i(
                          [
                            attribute.class(
                              "text-4xl text-primary dark:text-white pl-5 hover:text-secondary dark:hover:text-secondary transition-colors bx bxl-codepen",
                            ),
                          ],
                          [],
                        ),
                      ],
                    ),
                    html.a(
                      [
                        attribute.target("_blank"),
                        attribute.href("https://www.linkedin.com/ "),
                      ],
                      [
                        html.i(
                          [
                            attribute.class(
                              "text-4xl text-primary dark:text-white pl-5 hover:text-secondary dark:hover:text-secondary transition-colors bx bxl-linkedin",
                            ),
                          ],
                          [],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ]),
        html.script([attribute.src("./js/main.js")], ""),
      ],
    ),
  ])
}
