// day2
import Foundation

public struct Passwords {
    
    var pattern: NSRegularExpression
    
    public init() throws {
        self.pattern = try NSRegularExpression(pattern: "^(\\d+)-(\\d+) ([a-z]): ([a-z]*)$")
    }
    
    typealias PasswordHandler = (_: [String]) -> Bool
    
    public func part1(lines: [String]) -> Int {
        return checkLines(lines: lines, handler: part1Check(groups:))
    }
    
    public func part2(lines: [String]) -> Int {
        return checkLines(lines: lines, handler: part2Check(groups:))
    }
    
    func checkLines(lines: [String], handler: PasswordHandler) -> Int {
        var validPasswords = 0
        
        for line in lines {
            let groups = line.groups(for: pattern)
            if groups.count < 5 {
                continue
            }
            
            if handler(groups) {
                validPasswords += 1
            }
        }
        
        return validPasswords
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
