import ArgumentParser
import Foundation

struct Day4: ParsableCommand {
    @Option(name: .shortAndLong, help: "the input file")
    var inputPath: String = "Inputs/day4.txt"
    
    @Flag(name: .shortAndLong, help: "execute part2")
    var part2: Bool = false
    
    mutating func run() throws {
        let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
        
        let chunks = inputString.components(separatedBy: "\n\n").filter({ !$0.isEmpty })
        
        let passports = parsePassports(input: chunks)
        print(part1(passports: passports))
    }
    
    func part1(passports: [[String: String]]) -> Int {
        let requiredKeys: Set = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
        var validPassports = 0
        
        for passport in passports {
            let passportKeys = Set([String](passport.keys))
            
            if requiredKeys.isSubset(of: passportKeys) {
                validPassports += 1
            }
        }
        
        return validPassports
    }
    
    func parsePassports(input: [String]) -> [[String: String]] {
        var passports: [[String: String]] = []
        
        for chunk in input {
            let passport = chunk.components(separatedBy: .whitespacesAndNewlines).reduce(into: [String: String]()) {
                (passport, kvString) in
                let kv = kvString.components(separatedBy: ":")
                if kv.count == 2 {
                    passport[kv[0]] = kv[1]
                }
            }
            
            passports.append(passport)
        }
        
        return passports
    }
}

Day4.main()
