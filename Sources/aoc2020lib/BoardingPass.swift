// day5

import Foundation

public struct BoardingPass {
    struct Seat {
        var row: Int
        var col: Int
        
        var id: Int {
            return (row * 8) + col
        }
    }
    
    var seats: [Seat]
    
    public init(input: [String]) {
        var seats: [Seat] = []
        
        for seat in input {
            var row: UInt8 = 0b00000000
            var col: UInt8 = 0b00000000
            
            // Just need to bitshift to calculate the value
            // Front -> 0, Back -> Shift 1 into the right place
            // Left -> 0, Right -> Shift 1 into the right place
            // First 7 chars are row, next 3 are column
            // RRRRRRR CCC
            // row: 7 - 1 = 6
            // col: 10 - 1 = 9, will start at idx 7
            for (idx, dir) in seat.enumerated() {
                if dir == "B" {
                    row |= 1 << (6 - idx)
                } else if dir == "R" {
                    col |= 1 << (9 - idx)
                }
            }
            
            seats.append(Seat(row: Int(row), col: Int(col)))
        }
        
        self.seats = seats
    }
    
    public func part1() -> Int? {
        return self.seats.map({ $0.id }).max()
    }
    
    public func part2() -> Int? {
        let allSeatIDs = Set(0...1023)
        let allocatedSeatIDs = Set(self.seats.map({ $0.id }))
        
        let unallocatedSeatIDs = allSeatIDs.subtracting(allocatedSeatIDs)
        
        for seatID in unallocatedSeatIDs {
            if allocatedSeatIDs.contains(seatID-1) && allocatedSeatIDs.contains(seatID+1) {
                return seatID
            }
        }
        
        return nil
    }
    
}
