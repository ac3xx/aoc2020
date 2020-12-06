import ArgumentParser
import Foundation

extension AOC2020 {
    struct Day5: ParsableCommand {
        @OptionGroup var options: AOC2020.Options
        
        mutating func run() throws {
            let inputPath = options.inputPath ?? "Inputs/day5.txt"
            let inputString =  try String(contentsOf: URL(fileURLWithPath: inputPath))
            let lines = inputString.components(separatedBy: "\n").filter({ !$0.isEmpty })
            
            let seats = parseSeats(input: lines)
            
            if options.part2, let part2 = part2(seats: seats) {
                print(part2)
            } else if !options.part2, let part1 = part1(seats: seats) {
                print(part1)
            }
        }
        
        func part1(seats: [Seat]) -> Int? {
            return seats.map({ $0.id }).max()
        }
        
        func part2(seats: [Seat]) -> Int? {
            let allSeatIDs = Set(0...1023)
            let allocatedSeatIDs = Set(seats.map({ $0.id }))
            
            let unallocatedSeatIDs = allSeatIDs.subtracting(allocatedSeatIDs)
            
            for seatID in unallocatedSeatIDs {
                if allocatedSeatIDs.contains(seatID-1) && allocatedSeatIDs.contains(seatID+1) {
                    return seatID
                }
            }
            
            return nil
        }
        
        func parseSeats(input: [String]) -> [Seat] {
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
            
            return seats
        }
    }
}

struct Seat {
    var row: Int
    var col: Int
    
    var id: Int {
        return (row * 8) + col
    }
}
