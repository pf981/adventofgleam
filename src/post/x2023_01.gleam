import gleam/option.{Some}

import content.{
  Blue, Card, Code, DualHeading, EmphasisUL, Green, Info, Link, Section, Snippet,
  Text, UList, Yellow,
}
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
      "with open('input.txt', 'r') as f:
    lines = f.readlines()",
    ), DualHeading("Part 1", "Trebuchet Trouble"),
    Card(
      "Task 1",
      Some("img/2023-01-01.svg"),
      [
        Section(
          [
            Text("Combine the "), EmphasisUL("first", Some(Green)),
            Text(" and "), EmphasisUL("last", Some(Blue)),
            Text(" digit of each string and get the "),
            EmphasisUL("sum", Some(Yellow)), Text("."),
          ],
        ),
      ],
    ),
    Section(
      [
        Text(
          "In part 1, we need to get the trebuchet calibration values by extracting the first and last digits of each line of the input.",
        ),
      ],
    ),
    Section(
      [
        Text(
          "This can be done with regex, but instead I’ll iterate through each letter until I find a digit.",
        ),
      ],
    ),
    Snippet(
      "python",
      "def first_value(line, m):
  for i, _ in enumerate(line):
    for text, val in m.items():
      if line[i:].startswith(text):
        return val


m = {c: int(c) for c in '123456789'}

answer1 = sum(10 * first_value(line, m) + first_value(line[::-1], m) for line in lines)
print(answer1)
#> 142",
    ),
    Info(
      "Key Points",
      [
        UList(
          [
            [Code("m"), Text(" maps digit characters to their integer values")],
            [
              Code("first_value"),
              Text(" finds the first substring that starts with any key of "),
              Code("m"), Text(" and returns its value"),
            ], [Text("The string is reversed to find the last value")],
          ],
        ),
      ],
    ), DualHeading("Part 2", "Spelling Everything with Letters"),
    Card(
      "Task 2",
      Some("img/2023-01-02.svg"),
      [
        Section(
          [Text("Adapt part 1 to handle digits spelled out with letters.")],
        ),
      ],
    ),
    Section(
      [
        Text(
          "Now, we need to handle digits spelled out with letters. We’ll update ",
        ), Code("m"), Text(" with these new mappings."),
      ],
    ),
    Section(
      [
        Text("However, now that "), Code("m"),
        Text(
          " contains keys with more than one letter it won’t work when the string is reversed. For example, it needs to match ",
        ), Code("eno"), Text(" instead of "), Code("one"), Text("."),
      ],
    ),
    Section(
      [
        Text("So we’ll create "), Code("rev_m"),
        Text(" with each key reversed."),
      ],
    ),
    Info(
      "Key Points",
      [
        UList(
          [
            [
              Code("m"),
              Text(
                " has been extended to include mappings for digits spelled out with letters (e.g. ",
              ), Code("{'one': 1, 'two': 2, ...}"), Text(")."),
            ],
            [
              Text(""), Code("rev_m"),
              Text(" is m with each key reversed (e.g. "),
              Code("{'eno': 1, 'owt': 2, ...}"), Text(")"),
            ],
            [
              Text("The first digit is extracted using "), Code("m"),
              Text(", while the last digit uses "), Code("rev_m"),
            ],
          ],
        ),
      ],
    ),
  ],
)
