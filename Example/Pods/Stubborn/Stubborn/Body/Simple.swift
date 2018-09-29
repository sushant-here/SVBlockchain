
extension Stubborn.Body {
    
    public class Simple: Stubborn.Body {
        
        public private(set) var statusCode: Stubborn.Request.StatusCode
        
        public convenience init(_ statusCode: Stubborn.Request.StatusCode, _ message: String) {
            self.init(statusCode, ["message": message])
        }
        
        public required init(_ statusCode: Stubborn.Request.StatusCode, _ body: InternalBody) {
            self.statusCode = statusCode
            
            super.init(body)
        }
        
        public required init(dictionaryLiteral elements: (Key, Value)...) {
            fatalError("not supported")
        }
        
    }
    
}

extension Stubborn.Body.Simple: CustomStringConvertible {
    
    public var description: String {
        var description = "StatusCode({"
        description = "\(description)\n    StatusCode: \(self.statusCode)"
        description = "\(description)\n})"
        
        return description
    }
    
}
