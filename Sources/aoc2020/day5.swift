import ArgumentParser
import Foundation

import aoc2020lib

extension AOC2020 {
    struct Day5: ParsableCommand {
        @OptionGroup var options: AOC2020.Options
        
        mutating func run() throws {
            let inputPath = options.inputPath ?? "Inputs/day5.txt"
            let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
            let lines = inputString.components(separatedBy: "\n").filter({ !$0.isEmpty })
            
            let boardingPass = aoc2020lib.BoardingPass(input: lines)
            
            if let part1 = boardingPass.part1() {
                print("part1: \(part1)")
            }
            
            if let part2 = boardingPass.part2() {
                print("part2: \(part2)")
            }
        }
    }
}


