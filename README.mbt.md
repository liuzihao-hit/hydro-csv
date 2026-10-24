# hydro-csv

用 MoonBit 实现的轻量传感器时序数据解析与统计库。

## 解决什么问题

液压成形实验中，压力、位移等传感器会按时间顺序采集大量 CSV 数据。
工艺人员想快速知道峰值压力、峰值时刻、波动幅度等关键指标，
目前通常临时写 Python 脚本，环境依赖重、不便复用。

本项目提供一个纯 MoonBit 的轻量库，用于直接读取这类时序数据并输出统计结果。

## 当前进度

- [x] 项目工程结构搭建（moon.mod / moon.pkg / 测试框架）
- [x] max_value / min_value：定位压力峰值与谷值，含空数组边界处理
- [x] split_lines / split_columns / parse_double：CSV 文本按行、按列解析并转数值
- [x] mean：平均压力
- [x] peak_index：峰值出现的采样点位置
- [x] moving_average：滑动窗口平滑，抑制噪声
- [x] count_above：超阈值采样点计数（告警）
- [x] parse_column：从整段文本直接得到数值序列（完整流水线）

## 使用示例

假设 CSV 文本每行一个压力值（单位 MPa）：

    let text = "0.5\n1.8\n3.6\n5.0\n2.2\n"
    let pressures = parse_column(text)       // [0.5, 1.8, 3.6, 5.0, 2.2]
    println(max_value(pressures))            // 峰值 5.0
    println(peak_index(pressures))           // 峰值位置 3
    println(mean(pressures))                 // 平均值 2.62
    println(count_above(pressures, 3.0))     // 超 3.0 的个数 2

## 运行测试

    moon test

## 开源协议

Apache 2.0，详见 LICENSE。
