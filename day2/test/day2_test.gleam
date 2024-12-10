import day2
import gleam/io
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}

pub fn part_one_test() {
  day2.part1(
    "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9",
  )
  |> should.equal(2)
}

pub fn part_two_test() {
  day2.part2(
    "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9",
  )
  |> should.equal(4)
}

pub fn part_two_two_test() {
  day2.part2("1 4 5 2 6")
  |> should.equal(1)
  // 1 4 5 2 6
}

pub fn part_two_large_number_test() {
  // the second line should fail, because 10 - 6 = 4 and 4 > 3
  day2.part2(
    "1 3 6 700 9
1 3 6 700 10
1 2 3 4 900
1 1 3 6 7 9",
  )
  |> should.equal(3)
}

pub fn part_two_three_test() {
  day2.part2("6 2 5 4 1")
  |> should.equal(1)
  // 1 4 5 2 6
}

pub fn should_remove_the_1_test() {
  day2.part2("1 300 301 302") |> should.equal(1)
}

pub fn should_remove_the_6_test() {
  day2.part2("1 2 4 6 5") |> should.equal(1)
}

pub fn starting_large_number_extra_error_test() {
  day2.part2("100 1 2 5 4") |> should.equal(0)
}

pub fn starting_large_number_test() {
  day2.part2("100 1 2 3 4") |> should.equal(1)
}

pub fn part_two_should_fail_on_diff_test() {
  day2.part2("600 100 5 4 1")
  |> should.equal(0)
  // 1 4 5 2 6
}

pub fn fart_1_test() {
  "1 3 2 4 5"
  |> day2.part2
  |> should.equal(1)
}

pub fn fart_test() {
  "13 130 15 18 20 21 23 25"
  |> day2.part2
  |> should.equal(1)
}

pub fn fart_3_test() {
  "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 15"
  |> day2.part2
  |> should.equal(1)
}

pub fn fart_2_test() {
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
  |> day2.list_to_list_minus_one
}

pub fn fart_4_test() {
  "1 2 3 4 5 5 6 7 8 9 10 11 12 13 14 15"
  |> day2.part2
  |> should.equal(1)
}

pub fn test_test() {
  "5 5 5 5 5" |> day2.part2 |> should.equal(0)
}

pub fn sick_list_test() {
  [[], [], [], []] |> list.is_empty |> io.debug
}
