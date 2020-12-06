import XCTest
import class Foundation.Bundle

import aoc2020lib

class day5Tests: XCTestCase {
    let testInput = """
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL
"""
    
    func testPart1() {
        let boardingPass = aoc2020lib.BoardingPass(input: testInput.components(separatedBy: .newlines))
        
        let part1 = boardingPass.part1()
        XCTAssertNotNil(part1)
        XCTAssertEqual(part1, 820)
    }
    
    static var allTests = [
        ("testPart1", testPart1),
    ]
}
