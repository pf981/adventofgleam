import content.{Code, DualHeading, Link, Section, Snippet, Text}
import post

pub const content = post.Post(
  year: 2023,
  day: 1,
  title: "Trebuchet?!",
  description: "Easy string manipulation.",
  post_date: post.Date(2024, 6, 29),
  author: "Paul Foster",
  tags: [],
  difficulty: post.Easy,
  content: [
    Section([Text("Ho ho ho, fellow adventurers!")]),
    Section(
      [
        Link("https://adventofcode.com/2023/day/1", "Advent of Code day 1"),
        Text(
          " has catapulted us into a realm of medieval engineering. Day 1 starts off easy with string manipulation.",
        ),
      ],
    ),
    Section(
      [
        Text("I narrowly missed the Part 1 leaderboard, landing at rank "),
        Code("119"),
        Text(". Just 4 seconds faster and I'd have cracked the top 100."),
      ],
    ), Section([Text("First, we'll read the input.")]),
    Snippet(
      "python",
      "with open('input.txt', \"r\") as f:
    lines = f.readlines()",
    ), DualHeading("Part 1", "Trebuchet Trouble"),
    // TaskCard("Task 1", [])
  ],
)
//   Title(String)
//   Heading(String)
//   DualHeading(String, String)
//   Subheading(String)
//   Section(List(InlineContent))
//   Snippet(lang: String, code: String)

// pub type InlineContent {
//   Bold(String)
//   Code(String)
//   Link(href: String, text: String)
//   Text(String)
// }
