import day_2
import gleeunit/should

const test_data = "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

pub fn part_1_test() {
  should.equal(day_2.part_1(test_data), 2)
}

pub fn part_2_test() {
  should.equal(day_2.part_2(test_data), 4)
}
