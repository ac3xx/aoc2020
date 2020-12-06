import XCTest
import class Foundation.Bundle

final class day1Tests: XCTestCase {
    
    let testPath = "Inputs/day1_test.txt"
    
    // part 1 has a target of 2020, with 2 expenses
    // should output 514579
    func testPart1() throws {
        let output = try? executeDay1(inputPath: testPath, target: "2020")

        XCTAssertEqual(output, "514579\n")
    }
    
    // part 2 has a target of 2020, with 3 expenses
    // should output 241861950
    func testPart2() throws {
        let output = try? executeDay1(inputPath: testPath, target: "2020", part2: true)

        XCTAssertEqual(output, "241861950\n")
    }
    
    func executeDay1(inputPath: String, target: String, part2: Bool = false) throws -> String? {
        guard #available(macOS 10.13, *) else {
            return nil
        }

        let day1Binary = productsDirectory.appendingPathComponent("day1")

        let process = Process()
        process.executableURL = day1Binary

        let pipe = Pipe()
        process.standardOutput = pipe

        process.arguments = ["-i", inputPath, "-t", target]
        if part2 {
            process.arguments? += ["--part2"]
        }

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
    
}
