import ArgumentParser
import Foundation

extension AOC2020 {
    struct Day2: ParsableCommand {
        @OptionGroup var options: AOC2020.Options
        
        mutating func run() throws {
            let inputPath = options.inputPath ?? "Inputs/day2.txt"
            let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
            
            let pattern = try NSRegularExpression(pattern: "^(\\d+)-(\\d+) ([a-z]): ([a-z]*)$")
            let lines = inputString.components(separatedBy: "\n")
            
            var validPasswords = 0
            
            for line in lines {
                let groups = line.groups(for: pattern)
                if groups.count < 5 {
                    continue
                }
                
                if (!options.part2 && part1Check(groups: groups)) || (options.part2 && part2Check(groups: groups)) {
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

}
