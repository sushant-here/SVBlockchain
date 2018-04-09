
extension Stubborn.Body {
    
    public class Headers: Stubborn.Body {
        
        public required init?(_ allHTTPHeaderFields: [String: String]?) {
            guard let body = allHTTPHeaderFields else {
                return nil
            }
            super.init(body)
        }
        
        public required init(dictionaryLiteral elements: (Key, Value)...) {
            super.init(elements)
        }
        
    }
    
}

extension Stubborn.Body.Headers: CustomStringConvertible {
    
    public var description: String {
        return "Headers(\(self.body))"
    }
    
}
