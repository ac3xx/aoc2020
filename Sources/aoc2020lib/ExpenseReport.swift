// day1

import Foundation
import Combinatorics

public struct ExpenseReport {
    var target: Int
    
    public init(target: Int) {
        self.target = target
    }
    
    public func part1(input: String) -> Int? {
        return searchReport(input: input, size: 2)
    }
    
    public func part2(input: String) -> Int? {
        return searchReport(input: input, size: 3)
    }
    
    func searchReport(input: String, size: Int) -> Int? {
        let lines = input.split(whereSeparator: \.isNewline)
        let expenseReport = lines.compactMap({ Int($0) })
        
        let expensePairs = Combination(of: expenseReport, size: size)
        
        return expensePairs.first(where: { $0.reduce(0, +) == target })?.reduce(1, *)
    }
    
}
