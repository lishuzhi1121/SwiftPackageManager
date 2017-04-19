import Rainbow

// 扑克牌花色枚举
public enum Suit: String {
    // 黑桃、红桃、方块、梅花
    case spades, hearts, diamonds, clubs
}

// MARK: - Comparable

extension Suit: Comparable {}

public func <(lhs: Suit, rhs: Suit) -> Bool {
    switch (lhs, rhs) {
    case (_, _) where lhs == rhs:
        return false
    case(.spades, _), (.hearts, .diamonds), (.hearts, .clubs), (.diamonds, .clubs):
        return false
    default:
        return true
    }
}

// MARK: - CustomStringConvertible

extension Suit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .spades:
            return "♠︎".black
        case .hearts:
            return "♥︎".red
        case .diamonds:
            return "♦︎".red
        case .clubs:
            return "♣︎".black
        }
    }
}
