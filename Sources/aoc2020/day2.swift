import ArgumentParser
import Foundation

import aoc2020lib

extension AOC2020 {
    struct Day2: ParsableCommand {
        @OptionGroup var options: AOC2020.Options
        
        mutating func run() throws {
            let passwords = try aoc2020lib.Passwords()
            let inputPath = options.inputPath ?? "Inputs/day2.txt"
            let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
            
            
            let lines = inputString.components(separatedBy: "\n")
            
            print("part1: \(passwords.part1(lines: lines))")
            print("part2: \(passwords.part2(lines: lines))")
        }
        
    }

}
