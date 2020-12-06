import XCTest
import class Foundation.Bundle

import aoc2020lib

class day2Tests: XCTestCase {
    let testInput = """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""
    
    func testPart1() {
        let passwords = try? aoc2020lib.Passwords()
        XCTAssertNotNil(passwords)
        
        let lines = testInput.components(separatedBy: "\n")
        
        let part1 = passwords?.part1(lines: lines)
        
        XCTAssertNotNil(part1)
        XCTAssertEqual(part1, 2)
    }
    
    func testPart2() {
        let passwords = try? aoc2020lib.Passwords()
        XCTAssertNotNil(passwords)
        
        let lines = testInput.components(separatedBy: "\n")
        
        let part2 = passwords?.part2(lines: lines)
        
        XCTAssertNotNil(part2)
        XCTAssertEqual(part2, 1)
    }
    
    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
