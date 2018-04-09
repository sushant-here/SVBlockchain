
import UIKit

public struct QueryString {

    private static let keyValueSep: String = "="
    private static let querySep: String = "&"
    private static let queryStart: String = "?"

    fileprivate var values: [String: String] = [:]

    public init() {}
    
    public init(key: String, value: String) {
        self.add(key: key, value: value)
    }
    
    public init?(url: String) {
        var url = url
        self.init(url: &url)
    }
    
    public init?(url: inout String) {
        let components = url.components(separatedBy: QueryString.queryStart)
        guard components.count == 2, let string = components.last else {
            return nil
        }
        
        url = QueryString.strip(from: url)
        
        self.init(string: string)
    }
    
    public init?(string: String) {
        let queries = string.components(separatedBy: QueryString.querySep)
        for query in queries {
            let keyValue = query.components(separatedBy: QueryString.keyValueSep)
            guard keyValue.count == 2, let key = keyValue.first, let value = keyValue.last else {
                continue
            }
            
            self.add(key: key, value: value)
        }
        
        if self.values.isEmpty {
            return nil
        }
    }

    public mutating func add(key: String, value: String) {
        self.values[key] = value.addingPercentEncoding(
            withAllowedCharacters: NSCharacterSet.urlQueryAllowed
        )
    }

    public func append(to url: String) -> String {
        guard !self.values.isEmpty else {
            return url
        }
        var url = url
        var queryString = QueryString(url: &url) ?? QueryString()
        queryString = queryString + self
        return "\(url)\(QueryString.queryStart)\(queryString.queryString)"
    }

    var queryString: String {
        var values: [String] = []
        for (key, value) in self.values {
            values.append("\(key)\(QueryString.keyValueSep)\(value)")
        }
        return values.joined(separator: QueryString.querySep)
    }
    
    private static func strip(from url: String) -> String {
        return url.components(separatedBy: QueryString.queryStart).first!
    }

}

extension QueryString: CustomStringConvertible {

    public var description: String {
        return "QueryString(\(self.queryString))"
    }

}

extension QueryString: ExpressibleByDictionaryLiteral {
    
    public typealias Key = String
    public typealias Value = String
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (key, value) in elements {
            self.add(key: key, value: value)
        }
    }
    
}

extension QueryString: Collection {
    
    public typealias Index = DictionaryIndex<Key, Value>
    
    public var startIndex: Index {
        return self.values.startIndex
    }
    
    public var endIndex: Index {
        return self.values.endIndex
    }
    
    public func index(after index: Index) -> Index {
        return self.values.index(after: index)
    }
    
    public subscript(index: Index) -> (key: Key, value: Value) {
        return self.values[index]
    }
    
    public subscript(index: Key) -> Value? {
        return self.values[index]
    }
    
}

extension QueryString: Equatable {}

public func == (lhs: QueryString, rhs: QueryString) -> Bool {
    return lhs.values == rhs.values
}

public func + (lhs: QueryString, rhs: QueryString) -> QueryString {
    var lhs = lhs
    for (key, value) in rhs.values {
        lhs.add(key: key, value: value)
    }
    return lhs
}
