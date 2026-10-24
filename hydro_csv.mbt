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
