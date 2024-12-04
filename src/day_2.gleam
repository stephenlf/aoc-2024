import gleam/int
import gleam/list
import gleam/string

type SafeReport {
  Ascending(Report)
  Descending(Report)
}
  

type Report =
  List(Int)

type Direction {
  Increasing
  Decreasing
}

pub fn part_1(input: String) -> Int {
  let reports: List(SafeReport) =
    parse_input(input)
    |> list.filter_map(to_safe_report)
  list.length(reports)
}

fn parse_input(input: String) -> List(Report) {
  to_ints(input)
  |> list.map(fn(values) { todo })
}

fn to_ints(input: String) -> List(List(Int)) {
  string.split(input, "\n")
  |> list.map(fn(report) {
    string.split(report, " ")
    |> list.filter_map(fn(report_value) { int.base_parse(report_value, 10) })
  })
}


fn is_increasing(values: List(Int)) -> Result(Direction, Nil) {
  let direction = list.fold_until(values, Error(Nil), fn(acc, value) {
    case  {
       -> 
    }
  })
}

fn to_safe_report(report: Report) -> Result(SafeReport, Nil) {
  todo
}

fn count_sorted(reports: List(Report)) -> Int {
  todo
}
