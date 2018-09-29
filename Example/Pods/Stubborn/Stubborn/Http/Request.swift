
import QueryString

extension Stubborn {

    public struct Request {
        
        public typealias URL = String
        public typealias StatusCode = Int
        
        private var request: URLRequest
        
        public var method: Method?
        public var url: URL
        public var queryString: QueryString?
        public var body: Body.Dictionary?
        public var headers: Body.Headers?
        public var numberOfRequests: Int?
        
        var isLoadingStream: Bool = false
        
        init(request: URLRequest) {
            self.request = request
            
            self.method = Method(rawValue: request.httpMethod ?? "")
            self.url = request.url!.absoluteString
            self.queryString = QueryString(url: &self.url)
            self.body = Body.Dictionary(request.httpBody)
            self.headers = Body.Headers(request.allHTTPHeaderFields)
            
            self.loadStream(with: request)
        }
        
        private mutating func loadStream(with request: URLRequest) {
            guard let stream = request.httpBodyStream else {
                return
            }
            
            self.isLoadingStream = true
            stream.open()
            
            var data = Data()
            var buffer = [UInt8](repeating: 0, count: 4096)
            
            while stream.hasBytesAvailable {
                let count = stream.read(&buffer, maxLength: 4096)
                guard count > 0 else {
                    break
                }
                data.append(&buffer, count: count)
            }
            
            self.body = Body.Dictionary(data)
            self.isLoadingStream = false
        }
        
    }

}

extension Stubborn.Request: CustomStringConvertible {
    
    public var description: String {
        let nilString = "<nil>"
        
        var description = "Request({"
        description = "\(description)\n    Method: \(self.method?.rawValue ?? nilString)"
        description = "\(description)\n    Url: \(self.url)"
        description = "\(description)\n    QueryString: \(self.queryString ?? QueryString())"
        description = "\(description)\n    Body: \(self.body ?? Stubborn.Body.Dictionary())"
        description = "\(description)\n    Headers: \(self.headers ?? Stubborn.Body.Headers())"
        description = "\(description)\n    NumberOfRequests: \(self.numberOfRequests ?? 0)"
        description = "\(description)\n})"
        
        return description
    }
    
}
