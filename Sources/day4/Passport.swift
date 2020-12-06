import Foundation

protocol PassportField {
    func isValid() -> Bool
}

enum IntType {
    case Birth
    case Issue
    case Expiry
    case HeightCm
    case HeightIn
}

struct IntRangeField: PassportField {
    var key: String
    var value: Int
    var intType: IntType
    
    init(key: String, value: Int, type: IntType) {
        self.key = key
        self.value = value
        self.intType = type
    }
    
    func startValue() -> Int {
        switch self.intType {
        case .Birth:
            return 1920
        case .Issue:
            return 2010
        case .Expiry:
            return 2020
        case .HeightCm:
            return 150
        case .HeightIn:
            return 59
        }
    }
    
    func endValue() -> Int {
        switch self.intType {
        case .Birth:
            return 2002
        case .Issue:
            return 2020
        case .Expiry:
            return 2030
        case .HeightCm:
            return 193
        case .HeightIn:
            return 76
        }
    }
    
    func isValid() -> Bool {
        return value >= self.startValue() && value <= self.endValue()
    }
}

let colourPattern = try? NSRegularExpression(pattern: "^#[a-f0-9]{6}$")
let validEyeColours = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
let passportNumPattern = try? NSRegularExpression(pattern: "^[0-9]{9}$")

enum StringType {
    case Hair
    case Eye
    case PassportNum
    case Other
}

struct StringField: PassportField {
    var key: String
    var value: String
    var type: StringType
    
    init(key: String, value: String, type: StringType) {
        self.key = key
        self.value = value
        self.type = type
    }
    
    func isValid() -> Bool {
        switch self.type {
        case .Hair:
            return validateHairColour()
        case .Eye:
            return validateEyeColour()
        case .PassportNum:
            return validatePassportNum()
        case .Other:
            return true
        }
    }
    
    func validateHairColour() -> Bool {
        if let colourPattern = colourPattern {
            return colourPattern.firstMatch(in: self.value, options: [], range: NSRange(location: 0, length: self.value.count)) != nil
        }
        
        return false
    }
    
    func validateEyeColour() -> Bool {
        return validEyeColours.contains(self.value)
    }
    
    func validatePassportNum() -> Bool {
        if let passportNumPattern = passportNumPattern {
            return passportNumPattern.firstMatch(in: self.value, options: [], range: NSRange(location: 0, length: self.value.count)) != nil
        }
        
        return false
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
