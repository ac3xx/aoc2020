import ArgumentParser
import Foundation

struct Day2: ParsableCommand {
    @Option(name: .shortAndLong, help: "the input file to day2")
    var inputPath: String = "Inputs/day2.txt"
    
    @Flag(name: .shortAndLong, help: "execute part2")
    var part2: Bool = false
    
    mutating func run() throws {
        let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
        
        let pattern = try NSRegularExpression(pattern: "^(\\d+)-(\\d+) ([a-z]): ([a-z]*)$")
        let lines = inputString.components(separatedBy: "\n")
        
        var validPasswords = 0
        
        for line in lines {
            let groups = line.groups(for: pattern)
            if groups.count < 5 {
                continue
            }
            
            if (!part2 && part1Check(groups: groups)) || (part2 && part2Check(groups: groups)) {
                validPasswords += 1
            }
        }
        
        print(validPasswords)
    }
    
    func part1Check(groups: [String]) -> Bool {
        if let startCount = Int(groups[1]), let endCount = Int(groups[2]) {
            let characterReq = groups[3]
            let password = groups[4]
            
            let count = password.count(of: characterReq[characterReq.startIndex])
            
            return count >= startCount && count <= endCount
        }
        
        return false
    }
    
    func part2Check(groups: [String]) -> Bool {
        if let startCount = Int(groups[1]), let endCount = Int(groups[2]) {
            let characterReqStr = groups[3]
            let password = groups[4]
            let characterReq = characterReqStr[characterReqStr.startIndex]
            
            let firstChar = password[password.index(password.startIndex, offsetBy: startCount-1)]
            let secondChar = password[password.index(password.startIndex, offsetBy: endCount-1)]
            
            return firstChar != secondChar && (firstChar == characterReq || secondChar == characterReq)
        }
        return false
    }
    
}

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

Day2.main()
