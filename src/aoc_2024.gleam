import day_1
import gleam/int
import gleam/io
import simplifile

pub fn main() {
  io.println("Hello from aoc_2024!")
  let assert Ok(day_1_input) = simplifile.read("inputs/day1_test.txt")
  io.println("Day 1, part 1: " <> int.to_string(day_1.solve(day_1_input)))
}
