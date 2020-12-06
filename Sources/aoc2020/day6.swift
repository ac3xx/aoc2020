import ArgumentParser
import Foundation

import aoc2020lib

extension AOC2020 {
    struct Day6: ParsableCommand {
        @OptionGroup var options: AOC2020.Options
        
        mutating func run() throws {
            let inputPath = options.inputPath ?? "Inputs/day6.txt"
            let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath)) + String("\n")
            let chunks = inputString.components(separatedBy: "\n\n").filter({ !$0.isEmpty })
            
            let day6 = aoc2020lib.Day6()
            
            print("part1: \(day6.part1(input: chunks))")
            print("part2: \(day6.part2(input: chunks))")
        }
    }
}


