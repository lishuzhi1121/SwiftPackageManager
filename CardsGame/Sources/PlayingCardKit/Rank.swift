// 扑克牌点数枚举
public enum Rank: Int {
    case two = 2
    case three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace
}

// MARK: -Comparable

extension Rank: Comparable {}

public func <(lhs: Rank, rhs: Rank) -> Bool {
    switch (lhs, rhs) {
    case (_, _) where lhs == rhs:
        return false
    case(.ace, _):
        return false
    default:
        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - CutomStringConvertible

extension Rank: CustomStringConvertible {
    public var description: String {
        switch self {
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        case .ace:
            return "A"
        default:
            return "\(rawValue)"
        }
    }
}
