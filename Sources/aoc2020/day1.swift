import ArgumentParser
import Foundation
import Combinatorics

extension AOC2020 {
    struct Day1: ParsableCommand {
        @OptionGroup var options: AOC2020.Options
        
        @Option(name: .shortAndLong, help: "target")
        var target: Int = 2020
        
        mutating func run() throws {
            let inputPath = options.inputPath ?? "Inputs/day1.txt"
            let numExpenses = options.part2 ? 3 : 2
            
            let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
            
            if let output = searchReport(input: inputString, size: numExpenses) {
                print("\(output)")
            } else {
                fatalError("no combination found")
            }
        }
        
        func searchReport(input: String, size: Int) -> Int? {
            let lines = input.split(whereSeparator: \.isNewline)
            let expenseReport = lines.compactMap({ Int($0) })
            
            let expensePairs = Combination(of: expenseReport, size: size)
            
            return expensePairs.first(where: { $0.reduce(0, +) == target })?.reduce(1, *)
        }
    }
}
