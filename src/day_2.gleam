import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option}
import gleam/order
import gleam/string

type Report {
  Safe(List(Int))
  Unsafe(List(Int))
}

type Direction {
  Unknown(prior: Int)
  Jumbled
  Increasing(prior: Int, max_gap: Int)
  Decreasing(prior: Int, max_gap: Int)
}

pub fn part_1(input: String) -> Int {
  to_ints(input)
  |> list.map(find_direction)
  |> list.fold(0, fn(acc: Int, report: Report) {
    case report {
      Safe(_) -> acc + 1
      _ -> acc
    }
  })
}

fn to_ints(input: String) -> List(List(Int)) {
  string.split(input, "\n")
  |> list.map(fn(report) {
    string.split(report, " ")
    |> list.filter_map(fn(report_value) { int.base_parse(report_value, 10) })
  })
}

fn find_direction(values: List(Int)) -> Report {
  let initial_dir: Option(Direction) = option.None
  let dir: Direction =
    list.fold(values, initial_dir, fn(dir, val) {
      case dir {
        option.None -> option.Some(Unknown(val))
        option.Some(Jumbled) -> option.Some(Jumbled)
        option.Some(Unknown(prior)) -> {
          let diff = int.absolute_value(val - prior)
          case int.compare(prior, val) {
            order.Lt -> option.Some(Increasing(val, diff))
            order.Gt -> option.Some(Decreasing(val, diff))
            order.Eq -> option.Some(Jumbled)
          }
        }
        option.Some(Increasing(prior, max_gap)) -> {
          let max_gap = int.max(int.absolute_value(val - prior), max_gap)
          case int.compare(prior, val) {
            order.Lt -> option.Some(Increasing(val, max_gap))
            _ -> option.Some(Jumbled)
          }
        }
        option.Some(Decreasing(prior, max_gap)) -> {
          let max_gap = int.max(int.absolute_value(val - prior), max_gap)
          case int.compare(prior, val) {
            order.Gt -> option.Some(Decreasing(val, max_gap))
            _ -> option.Some(Jumbled)
          }
        }
      }
    })
    |> option.unwrap(Jumbled)
  // io.debug(values)
  // io.debug(dir)
  case dir {
    Unknown(_) -> panic as "List should have at least found a direction"
    Jumbled -> Unsafe(values)
    Increasing(_, max_gap) | Decreasing(_, max_gap) ->
      case max_gap <= 3 {
        True -> Safe(values)
        False -> Unsafe(values)
      }
  }
}

pub fn part_2(input: String) -> Int {
  todo
}

type DampenedDir {
  Ascending(dampener: Option(Nil))
  Descending(dampener: Option(Nil))
  Heterogenous
}

fn dampened_safety(levels: List(Int)) -> Report {
  let assert [a, b, c, d, ..] = levels
  let comparisons = [int.compare(a, b), int.compare(a, c), int.compare(a, d)]
  let gt_count =
    list.count(comparisons, fn(comparison) {
      case comparison {
        order.Gt -> True
        _ -> False
      }
    })
  let lt_count =
    list.count(comparisons, fn(comparison) {
      case comparison {
        order.Lt -> True
        _ -> False
      }
    })
  let dir = case int.compare(gt_count, 2), int.compare(lt_count, 2) {
    order.Gt, _ -> Descending(option.Some(Nil))
    _, order.Gt -> Ascending(option.Some(Nil))
    _, _ -> Heterogenous
  }

  // case  {
  //   order.Gt, order.Gt, order.Gt -> todo
  //   order.Lt, order.Lt, order.Lt -> todo
  // }
  todo
}

fn new_comparer(expectation)
