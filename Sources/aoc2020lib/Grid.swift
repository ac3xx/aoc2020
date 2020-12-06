// Supporting data types

enum GridSpace {
    case invalid
    case tree
    case open
}

public struct Grid {
    var contents: [[GridSpace]] = []
    var width: Int
    var height: Int
    
    public init(input: [String]) {
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
        
        self.contents = gridContents
        self.width = gridWidth
        self.height = gridHeight
    }
    
    public func part1() -> Int {
        return countTrees(moveVec: Point(x: 3, y: 1))
    }
    
    public func part2() -> Int {
        let moveVecs = [
            Point(x: 1, y: 1),
            Point(x: 3, y: 1),
            Point(x: 5, y: 1),
            Point(x: 7, y: 1),
            Point(x: 1, y: 2)
        ]
        
        return moveVecs.map({ countTrees(moveVec: $0) }).reduce(1, *)
    }
    
    func countTrees(moveVec: Point) -> Int {
        var currentPos = Point(x: 0, y: 0)
        var treeCount = 0
        
        while currentPos.y < self.height {
            if self.contents[currentPos.y][currentPos.x] == .tree {
                treeCount += 1
            }
            
            currentPos += moveVec
            currentPos.x %= self.width
        }
        
        return treeCount
    }
}

struct Point {
    var x: Int
    var y: Int
}

extension Point {
    static func +=(lhs: inout Point, rhs: Point) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}
