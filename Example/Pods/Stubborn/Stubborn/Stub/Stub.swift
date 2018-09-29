
import QueryString

extension Stubborn {

    public class Stub {
        
        private var numberOfRequests: Int = 0
        
        var index: Int?
        public private(set) var url: Request.URL
        public var queryString: QueryString?
        public var body: Body.Dictionary?
        public var delay: Delay?
        var response: RequestResponse
        
        init(_ url: String, response: @escaping RequestResponse) {
            self.url = url
            self.response = response
        }
        
        convenience init(_ url: String, dictionary: Body.Dictionary) {
            self.init(url) { _ in dictionary }
        }
        
        convenience init(_ url: String, error: Body.Error) {
            self.init(url) { _ in error }
        }
        
        convenience init(_ url: String, simple: Body.Simple) {
            self.init(url) { _ in simple }
        }
        
        convenience init(_ url: String, resource: Body.Resource) {
            self.init(url) { _ in resource }
        }
        
        func loadBody(_ request: Request) -> Body {
            self.numberOfRequests += 1
            
            var request = request
            request.numberOfRequests = self.numberOfRequests
            
            return self.response(request)
        }
        
        func isStubbing(request: Request) -> Bool {
            guard request.url =~ self.url else {
                return false
            }
            if let queryString = self.queryString, queryString != request.queryString {
                return false
            }
            if let body = self.body, !(request.body?.contains(body) ?? false) {
                return false
            }
            return true
        }
        
    }
    
}

extension Stubborn.Stub: CustomStringConvertible {
    
    public var description: String {
        var description = "Stub({"
        description = "\(description)\n    Index: \(self.index ?? -1)"
        description = "\(description)\n    Url: \(self.url)"
        description = "\(description)\n    QueryString: \(self.queryString ?? QueryString())"
        description = "\(description)\n    Body: \(self.body ?? Stubborn.Body.Dictionary())"
        description = "\(description)\n    Delay: \(String(self.delay?.rawValue ?? 0))"
        description = "\(description)\n})"
        
        return description
    }
    
}

infix operator ⏱
infix operator ❓
infix operator ❗️

@discardableResult
public func ⏱ (delay: Stubborn.Delay?, stub: Stubborn.Stub) -> Stubborn.Stub {
    stub.delay = delay
    return stub
}

@discardableResult
public func ❓ (queryString: QueryString?, stub: Stubborn.Stub) -> Stubborn.Stub {
    stub.queryString = queryString
    return stub
}

@discardableResult
public func ❗️ (body: Stubborn.Body.Dictionary?, stub: Stubborn.Stub) -> Stubborn.Stub {
    stub.body = body
    return stub
}
