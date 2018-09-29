
extension URLSessionConfiguration {
    
    private static var isSwizzled: Bool = false
    
    private class func toggleSwizzleStubborn() {
        let defaultSelector = #selector(getter: self.default)
        let defaultStubbornSelector = #selector(self.stubborn_default)
        let ephemeralSelector = #selector(getter: self.ephemeral)
        let ephemeralStubbornSelector = #selector(self.stubborn_ephemeral)
        
        if self.isSwizzled {
            self.isSwizzled = false
            
            Stubborn.log("unswizzle", level: .verbose)
            
            URLSessionConfiguration.exchange(defaultStubbornSelector, with: defaultSelector)
            URLSessionConfiguration.exchange(ephemeralStubbornSelector, with: ephemeralSelector)
        } else {
            self.isSwizzled = true
            
            Stubborn.log("swizzle", level: .verbose)
            
            URLSessionConfiguration.exchange(defaultSelector, with: defaultStubbornSelector)
            URLSessionConfiguration.exchange(ephemeralSelector, with: ephemeralStubbornSelector)
        }
    }
    
    class func registerStubborn() {
        if !self.isSwizzled {
            self.toggleSwizzleStubborn()
        }
    }
    
    class func unregisterStubborn() {
        if self.isSwizzled {
            self.toggleSwizzleStubborn()
        }
    }
    
    private func registerClass(_ protocolClass: Swift.AnyClass) {
        self.protocolClasses = [protocolClass] + self.protocolClasses!
        Stubborn.log("registered class: \(self.protocolClasses ?? [])", level: .verbose)
    }
    
    @objc private class func stubborn_default() -> URLSessionConfiguration {
        Stubborn.log("using stubborn URLSessionConfiguration.default", level: .verbose)
        
        let configuration = self.stubborn_default()
        configuration.registerClass(StubbornProtocol.self)
        return configuration
    }
    
    @objc private class func stubborn_ephemeral() -> URLSessionConfiguration {
        Stubborn.log("using stubborn URLSessionConfiguration.ephemeral", level: .verbose)
        
        let configuration = self.stubborn_ephemeral()
        configuration.registerClass(StubbornProtocol.self)
        return configuration
    }
    
    private class func exchange(_ selector: Selector, with replacementSelector: Selector) {
        if let method = class_getClassMethod(self, selector),
            let replacementMethod = class_getClassMethod(self, replacementSelector) {
            method_exchangeImplementations(method, replacementMethod)
        }
    }

}
