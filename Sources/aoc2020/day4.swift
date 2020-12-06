import ArgumentParser
import Foundation

import aoc2020lib

extension AOC2020 {
    struct Day4: ParsableCommand {
        @OptionGroup var options: AOC2020.Options
        
        mutating func run() throws {
            let inputPath = options.inputPath ?? "Inputs/day4.txt"
            let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
            
            let chunks = inputString.components(separatedBy: "\n\n").filter({ !$0.isEmpty })
            
            let passports = try aoc2020lib.Passports(input: chunks)
            
            print("part1: \(passports.part1())")
            print("part2: \(passports.part2())")
        }
        
        
    }
}
