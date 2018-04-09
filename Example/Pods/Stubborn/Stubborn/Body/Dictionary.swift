
extension Stubborn.Body {

    public class Dictionary: Stubborn.Body {
        
        public required init?(_ data: Data?) {
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let body = json as? InternalBody else {
                    return nil
            }
            super.init(body)
        }
        
        public required init(dictionaryLiteral elements: (Key, Value)...) {
            super.init(elements)
        }
        
    }

}

extension Stubborn.Body.Dictionary: CustomStringConvertible {
    
    public var description: String {
        return "Dictionary(\(self.body))"
    }
    
}
