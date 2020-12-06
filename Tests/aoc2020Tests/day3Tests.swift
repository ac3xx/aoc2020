import XCTest
import class Foundation.Bundle

import aoc2020lib

class day3Tests: XCTestCase {
    let testInput = """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""
    
    func testPart1() {
        let lines = testInput.components(separatedBy: "\n")
        let grid = aoc2020lib.Grid(input: lines)
        
        let part1 = grid.part1()
        
        XCTAssertNotNil(part1)
        XCTAssertEqual(part1, 7)
    }
    
    func testPart2() {
        let lines = testInput.components(separatedBy: "\n")
        let grid = aoc2020lib.Grid(input: lines)
        
        let part2 = grid.part2()
        
        XCTAssertNotNil(part2)
        XCTAssertEqual(part2, 336)
    }
    
    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
