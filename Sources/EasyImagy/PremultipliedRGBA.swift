public struct PremultipliedRGBA<Channel> where Channel : Numeric, Channel : Comparable {
    public var red: Channel
    public var green: Channel
    public var blue: Channel
    public var alpha: Channel
    
    public init(red: Channel, green: Channel, blue: Channel, alpha: Channel) {
        precondition(red <= alpha, "`red` (\(red)) must be less than or equal to `alpha` (\(alpha)).")
        precondition(green <= alpha, "`green` (\(green)) must be less than or equal to `alpha` (\(alpha)).")
        precondition(blue <= alpha, "`blue` (\(blue)) must be less than or equal to `alpha` (\(alpha)).")
        
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

extension PremultipliedRGBA where Channel : _Numeric & UnsignedInteger & FixedWidthInteger, Channel.IntType : FixedWidthInteger {
    public init(_ rgba: RGBA<Channel>) {
        let numericAlpha: Channel.IntType = rgba.alpha.summableI
        let numericMaxAlpha: Channel.IntType = Channel.max.summableI
        
        self.init(
            red: .init(summableI: rgba.red.summableI * numericAlpha / numericMaxAlpha),
            green: .init(summableI: rgba.green.summableI * numericAlpha / numericMaxAlpha),
            blue: .init(summableI: rgba.blue.summableI * numericAlpha / numericMaxAlpha),
            alpha: rgba.alpha
        )
    }
}

extension PremultipliedRGBA where Channel : FloatingPoint {
    public init(_ rgba: RGBA<Channel>) {
        
        self.init(
            red: rgba.red * rgba.alpha,
            green: rgba.green * rgba.alpha,
            blue: rgba.blue * rgba.alpha,
            alpha: rgba.alpha
        )
    }
}

extension PremultipliedRGBA { // Additional initializers
    public init(gray: Channel, alpha: Channel) {
        self.init(red: gray, green: gray, blue: gray, alpha: alpha)
    }
}

extension PremultipliedRGBA {
    public func map<T>(_ transform: (Channel) -> T) -> PremultipliedRGBA<T> where T : Numeric, T : Comparable {
        return PremultipliedRGBA<T>(
            red: transform(red),
            green: transform(green),
            blue: transform(blue),
            alpha: transform(alpha)
        )
    }
}

extension PremultipliedRGBA where Channel == UInt8 {
    public init(_ rgbaInt: UInt32) {
        self.init(red: UInt8((rgbaInt >> 24) & 0xFF), green: UInt8((rgbaInt >> 16) & 0xFF), blue: UInt8((rgbaInt >> 8) & 0xFF), alpha: UInt8(rgbaInt & 0xFF))
    }
}

extension PremultipliedRGBA : CustomStringConvertible {
    public var description: String {
        if let zelf = self as? PremultipliedRGBA<UInt8> {
            return String(format: "#%02X%02X%02X%02X", arguments: [zelf.red, zelf.green, zelf.blue, zelf.alpha])
        } else {
            return "PremultipliedRGBA(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha))"
        }
    }
}

extension PremultipliedRGBA : CustomDebugStringConvertible {
    public var debugDescription: String {
        return description
    }
}
