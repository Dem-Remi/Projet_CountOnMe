//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    var newCalcul: Calcul!
    
    override func setUp() {
        super.setUp()
        newCalcul = Calcul()
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    //MARK: - Basic calculations
    
    func testGiven1Plus1IsDisplay_WhenTheEqualIsChoosed_Then2IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 1 = 2")
    }
    
    func testGiven1Plus1IsDisplay_WhenThePlsIsChoosed_ThenAnErrorIsThrow() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        XCTAssertThrowsError(try newCalcul.addAdditionOperator())
    }
    
    func testGiven1Less1IsDisplay_WhenTheEqualIsChoosed_Then0IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addSubstractionOperator())
        newCalcul.addNumber("1")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 - 1 = 0")
    }
    
    func testGiven1Multiplies1IsDisplay_WhenTheEqualIsChoosed_Then1IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addMultiplicationOperator())
        newCalcul.addNumber("1")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 x 1 = 1")
    }
    
    func testGiven1Divide1IsDisplay_WhenTheEqualIsChoosed_Then1IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        newCalcul.addNumber("1")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 ÷ 1 = 1")
    }
    
    
    
    
    //MARK: - Prioritization
    
    func testGiven1Plus2Multiplies2IsDisplay_WhenTheEqualIsChoosed_Then5IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("2")
        XCTAssertNoThrow(try newCalcul.addMultiplicationOperator())
        newCalcul.addNumber("2")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 2 x 2 = 5")
    }
    
    func testGiven1Plus2Divide2IsDisplay_WhenTheEqualIsChoosed_Then2IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("2")
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        newCalcul.addNumber("2")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 2 ÷ 2 = 2")
    }
    
    func testGiven4DivideBy2MultiplyBy3Multiply9DivideBy6BIsDisplay_WhenTheEqualIsChoosed_Then96IsDisplay() throws {
        newCalcul.addNumber("4")
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        newCalcul.addNumber("2")
        XCTAssertNoThrow(try newCalcul.addMultiplicationOperator())
        newCalcul.addNumber("3")
        XCTAssertNoThrow(try newCalcul.addMultiplicationOperator())
        newCalcul.addNumber("9")
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        newCalcul.addNumber("6")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "4 ÷ 2 x 3 x 9 ÷ 6 = 9")
    }
    
    func testGiven1Plus1Equal2IsDisplay_When1IsChoosed_ThenTheCalculIsReset() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.calculate())
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 1 = 2")
        newCalcul.addNumber("5")
        XCTAssertEqual(newCalcul.textToDisplay, "5")
        
    }
    
    //MARK: - Comma
    func testGiven1Point5Plus2Divide2IsDisplay_WhenTheEqualIsChoosed_Then2IsDisplay() throws {
        newCalcul.addNumber("1")
        try newCalcul.addAPoint()
        XCTAssertEqual(newCalcul.textToDisplay, "1.")
    }
    
    //MARK: - To delete
    
    func testGiven2Plus1IsDisplay_WhenEraseTheLastIsChoosed_Then1PlusIsDisplay() throws {
        newCalcul.addNumber("2")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        try newCalcul.deleteTheLast()
        XCTAssertEqual(newCalcul.textToDisplay, "2 + ")
    }
    
    func testGiven2Plus1IsDisplay_WhenEraseAllIsChoosed_Then1PlusIsDisplay() throws {
        newCalcul.addNumber("2")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        try newCalcul.deleteAll()
        XCTAssertEqual(newCalcul.textToDisplay, "")
    }
    
    
    
    //MARK: - Test
    func testGiven1Divide2IsDisplay_WhenTheEqualIsChoosen_Then0Point5IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        newCalcul.addNumber("2")
        try newCalcul.calculate()
        try newCalcul.alreadyDecimalNumber()
        XCTAssertEqual(newCalcul.textToDisplay, "1 ÷ 2 = 0.5")
    }
    
    
    
    
    func testGiven1Plus2Equal3IsDisplay_When5IsChoosed_Then5IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("2")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 2 = 3")
        newCalcul.addNumber("5")
        XCTAssertEqual(newCalcul.textToDisplay, "5")

    }
}
