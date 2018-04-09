
extension Stubborn {

    class Response {

        let url: Request.URL
        let body: Body
        
        var response: HTTPURLResponse {
            return HTTPURLResponse(
                url: Foundation.URL(string: self.url)!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: [
                    "Content-Type": "application/json",
                    "Content-Length": String(self.data.count),
                ]
            )!
        }
        
        var statusCode: Request.StatusCode {
            return (self.body as? Body.Error)?.statusCode ?? 200
        }
        var data: Data {
            return self.body.data
        }
        var error: Swift.Error? {
            return (self.body as? Body.Error)?.error
        }
        
        init(request: Request) {
            self.url = request.url
            self.body = Body([:])
        }
        
        init?(request: Request, stub: Stub) {
            guard stub.isStubbing(request: request) else {
                return nil
            }
            self.url = request.url
            self.body = stub.loadBody(request)
        }
        
    }
    
}
