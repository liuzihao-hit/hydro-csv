/// 白盒测试：覆盖完整数据流水线（与 hydro_csv 同包，可访问全部函数）
test "完整流水线：解析列并统计" {
  let csv = "1.0\n2.0\n3.0\n4.0\n5.0\n"
  let col = @hydro_csv.parse_column(csv)
  assert_eq(@hydro_csv.max_value(col), 5.0)
  assert_eq(@hydro_csv.min_value(col), 1.0)
  assert_eq(@hydro_csv.mean(col), 3.0)
  assert_eq(@hydro_csv.peak_index(col), 4)
  assert_eq(@hydro_csv.count_above(col, 3.0), 2)
}

test "滑动平均：窗口平滑与长度" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let smoothed = @hydro_csv.moving_average(data, 2)
  assert_eq(smoothed.length(), 4)
  assert_eq(smoothed, [1.5, 2.5, 3.5, 4.5])
}

test "滑动平均：窗口非法时返回空" {
  assert_eq(@hydro_csv.moving_average([1.0, 2.0], 0), [])
  assert_eq(@hydro_csv.moving_average([1.0], 3), [])
}

test "解析带逗号的行并转数值" {
  let cols = @hydro_csv.split_columns("10.5,20.3,30.1")
  assert_eq(@hydro_csv.parse_double(cols[0]), 10.5)
  assert_eq(@hydro_csv.parse_double(cols[1]), 20.3)
  assert_eq(@hydro_csv.parse_double(cols[2]), 30.1)
}
