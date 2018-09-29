
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
            if let error = self.body as? Body.Error {
                return error.statusCode
            } else if let statusCode = self.body as? Body.Simple {
                return statusCode.statusCode
            } else {
                return 200
            }
        }
        
        var data: Data {
            // NOTE(materik):
            // * seems I have to print the data in order to load it because sometime the data
            //   turns up empty even if it's cleary not. must be a better way but this is a fix for now
            print(self.body.data)
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
