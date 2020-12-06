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
        
        if !part2 {
            print(part1(passports: passports))
        } else {
            print(try part2(passports: passports))
        }
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
    
    func part2(passports: [[String: String]]) throws -> Int {
        let colourPattern = try NSRegularExpression(pattern: "^([0-9]{1,3})(cm|in)$")
        let requiredKeys: Set = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
        var validPassports = 0
        
        print("total passports: \(passports.count)")
        
        for passport in passports {
            let passportKeys = Set([String](passport.keys))
            var passportFields: [String: PassportField] = [:]
            
            for (key, value) in passport {
                var passportField: PassportField = StringField(key: key, value: value, type: .Other)
                
                switch key {
                case "byr":
                    passportField = IntRangeField(key: "byr", value: Int(value) ?? 0, type: .Birth)
                case "iyr":
                    passportField = IntRangeField(key: "iyr", value: Int(value) ?? 0, type: .Issue)
                case "eyr":
                    passportField = IntRangeField(key: "eyr", value: Int(value) ?? 0, type: .Expiry)
                case "hgt":
                    let heightGroups = value.groups(for: colourPattern)
                    if heightGroups.count >= 3 {
                        let height = Int(heightGroups[1]) ?? 0
                        let unit = (heightGroups[2] == "cm") ? IntType.HeightCm : IntType.HeightIn
                        passportField = IntRangeField(key: "hgt", value: height, type: unit)
                    } else {
                        passportField = IntRangeField(key: "hgt", value: 0, type: IntType.HeightCm)
                    }
                case "hcl":
                    passportField = StringField(key: "hcl", value: value, type: .Hair)
                case "ecl":
                    passportField = StringField(key: "ecl", value: value, type: .Eye)
                case "pid":
                    passportField = StringField(key: "pid", value: value, type: .PassportNum)
                case "cid":
                    passportField = StringField(key: "cid", value: value, type: .Other)
                default:
                    print("unknown key \(key)")
                }
                
                passportFields[key] = passportField
            }
            
            if passportFields.values.map({ $0.isValid() }).reduce(true, { $0 && $1 }) &&
                requiredKeys.isSubset(of: passportKeys) {
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
