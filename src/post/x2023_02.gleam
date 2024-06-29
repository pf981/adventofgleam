import gleam/option.{None, Some}

import content.{
  Blue, Card, Code, DualHeading, Emphasis, Green, Info, Link, Red, Section,
  Snippet, Text, UList, Yellow,
}
import post

pub const content = post.Post(
  year: 2023,
  day: 2,
  title: "Cube Conundrum",
  description: "Easy puzzle with basic regex and arithmetic.",
  post_date: post.Date(2024, 6, 29),
  author: "Paul Foster",
  tags: [],
  difficulty: post.Easy,
  code: "import math
import re


with open('input.txt', 'r') as f:
    lines = f.readlines()


def extract_cubes(line):
    return [extract_max(line, color) for color in ['red', 'green', 'blue']]


def extract_max(line, c):
    return max(int(num) for num in re.findall(r'(\\d+) ' + c, line))


max_cubes = [extract_cubes(line) for line in lines]
answer1 = sum(game_id for game_id, cubes in enumerate(max_cubes, 1) if cubes[0] <= 12 and cubes[1] <= 13 and cubes[2] <= 14)
print(answer1)


# Part 2
answer2 = sum(math.prod(cubes) for cubes in max_cubes)
print(answer2)",
  content: [
    Section([Text("Ho ho ho, fellow adventurers!")]),
    Section(
      [
        Link("https://adventofcode.com/2023/day/2", "Advent of Code day 2"),
        Text(
          " lands us on Snow Island playing a cube game with an Elf. This is a straightforward puzzle involving basic regex and arithmetic.",
        ),
      ],
    ), Section([Text("First, we’ll read the input.")]),
    DualHeading("Part 1", "Prismatic Filters"),
    Card(
      "Task 1",
      Some("img/2023-02-01.svg"),
      [
        Section(
          [
            Text("Get the "), Emphasis("sum", Some(Yellow)), Text(" of "),
            Emphasis("Game IDs", Some(Green)), Text(" "),
            Emphasis("excluding", Some(Red)), Text(" games with more than "),
            Emphasis("12 red", None), Text(", "), Emphasis("13 green", None),
            Text(", or "), Emphasis("14 blue", None), Text("."),
          ],
        ),
      ],
    ),
    Section(
      [
        Text(
          "In part 1, we need to identify which games would be possible if there were only",
        ),
      ],
    ),
    UList(
      [
        [Code("12"), Text(" red cubes")], [Code("13"), Text("green cubes, and")],
        [Code("14"), Text(" blue cubes")],
      ],
    ),
    Section(
      [
        Text(
          "
For example, if a line contains \"13 red\", we know we need to exclude it.

We’ll use regex to extract the largest red, green, and blue values. Then we’ll keep only games where

largest_red ≤ 12, and
largest_green ≤ 13, and
largest_blue ≤ 14",
        ),
      ],
    ),
    Snippet(
      "python",
      "words = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
m.update({text: i for i, text in enumerate(words, 1)})
rev_m = {text[::-1]: value for text, value in m.items()}

answer2 = sum(10 * first_value(line, m) + first_value(line[::-1], rev_m) for line in lines)
print(answer2)
#> 281",
    ), Section([Text("Here is some normal text")]),
    UList(
      [
        [
          Code("m"),
          Text(
            " has been extended to include mappings for digits spelled out with letters (e.g. ",
          ), Code("{'one': 1, 'two': 2, ...}"), Text(")."),
        ],
        [
          Text(""), Code("rev_m"), Text(" is m with each key reversed (e.g. "),
          Code("{'eno': 1, 'owt': 2, ...}"), Text(")"),
        ],
        [
          Text("The first digit is extracted using "), Code("m"),
          Text(", while the last digit uses "), Code("rev_m"),
        ],
      ],
    ),
    Info(
      "Key Points",
      [
        Section([Text("Here is some normal text")]),
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
// "), Emphasis("", Some(Green)), Text("
