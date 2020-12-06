import XCTest
import class Foundation.Bundle

import aoc2020lib

class day1Tests: XCTestCase {
    let testInput = """
1721
979
366
299
675
1456
"""
    
    func testPart1() {
        let expenseReport = aoc2020lib.ExpenseReport(target: 2020)
        
        let part1 = expenseReport.part1(input: testInput)
        XCTAssertNotNil(part1)
        XCTAssertEqual(part1, 514579)
    }
    
    func testPart2() {
        let expenseReport = aoc2020lib.ExpenseReport(target: 2020)
        
        let part2 = expenseReport.part2(input: testInput)
        XCTAssertNotNil(part2)
        XCTAssertEqual(part2, 241861950)
    }
    
    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
