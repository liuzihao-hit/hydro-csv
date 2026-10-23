/// 找出一组数据里的最大值
/// 用途：液压成形传感器数据里找压力峰值
pub fn max_value(data : Array[Double]) -> Double {
  if data.length() == 0 {
    return 0.0
  }
  let mut result = data[0]
  for i = 1; i < data.length(); i = i + 1 {
    if data[i] > result {
      result = data[i]
    }
  }
  result
}

test "max_value 找出峰值" {
  assert_eq(max_value([0.5, 1.8, 3.6, 5.0, 2.2]), 5.0)
  assert_eq(max_value([5.0]), 5.0)
  assert_eq(max_value([]), 0.0)
}
