import gleam/int
import gleam/io
import gleam/list
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
    io.debug(item)
    let distance = int.absolute_value(left_item - right_item)
    io.debug("difference " <> int.to_string(distance))
    acc + distance
  })
}
