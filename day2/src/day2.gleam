import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/order
import gleam/string
import simplifile

pub fn part1(input: String) -> Int {
  let rows_result =
    input
    |> string.trim()
    |> string.split("\n")
    |> list.try_map(fn(str) {
      string.trim(str)
      |> string.split(" ")
      |> list.try_map(int.parse)
    })
  case rows_result {
    Ok(rows) -> {
      rows
      |> list.filter(is_sorted)
      |> list.filter(fn(nr_list) { all_diffs_less_than_tree(nr_list) })
      |> list.length()
    }
    _ -> {
      -1
    }
  }
}

pub fn part2(input: String) -> Int {
  let rows_result =
    input
    |> string.trim()
    |> string.split("\n")
    |> list.try_map(fn(str) {
      string.trim(str)
      |> string.split(" ")
      |> list.try_map(int.parse)
    })
  case rows_result {
    Ok(rows) -> {
      rows
      |> list.map(list_to_list_minus_one)
      |> list.map(fn(l) {
        l
        |> list.filter(is_sorted)
        |> list.filter(fn(lst) { all_diffs_less_than_tree(lst) })
      })
      |> list.filter(fn(l) { bool.negate(list.is_empty(l)) })
      |> list.length()
    }
    _ -> {
      -1
    }
  }
}

pub fn list_to_list_minus_one(numbers: List(Int)) -> List(List(Int)) {
  list_to_list_recurse([], numbers, [])
}

fn list_to_list_recurse(
  prev: List(Int),
  next: List(Int),
  acc: List(List(Int)),
) -> List(List(Int)) {
  case next {
    [head, ..tail] ->
      list_to_list_recurse([head, ..prev], tail, [
        list.flatten([list.reverse(prev), tail]),
        ..acc
      ])
    _ -> acc
  }
}

fn is_sorted(list: List(Int)) -> Bool {
  case list {
    [head, second, ..tail] ->
      is_sorted_recurse(tail, second, int.compare(head, second))
    _ -> False
  }
}

fn is_sorted_recurse(list: List(Int), prev: Int, direction: order.Order) -> Bool {
  case list {
    [head, ..tail] -> {
      case int.compare(prev, head) {
        order.Eq -> False
        dir if dir == direction -> is_sorted_recurse(tail, head, direction)
        _ -> False
      }
    }
    _ -> True
  }
}

fn all_diffs_less_than_tree(numbers: List(Int)) -> Bool {
  case numbers {
    [head, ..] -> all_diffs_less_than_tree_recurse(numbers, head)
    _ -> True
  }
}

fn all_diffs_less_than_tree_recurse(numbers: List(Int), prev) -> Bool {
  case numbers {
    [head, ..tail] -> {
      let diff = int.absolute_value(prev - head)
      case int.compare(diff, 3) {
        order.Gt -> False
        _ -> all_diffs_less_than_tree_recurse(tail, head)
      }
    }
    _ -> True
  }
}

pub fn main() {
  io.println("Hello from day2!")
  let data = simplifile.read("data.txt")
  case data {
    Ok(str) -> {
      io.debug(part1(str))
      io.debug(part2(str))
      0
    }
    _ -> {
      io.println_error("failed to read the file")
      1
    }
  }
  0
}
