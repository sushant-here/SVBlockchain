
class Regex {
    
    private(set) var pattern: String
    
    private var regularExpresion: NSRegularExpression? {
        return try? NSRegularExpression(pattern: self.pattern, options: .caseInsensitive)
    }
    
    init(_ pattern: String) {
        self.pattern = pattern
    }
    
    func matches(_ string: String) -> Bool {
        let range = (string as NSString).range(of: string)
        let matches = self.regularExpresion?.matches(in: string, options: [], range: range)
        return (matches?.count ?? 0) > 0
    }
    
}

infix operator =~

func =~ (input: String, pattern: String) -> Bool {
    return Regex(pattern).matches(input)
}
