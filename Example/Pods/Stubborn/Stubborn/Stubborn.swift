
import Foundation

public class Stubborn {
    
    public enum LogLevel: Int {
        
        case debug
        case verbose
        
        var flag: String {
            switch self {
            case .debug:
                return "DEBUG  "
            case .verbose:
                return "VERBOSE"
            }
        }
        
    }
    
    public typealias RequestResponse = (Request) -> (Body)
    public typealias UnhandledRequestResponse = (Request) -> ()
    
    public static var logLevel: LogLevel?
    public static var isOn: Bool = false
    public static var isAllowingUnhandledRequest: Bool = false
    
    static private(set) var stubs: [Stub] = []
    static private(set) var unhandledRequestResponse: UnhandledRequestResponse?

    private init() {
        // Do nothing...
    }
    
    @discardableResult
    public static func add(url: String, response: @escaping RequestResponse) -> Stub {
        return self.add(stub: Stub(url, response: response))
    }
    
    @discardableResult
    public static func add(url: String, dictionary: Stubborn.Body.Dictionary) -> Stub {
        return self.add(stub: Stub(url, dictionary: dictionary))
    }
    
    @discardableResult
    public static func add(url: String, error: Stubborn.Body.Error) -> Stub {
        return self.add(stub: Stub(url, error: error))
    }
    
    @discardableResult
    public static func add(url: String, simple: Stubborn.Body.Simple) -> Stub {
        return self.add(stub: Stub(url, simple: simple))
    }
    
    @discardableResult
    public static func add(url: String, resource: Stubborn.Body.Resource) -> Stub {
        return self.add(stub: Stub(url, resource: resource))
    }
    
    private static func add(stub: Stub) -> Stub {
        self.start()
        
        stub.index = self.stubs.count
        self.stubs.append(stub)
        self.log("add stub: <\(stub)>")
        
        return stub
    }
    
    public static func unhandledRequest(_ response: @escaping UnhandledRequestResponse) {
        self.unhandledRequestResponse = response
    }
    
    public static func start() {
        guard !self.isOn else {
            return
        }
        
        self.isOn = true
        
        self.log("start")
        StubbornProtocol.register()
    }
    
    public static func reset() {
        self.log("reset")
        
        self.stubs = []
        self.unhandledRequestResponse = nil
    }
    
    static func log(_ message: String, level: LogLevel = .debug) {
        if level.rawValue <= (self.logLevel?.rawValue ?? -1) {
            print("Stubborn (\(self.stubs.count)): \(level.flag): \(message)")
        }
    }

}
