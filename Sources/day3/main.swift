import ArgumentParser
import Foundation

struct Day3: ParsableCommand {
    @Option(name: .shortAndLong, help: "the input file")
    var inputPath: String = "Inputs/day3.txt"
    
    @Flag(name: .shortAndLong, help: "execute part2")
    var part2: Bool = false
    
    mutating func run() throws {
        let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
        let lines = inputString.components(separatedBy: "\n").filter({ !$0.isEmpty })
        
        let grid = parseGrid(input: lines)
        
        if !part2 {
            print(part1(grid: grid))
        }
    }
    
    func part1(grid: Grid) -> Int {
        return countTrees(grid: grid, moveVec: Point(x: 3, y: 1))
    }
    
    func countTrees(grid: Grid, moveVec: Point) -> Int {
        var currentPos = Point(x: 0, y: 0)
        var treeCount = 0
        
        while currentPos.y < grid.height {
            if grid.contents[currentPos.y][currentPos.x] == .tree {
                treeCount += 1
            }
            
            currentPos += moveVec
            currentPos.x %= grid.width
        }
        
        return treeCount
    }
    
    func parseGrid(input: [String]) -> Grid {
        let gridWidth = input[0].count
        let gridHeight = input.count
        var gridContents = Array(repeating: Array(repeating: GridSpace.invalid,
                                                  count: gridWidth),
                                 count: gridHeight)
        
        var y = 0
        for line in input {
            var x = 0
            for chr in line {
                if chr == "." {
                    gridContents[y][x] = GridSpace.open
                } else if chr == "#" {
                    gridContents[y][x] = GridSpace.tree
                } else {
                    fatalError("not a valid grid space")
                }
                
                x += 1
            }
            
            y += 1
        }
        
        return Grid(contents: gridContents,
                    width: gridWidth,
                    height: gridHeight)
    }
}

Day3.main()
