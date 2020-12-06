import Foundation

extension String {
    func groups(for regexPattern: NSRegularExpression) -> [String] {
        let text = self
        
        if let match = regexPattern.firstMatch(in: text, options: [], range: NSRange(text.startIndex..., in: text)) {
            
            return (0..<match.numberOfRanges).map {
                            let rangeBounds = match.range(at: $0)
                            guard let range = Range(rangeBounds, in: text) else {
                                return ""
                            }
                            return String(text[range])
                        }
        } else {
            return []
        }
    }
}

extension String {
    func count(of needle: Character) -> Int {
        return reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}
