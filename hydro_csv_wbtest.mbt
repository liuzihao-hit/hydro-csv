/// 黑盒测试：只验证公开接口的边界行为（独立测试包，自动导入 hydro_csv，仅访问 pub 函数）
test "空数据的边界处理" {
  assert_eq(max_value([]), 0.0)
  assert_eq(min_value([]), 0.0)
  assert_eq(mean([]), 0.0)
  assert_eq(peak_index([]), -1)
  assert_eq(count_above([], 1.0), 0)
  assert_eq(moving_average([], 3), [])
}

test "parse_double 对非法输入容错" {
  assert_eq(parse_double("abc"), 0.0)
  assert_eq(parse_double("12.34"), 12.34)
}
