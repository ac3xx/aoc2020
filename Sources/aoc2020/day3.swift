import ArgumentParser
import Foundation

import aoc2020lib

extension AOC2020 {
    struct Day3: ParsableCommand {
        @OptionGroup var options: AOC2020.Options
        
        mutating func run() throws {
            let inputPath = options.inputPath ?? "Inputs/day3.txt"
            let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
            let lines = inputString.components(separatedBy: "\n").filter({ !$0.isEmpty })
            
            let grid = aoc2020lib.Grid(input: lines)
            
            print("part1: \(grid.part1())")
            print("part2: \(grid.part2())")
        }
    }
}
