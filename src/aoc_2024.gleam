import day_1
import gleam/int
import gleam/io
import gleam/result
import simplifile

pub fn main() {
  io.println(day_1_part_1())
  io.println(day_1_part_2())
}

fn day_1_part_1() -> String {
  simplifile.read("inputs/day_1.txt")
  |> result.unwrap("")
  |> day_1.solve()
  |> int.to_string()
  |> as_readable_result(1, 1)
}

fn day_1_part_2() -> String {
  simplifile.read("inputs/day_1.txt")
  |> result.unwrap("")
  |> day_1.solve_pt_2()
  |> int.to_string()
  |> as_readable_result(1, 2)
}

fn as_readable_result(result: String, day: Int, part: Int) {
  "Day "
  <> int.to_string(day)
  <> ", part "
  <> int.to_string(part)
  <> ": "
  <> result
}
