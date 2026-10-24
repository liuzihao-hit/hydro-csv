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

/// 把 CSV 文本按行拆分，兼容 \n 与 \r\n，并跳过空行
/// 用途：读取传感器时序 CSV 文件后，先按行切分再逐行解析
pub fn split_lines(text : String) -> Array[String] {
  let lines : Array[String] = []
  for part in text.split("\n") {
    let line = if part.length() > 0 && part[part.length() - 1] == '\r' {
      part[0:part.length() - 1].to_owned()
    } else {
      part.to_owned()
    }
    if line.length() > 0 {
      lines.push(line)
    }
  }
  lines
}

test "split_lines 按行拆分" {
  assert_eq(split_lines("a,b\nc,d\n"), ["a,b", "c,d"])
  assert_eq(split_lines("a,b\r\nc,d"), ["a,b", "c,d"])
  assert_eq(split_lines(""), [])
}

/// 按逗号把一行 CSV 拆成多个字段
/// 用途：一行里可能同时有压力、位移等多列传感器数据
pub fn split_columns(line : String) -> Array[String] {
  let cols : Array[String] = []
  for part in line.split(",") {
    cols.push(part.to_owned())
  }
  cols
}

test "split_columns 按逗号拆列" {
  assert_eq(split_columns("1.2,3.4,5.6"), ["1.2", "3.4", "5.6"])
  assert_eq(split_columns("single"), ["single"])
}

/// 找出一组数据里的最小值
/// 用途：液压成形传感器数据里找压力谷值
pub fn min_value(data : Array[Double]) -> Double {
  if data.length() == 0 {
    return 0.0
  }
  let mut result = data[0]
  for i = 1; i < data.length(); i = i + 1 {
    if data[i] < result {
      result = data[i]
    }
  }
  result
}

test "min_value 找出谷值" {
  assert_eq(min_value([0.5, 1.8, 3.6, 5.0, 2.2]), 0.5)
  assert_eq(min_value([5.0]), 5.0)
  assert_eq(min_value([]), 0.0)
}

/// 计算一组数据的平均值
/// 用途：求整段压力时序的平均压力
pub fn mean(data : Array[Double]) -> Double {
  if data.length() == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i = 0; i < data.length(); i = i + 1 {
    sum = sum + data[i]
  }
  sum / data.length().to_double()
}

test "mean 计算平均值" {
  assert_eq(mean([1.0, 2.0, 3.0]), 2.0)
  assert_eq(mean([5.0]), 5.0)
  assert_eq(mean([]), 0.0)
}

/// 找出最大值的下标（峰值时刻）
/// 用途：定位压力峰值出现在第几个采样点
pub fn peak_index(data : Array[Double]) -> Int {
  if data.length() == 0 {
    return -1
  }
  let mut idx = 0
  let mut best = data[0]
  for i = 1; i < data.length(); i = i + 1 {
    if data[i] > best {
      best = data[i]
      idx = i
    }
  }
  idx
}

test "peak_index 定位峰值" {
  assert_eq(peak_index([0.5, 1.8, 3.6, 5.0, 2.2]), 3)
  assert_eq(peak_index([5.0]), 0)
  assert_eq(peak_index([]), -1)
}

/// 滑动窗口平均，用于平滑传感器噪声
/// 返回每个窗口的平均值，不完整的尾部丢弃
pub fn moving_average(data : Array[Double], window : Int) -> Array[Double] {
  let out : Array[Double] = []
  if window <= 0 || data.length() < window {
    return out
  }
  let mut i = 0
  while i + window <= data.length() {
    let mut sum = 0.0
    for j = i; j < i + window; j = j + 1 {
      sum = sum + data[j]
    }
    out.push(sum / window.to_double())
    i = i + 1
  }
  out
}

test "moving_average 滑动窗口平滑" {
  assert_eq(moving_average([1.0, 2.0, 3.0, 4.0], 2), [1.5, 2.5, 3.5])
  assert_eq(moving_average([1.0], 2), [])
  assert_eq(moving_average([1.0, 2.0], 0), [])
}
