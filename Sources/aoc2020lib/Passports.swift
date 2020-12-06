// day4

import Foundation

public struct Passports {
    
    var passports: [[String: String]]
    let colourPattern: NSRegularExpression
    
    public init(input: [String]) throws {
        self.colourPattern = try NSRegularExpression(pattern: "^([0-9]{1,3})(cm|in)$")
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
        
        self.passports = passports
    }
    
    public func part1() -> Int {
        let requiredKeys: Set = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
        var validPassports = 0
        
        for passport in self.passports {
            let passportKeys = Set([String](passport.keys))
            
            if requiredKeys.isSubset(of: passportKeys) {
                validPassports += 1
            }
        }
        
        return validPassports
    }
    
    public func part2() -> Int {
        let requiredKeys: Set = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
        var validPassports = 0
        
        for passport in self.passports {
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
                    let heightGroups = value.groups(for: self.colourPattern)
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
}
