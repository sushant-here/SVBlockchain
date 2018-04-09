
extension Stubborn.Body {

    public class Error: Stubborn.Body {

        public private(set) var statusCode: Stubborn.Request.StatusCode
        public private(set) var message: String
        
        public required init(_ statusCode: Stubborn.Request.StatusCode, _ message: String) {
            self.statusCode = statusCode
            self.message = message
            
            super.init(["error": self.message])
        }
        
        public required init(dictionaryLiteral elements: (Key, Value)...) {
            fatalError("not supported")
        }
        
        var error: Swift.Error? {
            return NSError(domain: "Error", code: self.statusCode, userInfo: [
                NSLocalizedDescriptionKey: self.message
            ])
        }
        
    }

}

extension Stubborn.Body.Error: CustomStringConvertible {
    
    public var description: String {
        var description = "Error({"
        description = "\(description)\n    StatusCode: \(self.statusCode)"
        description = "\(description)\n    Message: \(self.message)"
        description = "\(description)\n})"
        
        return description
    }

}
