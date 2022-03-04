//
//  RyanairAppTests.swift
//  RyanairAppTests
//
//  Created by Vitor Filincowsky on 02/03/2022.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import XCTest
@testable import RyanairApp

class RyanairAppTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFormatDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let input = dateFormatter.date(from: "2022-05-15 23:59:59")
        let output = Utils.formatDate(input)
        let expected = "2022-05-15"
        XCTAssertEqual(output, expected, "[FAIL]")
    }

    func testFormatDepartureTime() {
        let input = "2022-03-12T21:30:00.000"
        let output = Utils.formatDepartureTime(dateTime: input)
        let expected = "2022-03-12 21:30"
        XCTAssertEqual(output, expected, "[FAIL]")
    }
    
    func testAddParamsToUrl1() {
        let url = "url"
        let params = ["param": "value"]
        let output = API().addParamsToUrl(url, params: params)
        let expected = "url?param=value"
        XCTAssertEqual(output, expected, "[FAIL]")
    }
    
    func testAddParamsToUrl2() {
        let url = "url"
        let params = ["param1": "value1", "param2": "value2"]
        let output = API().addParamsToUrl(url, params: params)
        let expected = "url?param1=value1&param2=value2"
        XCTAssertEqual(output, expected, "[FAIL]")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
