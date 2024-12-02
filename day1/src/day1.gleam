import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/order
import gleam/string
import simplifile

pub fn part1(input: String) -> Int {
  let #(left_list, right_list) =
    input
    |> string.split("\n")
    |> list.fold(#([], []), fn(acc, row) {
      let columns =
        row
        |> string.trim()
        |> string.split("   ")
        |> list.try_map(int.parse)

      case columns {
        Ok([left, right]) -> #(
          list.sort([left, ..acc.0], int.compare),
          list.sort([right, ..acc.1], int.compare),
        )
        _ -> {
          acc
        }
      }
    })

  recurse_part1(left_list, right_list, [])
}

fn recurse_part1(l1: List(Int), l2: List(Int), diffs: List(Int)) -> Int {
  let l1_tup = list.split(l1, 1)
  let l2_tup = list.split(l2, 1)

  let combined = #(l1_tup, l2_tup)
  case combined {
    #(#([v1_first], v1_rest), #([v2_first], v2_rest)) ->
      recurse_part1(v1_rest, v2_rest, [v1_first - v2_first, ..diffs])
    _ -> {
      diffs
      |> list.map(fn(val: Int) {
        case int.compare(0, val) {
          order.Gt -> int.negate(val)
          _ -> val
        }
      })
      |> int.sum()
    }
  }
}

pub fn part2(input: String) -> Int {
  let #(left_list, right_list) =
    input
    |> string.split("\n")
    |> list.fold(#([], []), fn(acc, row) {
      let columns =
        row
        |> string.trim()
        |> string.split("   ")
        |> list.try_map(int.parse)

      case columns {
        Ok([left, right]) -> #(
          list.sort([left, ..acc.0], int.compare),
          list.sort([right, ..acc.1], int.compare),
        )
        _ -> {
          acc
        }
      }
    })

  recurse_part2(left_list, right_list, dict.new(), 0)
}

fn recurse_part2(
  l1: List(Int),
  l2: List(Int),
  calculated: dict.Dict(Int, Int),
  acc: Int,
) -> Int {
  case l1 {
    [i, ..rest] -> {
      case dict.get(calculated, i) {
        Ok(pre_calc) -> {
          recurse_part2(rest, l2, calculated, pre_calc + acc)
        }
        Error(_) -> {
          let count =
            l2
            |> list.filter(fn(val) { val == i })
            |> list.length()
          recurse_part2(
            rest,
            l2,
            dict.insert(calculated, i, i * count),
            i * count + acc,
          )
        }
      }
    }
    _ -> acc
  }
}

pub fn main() {
  case simplifile.read("./src/data/day1.txt") {
    Ok(str) -> {
      io.debug(part1(str))
      io.debug(part2(str))
      0
    }
    _ -> {
      io.println("could not open file")
      1
    }
  }
}
