//
//  ExtensionTests.swift
//  Calculator
//
//  Created by Wayne Rumble on 22/06/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Calculator

class ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDoubleRoundsToNumberOfPlaces() {
        let tenPlaceDigit = 7.0123456789
        let result = tenPlaceDigit.roundTo(places: 5)
        
        XCTAssertEqual(result, 7.01235)
    }
    
    func testRemovesZeroFromWholeNumber() {
        let oneDecimalPlace = 1.0
        let result = oneDecimalPlace.cleanValue
        
        XCTAssertEqual(result, "1")
    }
}
