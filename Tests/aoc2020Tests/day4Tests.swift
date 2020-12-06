import XCTest
import class Foundation.Bundle

import aoc2020lib

class day4Tests: XCTestCase {
    let testInput = """
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
"""
    
    func testPart1() {
        let chunks = testInput.components(separatedBy: "\n\n").filter({ !$0.isEmpty })
        let passports = try? aoc2020lib.Passports(input: chunks)
        XCTAssertNotNil(passports)
        
        let part1 = passports?.part1()
        
        XCTAssertNotNil(part1)
        XCTAssertEqual(part1, 2)
    }
    
    func testPart2() {
        let chunks = testInput.components(separatedBy: "\n\n").filter({ !$0.isEmpty })
        let passports = try? aoc2020lib.Passports(input: chunks)
        XCTAssertNotNil(passports)
        
        let part2 = passports?.part2()
        
        XCTAssertNotNil(part2)
        XCTAssertEqual(part2, 2)
    }
    
    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
