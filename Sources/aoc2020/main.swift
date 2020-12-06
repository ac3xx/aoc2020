import ArgumentParser
import Foundation

struct AOC2020: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "AOC2020 solutions.",
        subcommands: [Day1.self, Day2.self, Day3.self, Day4.self, Day5.self, Day6.self])
    
    struct Options: ParsableArguments {
        @Option(name: .shortAndLong, help: "the input file")
        var inputPath: String?
        
        @Flag(name: .shortAndLong, help: "execute part2")
        var part2: Bool = false
    }
    
}

AOC2020.main()
