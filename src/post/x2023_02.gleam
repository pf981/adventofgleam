import content.{DualHeading, Section, Text}
import post

pub const content = post.Post(
  year: 2023,
  day: 2,
  title: "Trebuchet?!",
  description: "Easy string manipulation.",
  post_date: post.Date(2024, 6, 22),
  tags: [],
  difficulty: post.Easy,
  content: [
    Section([Text("Ho ho ho, fellow adventurers!")]),
    Section(
      [
        Text(
          "Advent of Code day 1 has catapulted us into a realm of medieval engineering. Day 1 starts off easy with string manipulation.",
        ),
      ],
    ),
    Section(
      [
        Text(
          "I narrowly missed the Part 1 leaderboard, landing at rank 119. Just 4 seconds faster and I’d have cracked the top 100.",
        ),
      ],
    ), Section([Text("First, we’ll read the input.")]),
    DualHeading("Part 1", "Trebuchet Trouble"),
  ],
)
