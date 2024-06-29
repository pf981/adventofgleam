import content.{type Content}

pub type Post {
  Post(
    year: Int,
    day: Int,
    title: String,
    description: String,
    post_date: Date,
    author: String,
    tags: List(Tag),
    difficulty: Difficulty,
    code: String,
    content: List(Content),
  )
}

pub type Tag

pub type Difficulty {
  Easy
  Medium
  Hard
}

pub type Date {
  Date(year: Int, month: Int, day: Int)
}
