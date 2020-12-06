// Supporting data types

enum GridSpace {
    case invalid
    case tree
    case open
}

struct Grid {
    var contents: [[GridSpace]] = []
    var width: Int
    var height: Int
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
