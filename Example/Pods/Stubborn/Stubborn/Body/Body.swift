
extension Stubborn {

    public class Body {
        
        public typealias Key = String
        public typealias Value = Any
        
        public typealias InternalBody = [Key: Value]
        
        internal private(set) var body: InternalBody
        
        var data: Data {
            guard let data = try? JSONSerialization.data(withJSONObject: self.body, options: []) else {
                fatalError("Couldn't parse data")
            }
            return data
        }
        
        public required init(dictionaryLiteral elements: (Key, Value)...) {
            var body: InternalBody = [:]
            for (key, value) in elements {
                body[key] = value
            }
            self.body = body
        }
        
        init() {
            self.body = [:]
        }
        
        init(_ body: InternalBody) {
            self.body = body
        }
        
        init(_ elements: [(Key, Value)]) {
            var body: InternalBody = [:]
            for (key, value) in elements {
                body[key] = value
            }
            self.body = body
        }
        
        init?(_ body: InternalBody?) {
            guard let body = body else {
                return nil
            }
            self.body = body
        }
        
        func contains(_ body: Body) -> Bool {
            for (key, that) in body.body {
                guard let this = self.body[key], this == that else {
                    return false
                }
            }
            return true
        }
        
    }
    
}

extension Stubborn.Body: ExpressibleByDictionaryLiteral {}

extension Stubborn.Body: Collection {
    
    public typealias Index = DictionaryIndex<Key, Value>
    
    public var startIndex: Index {
        return self.body.startIndex
    }
    
    public var endIndex: Index {
        return self.body.endIndex
    }
    
    public func index(after index: Index) -> Index {
        return self.body.index(after: index)
    }
    
    public subscript(index: Index) -> (key: Key, value: Value) {
        return self.body[index]
    }
    
    public subscript(index: Key) -> Value? {
        return self.body[index]
    }
    
}

fileprivate func == (lhs: Any, rhs: Any) -> Bool {
    return String(describing: lhs) == String(describing: rhs)
}
