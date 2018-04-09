
extension Stubborn {

    public struct Delay {
        
        public fileprivate(set) var rawValue: TimeInterval
        
        public init(_ rawValue: TimeInterval = 0) {
            self.rawValue = rawValue
        }
        
        func asyncAfter(_ fire: @escaping () -> ()) {
            DispatchQueue.main.asyncAfter(
                deadline: DispatchTime.now() + self.rawValue,
                execute: fire
            )
        }
        
    }
    
}

extension Stubborn.Delay: CustomStringConvertible {
    
    public var description: String {
        return "Delay(\(self.rawValue))"
    }
    
}

extension Stubborn.Delay: ExpressibleByFloatLiteral {
    
    public typealias FloatLiteralType = TimeInterval
    
    public init(floatLiteral value: TimeInterval) {
        self.rawValue = value
    }
    
}

extension Stubborn.Delay: ExpressibleByIntegerLiteral {
    
    public typealias IntegerLiteralType = TimeInterval
    
    public init(integerLiteral value: TimeInterval) {
        self.rawValue = value
    }
    
}

public func + (lhs: Stubborn.Delay, rhs: Stubborn.Delay) -> Stubborn.Delay {
    return Stubborn.Delay(lhs.rawValue + rhs.rawValue)
}
