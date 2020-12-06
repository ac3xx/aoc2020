import ArgumentParser
import Foundation
import Combinatorics

import aoc2020lib

extension AOC2020 {
    struct Day1: ParsableCommand {
        @OptionGroup var options: AOC2020.Options
        
        @Option(name: .shortAndLong, help: "target")
        var target: Int = 2020
        
        mutating func run() throws {
            let expenseReport = aoc2020lib.ExpenseReport(target: target)
            let inputPath = options.inputPath ?? "Inputs/day1.txt"
            
            let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
            
            if let part1 = expenseReport.part1(input: inputString) {
                print("part1: \(part1)")
            }
            
            if let part2 = expenseReport.part2(input: inputString) {
                print("part2: \(part2)")
            }
        }
    }
}
