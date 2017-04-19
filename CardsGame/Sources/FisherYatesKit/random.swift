// 生成随机数模块
import Darwin

public let random: (Int) -> Int = {
    Int(arc4random_uniform(UInt32($0)))
}
