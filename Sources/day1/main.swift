import ArgumentParser
import Foundation
import Combinatorics

struct Day1: ParsableCommand {
    @Option(name: .shortAndLong, help: "the input file to day1")
    var inputPath: String = "Inputs/day1.txt"
    
    @Option(name: .shortAndLong, help: "target")
    var target: Int = 2020
    
    @Flag(name: .shortAndLong, help: "searches for 3 expenses")
    var part2: Bool = false
    
    mutating func run() throws {
        let numExpenses = part2 ? 3 : 2
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

Day1.main()
