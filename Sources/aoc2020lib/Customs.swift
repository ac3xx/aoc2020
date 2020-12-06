// day6

import Foundation

public struct Day6 {
    let characterSet = Set((97...122).map({Character(UnicodeScalar($0))}))
    
    public init() {}
    
    public func part1(input: [String]) -> Int {
        var count = 0

        for chunk in input {
            let distinctChars = Set(chunk)

            let intersection = self.characterSet.intersection(distinctChars)
            count += intersection.count
        }
        
        return count
    }
    
    public func part2(input: [String]) -> Int {
        var count = 0

        for chunk in input {
            var set = characterSet

            for person in chunk.components(separatedBy: "\n") {
                set = set.intersection(Set(person))
            }

            count += set.count
        }
        
        return count
    }
    
}
