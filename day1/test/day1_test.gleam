import day1
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn part1_test() {
  let input =
    "3   4
4   3
2   5
1   3
3   9
3   3"
  day1.part1(input)
  |> should.equal(11)
}

pub fn part2_test() {
  let input =
    "3   4
4   3
2   5
1   3
3   9
3   3"
  day1.part2(input)
  |> should.equal(31)
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}
