import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import gleam/yielder

pub fn solve(input: String) -> Int {
  let #(left_items, right_items) =
    string.split(input, "\n")
    |> yielder.from_list
    |> yielder.map(fn(line) {
      string.split(line, " ")
      |> list.filter_map(fn(item) {
        string.trim(item)
        |> int.base_parse(10)
      })
    })
    |> yielder.fold(#(list.new(), list.new()), fn(acc, item) {
      let assert [left_item, right_item] = item
      let #(left_list, right_list) = acc
      let left_list = list.append(left_list, [left_item])
      let right_list = list.append(right_list, [right_item])
      #(left_list, right_list)
    })
  list.zip(
    list.sort(left_items, int.compare),
    list.sort(right_items, int.compare),
  )
  |> list.fold(0, fn(acc, item) {
    let #(left_item, right_item) = item
    let distance = int.absolute_value(left_item - right_item)
    acc + distance
  })
}

type Lists {
  Lists(left: List(Int), right: List(Int))
}

type FrequencyMap =
  Dict(Int, Int)

type IntPair =
  #(Int, Int)

pub fn solve_pt_2(input: String) -> Int {
  let lists = parse_lists(input)
  let frequency_map = to_frequency_map(lists.right)
  list.fold(lists.left, 0, fn(acc, item) {
    let frequency =
      dict.get(frequency_map, item)
      |> result.unwrap(0)
    acc + { frequency * item }
  })
}

fn parse_lists(list_text: String) -> Lists {
  let #(unsorted_left_items, unsorted_right_items) =
    string.split(list_text, "\n")
    |> list.map(line_to_int_pair)
    |> to_pair_of_lists()
  Lists(
    list.sort(unsorted_left_items, int.compare),
    list.sort(unsorted_right_items, int.compare),
  )
}

fn line_to_int_pair(line: String) -> IntPair {
  let assert [left_item, right_item] =
    string.split(line, " ")
    |> list.filter_map(fn(item) {
      string.trim(item)
      |> int.base_parse(10)
    })
  #(left_item, right_item)
}

fn to_pair_of_lists(int_pairs: List(IntPair)) -> #(List(Int), List(Int)) {
  list.fold(int_pairs, #(list.new(), list.new()), fn(acc, item) {
    let #(left_item, right_item) = item
    let #(left_list, right_list) = acc
    let left_list = list.append(left_list, [left_item])
    let right_list = list.append(right_list, [right_item])
    #(left_list, right_list)
  })
}

fn to_frequency_map(numbers: List(Int)) -> FrequencyMap {
  list.fold(numbers, dict.new(), fn(acc, number) {
    let frequency =
      dict.get(acc, number)
      |> result.unwrap(0)
    dict.insert(acc, number, frequency + 1)
  })
}
