import day_1
import gleam/io
import gleam/result
import gleeunit/should
import simplifile

pub fn part_2_test() {
  simplifile.read("inputs/day_1_test.txt")
  |> result.unwrap("")
  |> day_1.solve_pt_2()
  |> should.equal(31)
}
