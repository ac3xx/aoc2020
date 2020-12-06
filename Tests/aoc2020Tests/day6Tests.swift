import XCTest
import class Foundation.Bundle

import aoc2020lib

class day6Tests: XCTestCase {
    let testInput = """
abc

a
b
c

ab
ac

a
a
a
a

b
"""
    
    func testPart1() {
        let chunks = testInput.components(separatedBy: "\n\n").filter({ !$0.isEmpty })
        let day6 = aoc2020lib.Day6()
        
        let part1 = day6.part1(input: chunks)
        XCTAssertNotNil(part1)
        XCTAssertEqual(part1, 11)
    }
    
    func testPart2() {
        let chunks = testInput.components(separatedBy: "\n\n").filter({ !$0.isEmpty })
        let day6 = aoc2020lib.Day6()
        
        let part2 = day6.part2(input: chunks)
        XCTAssertNotNil(part2)
        XCTAssertEqual(part2, 6)
    }
    
    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
