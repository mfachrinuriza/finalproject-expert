//
//  finalProjectTest.swift
//  finalProjectTest
//
//  Created by Muhammad Fachri Nuriza on 19/09/23.
//

import XCTest
@testable import final_project

final class finalProjectTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSumCount() throws {
        XCTAssertEqual(2+2, 4)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
