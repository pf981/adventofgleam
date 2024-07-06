import gleam/option.{None, Some}

import content.{
  Blue, Card, Code, DualHeading, Emphasis, Green, Info, Link, Quote, Red,
  Section, Snippet, Text, UList, Yellow,
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
  language: post.Python,
  thumbnail: "img/2023-02-1.svg",
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
      Some("img/2023-02-1.svg"),
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
        [Code("12"), Text(" red cubes")],
        [Code("13"), Text(" green cubes, and")],
        [Code("14"), Text(" blue cubes")],
      ],
    ),
    Section(
      [
        Text("For example, if a line contains "), Code("\"13 red\""),
        Text(", we know we need to exclude it."),
      ],
    ),
    Section(
      [
        Text(
          "We’ll use regex to extract the largest red, green, and blue values. Then we’ll keep only games where",
        ),
      ],
    ),
    UList(
      [
        [Code("largest_red ≤ 12"), Text(", and")],
        [Code("largest_green ≤ 13"), Text(", and")],
        [Code("largest_blue ≤ 14")],
      ],
    ),
    Snippet(
      "python",
      "import re


def extract_cubes(line):
    return [extract_max(line, color) for color in ['red', 'green', 'blue']]


def extract_max(line, c):
    return max(int(num) for num in re.findall(r'(\\d+) ' + c, line))


max_cubes = [extract_cubes(line) for line in lines]
answer1 = sum(
    game_id
    for game_id, cubes in enumerate(max_cubes, 1)
    if cubes[0] <= 12 and cubes[1] <= 13 and cubes[2] <= 14
)
print(answer1)
#> 8",
    ),
    Info(
      "Key Points",
      [
        UList(
          [
            [
              Code("extract_max"),
              Text(" finds highest quantity of a single colour using regex"),
            ],
            [
              Code("extract_cubes"),
              Text(" function find highest quantity of every colour"),
            ],
            [Text("Filter and sum the game IDs based on the colour constraint")],
          ],
        ),
      ],
    ), DualHeading("Part 2", "Combining Cube Colour Counts"),
    Card(
      "Task 2",
      Some("img/2023-02-2.svg"),
      [
        Section(
          [
            Emphasis("Multiply", None), Text(" the "), Emphasis("largest", None),
            Text(" "), Emphasis("red", Some(Red)), Text(", "),
            Emphasis("green", Some(Green)), Text(", and "),
            Emphasis("blue", Some(Blue)), Text(" values. Then get the "),
            Emphasis("sum", Some(Yellow)), Text("."),
          ],
        ),
      ],
    ), Section([Text("Part 2 is essentially asking,")]),
    Quote(
      [
        Text(
          "What is the fewest number of cubes of each color that could have been in the bag to make the game possible?",
        ),
      ],
    ),
    Section(
      [
        Text(
          "The word \"fewest\" might lead you to think we need to get the minimum. But actually, we need to find the ",
        ), Emphasis("maximum", None), Text(" of each colour."),
      ],
    ),
    Section(
      [
        Text(
          "Luckily, that’s precisely what we did in part 1. So we just need to multiply the largest of each colour and get the sum.",
        ),
      ],
    ),
    Snippet(
      "python",
      "import math


answer2 = sum(math.prod(cubes) for cubes in max_cubes)
print(answer2)
#> 2286",
    ),
    Info(
      "Key Points",
      [
        UList(
          [
            [Text("We already have the largest of each colour from part 1")],
            [Text("Multiply the largest of each colour and get the sum")],
          ],
        ),
      ],
    ), DualHeading("Stocking Stuffers", "Cand-Coated Comprehensions"),
    Section(
      [
        Text(
          "Pretty much every line in the solution is a list comprehension. They can be combined to construct a juicy one-liner.",
        ),
      ],
    ),
    Snippet(
      "python",
      "[sum(l) for l in zip(*[(i * (cubes[0] <= 12 and cubes[1] <= 13 and cubes[2] <= 14), math.prod(cubes)) for i, cubes in enumerate(([max(int(num) for num in re.findall(r'(\\d+) ' + c, line)) for c in ['red', 'green', 'blue']] for line in lines), 1)])]
#> [8, 2286]",
    ),
  ],
)
