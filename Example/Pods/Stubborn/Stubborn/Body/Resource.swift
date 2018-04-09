
extension Stubborn.Body {

    public final class Resource: Stubborn.Body {
        
        public typealias StringLiteralType = String
        public typealias UnicodeScalarLiteralType = String
        public typealias ExtendedGraphemeClusterLiteralType = String
        
        fileprivate let ext: String = "json"
        
        fileprivate var name: String
        fileprivate var bundle: Bundle = Bundle.main
        fileprivate var subpath: String?
        
        private var path: String? {
            return self.bundle.path(
                forResource: self.name,
                ofType: self.ext,
                inDirectory: self.subpath
            )
        }
        
        public convenience init(stringLiteral value: String) {
            self.init(value)
        }
        
        public convenience init(unicodeScalarLiteral value: String) {
            self.init(value)
        }
        
        public convenience init(extendedGraphemeClusterLiteral value: String) {
            self.init(value)
        }
        
        public required init(_ resource: String, in bundle: Bundle = Bundle.main) {
            var pathComponents = resource.components(separatedBy: "/")
            
            self.name = pathComponents.popLast()!
            self.bundle = bundle
            self.subpath = pathComponents.joined(separator: "/")
            
            super.init([:])
        }
        
        public required init(dictionaryLiteral elements: (Key, Value)...) {
            fatalError("not supported")
        }
        
        override var data: Data {
            guard let path = self.path else {
                fatalError("Couldn't find \(self.name).\(self.ext)")
            }
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                fatalError("Couldn't load \(path)")
            }
            return data
        }
        
        public var exists: Bool {
            return self.path != nil
        }
        
    }

}

extension Stubborn.Body.Resource: CustomStringConvertible {
    
    public var description: String {
        return "Resource(\(self.name).\(self.ext))"
    }
    
}

extension Stubborn.Body.Resource: ExpressibleByStringLiteral {}
