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
    
    
    //MARK: - Basic situations
    
    func testGivenNothingHasBeenDone_WhenTheNumber7IsChoosed_Then1IsDisplay() {
        newCalcul.addNumber("7")
        XCTAssertEqual(newCalcul.textToDisplay, "7")
    }
    
    func testGiven8IsDisplay_WhenThePlusIsChoosed_ThenPlusIsAddToDisplay() throws {
        newCalcul.addNumber("8")
        try newCalcul.addAdditionOperator()
        XCTAssertEqual(newCalcul.textToDisplay, "8 + ")
    }
    
    func testGiven9IsDisplay_WhenTheMinusIsChoosed_ThenMinusIsAddToDisplay() throws {
        newCalcul.addNumber("9")
        try newCalcul.addSubstractionOperator()
        XCTAssertEqual(newCalcul.textToDisplay, "9 - ")
    }
    
        func testGiven10IsDisplay_WhenTheMultiplyIsChoosed_ThenMultiplyIsAddToDisplay() throws {
            newCalcul.addNumber("10")
            try newCalcul.addMultiplicationOperator()
            XCTAssertEqual(newCalcul.textToDisplay, "10 x ")
        }
    
        func testGiven0IsDisplay_WhenTheDivideIsChoosed_ThenDivideIsAddToDisplay() throws {
            newCalcul.addNumber("0")
            try newCalcul.addDivisionOperator()
            XCTAssertEqual(newCalcul.textToDisplay, "0 ÷ ")
        }
    
    
    //MARK: - Basic calculations
    
    func testGiven5Plus2IsDisplay_WhenTheEqualIsChoosed_Then2IsDisplay() throws {
        newCalcul.addNumber("5")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("2")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "5 + 2 = 7")
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
    
    func testGiven2Less3IsDisplay_WhenTheEqualIsChoosed_ThenMinus1IsDisplay() throws {
        newCalcul.addNumber("2")
        XCTAssertNoThrow(try newCalcul.addSubstractionOperator())
        newCalcul.addNumber("3")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "2 - 3 = -1")
    }
    
    func testGiven1Multiplies1IsDisplay_WhenTheEqualIsChoosed_Then1IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addMultiplicationOperator())
        newCalcul.addNumber("1")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 x 1 = 1")
    }
    
    func testGiven9Divide3IsDisplay_WhenTheEqualIsChoosed_Then3IsDisplay() throws {
        newCalcul.addNumber("9")
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        newCalcul.addNumber("3")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "9 ÷ 3 = 3")
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
    
    
    //MARK: - Comma
    
    func testGiven1Point5Plus2Divide2IsDisplay_WhenTheEqualIsChoosed_Then2IsDisplay() throws {
        newCalcul.addNumber("1")
        try newCalcul.addAPoint()
        XCTAssertEqual(newCalcul.textToDisplay, "1.")
    }
    
    func testGiven1Divide2IsDisplay_WhenTheEqualIsChoosen_Then0Point5IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        newCalcul.addNumber("2")
        XCTAssertNoThrow(try newCalcul.calculate())
//        try newCalcul.alreadyDecimalNumber()
        XCTAssertNoThrow(try newCalcul.alreadyDecimalNumber())
        XCTAssertEqual(newCalcul.textToDisplay, "1 ÷ 2 = 0.5")
    }
    
    
    //MARK: - To delete
    
    // Delete the last
    func testGiven2Plus1IsDisplay_WhenEraseTheLastIsChoosed_Then1PlusIsDisplay() throws {
        newCalcul.addNumber("2")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        try newCalcul.deleteTheLast()
        XCTAssertEqual(newCalcul.textToDisplay, "2 + ")
    }
    
    // Delete all
    func testGiven2Plus1IsDisplay_WhenEraseAllIsChoosed_Then1PlusIsDisplay() throws {
        newCalcul.addNumber("2")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        try newCalcul.deleteAll()
        XCTAssertEqual(newCalcul.textToDisplay, "")
    }
    
    // Delete the calculation and keep the result
    func testGiven3Plus1Equal4IsDisplay_WhenPlusIsChoosed_Then4PlusIsDisplay() throws {
        newCalcul.addNumber("3")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "3 + 1 = 4")
        try newCalcul.addAdditionOperator()
        XCTAssertEqual(newCalcul.textToDisplay, "4 + ")
    }
    
    
    //MARK: - Test

    
    func testGiven1Plus2Equal3IsDisplay_When5IsChoosed_Then5IsDisplay() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("2")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 2 = 3")
        newCalcul.addNumber("5")
        XCTAssertEqual(newCalcul.textToDisplay, "5")
    }
    
    
    
    //MARK: - Error testing
    // ✅ cannotAddOperator, ✅ cannotAddAPoint, ✅ expressionNotCorrect, ✅ expressionNotEnoughtLong, ✅ divideByZero, nothingToRemove, ✅ startByAnOperator, unknownOperator
    
    // Divide By Zero
    func testGiven1DivideBy0IsDisplay_When0IsChoosed_ThenErrorDivideByZeroIsSend() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        newCalcul.addNumber("0")
        XCTAssertThrowsError(try newCalcul.calculate(), "The calculation must end with a non-zero number.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.divideByZero)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1 ÷ 0")
    }
    
    // Cannot Add Operator +
    func testGiven1PlusIsDisplay_WhenPlusIsChoosed_ThenTheErrorCannotAddAnOperatorIsSend() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        XCTAssertThrowsError(try newCalcul.addAdditionOperator(), "Two operators cannot follow each other.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.cannotAddOperator)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1 + ")
    }
    
    // Cannot Add Operator -
    func testGiven1PlusIsDisplay_WhenMinusIsChoosed_ThenTheErrorCannotAddAnOperatorIsSend() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addSubstractionOperator())
        XCTAssertThrowsError(try newCalcul.addSubstractionOperator(), "Two operators cannot follow each other.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.cannotAddOperator)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1 - ")
    }
    
    // Cannot Add Operator x
    func testGiven1PlusIsDisplay_WhenMultiplyIsChoosed_ThenTheErrorCantAddAnOperatorIsSend() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addMultiplicationOperator())
        XCTAssertThrowsError(try newCalcul.addMultiplicationOperator(), "Two operators cannot follow each other.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.cannotAddOperator)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1 x ")
    }
    
    // Cannot Add Operator ÷
    func testGiven1PlusIsDisplay_WhenDivisionIsChoosed_ThenTheErrorCannotAddAnOperatorIsSend() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        XCTAssertThrowsError(try newCalcul.addDivisionOperator(), "Two operators cannot follow each other.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.cannotAddOperator)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1 ÷ ")
    }
    
    // Expression Not Correct
    func testGiven1Plus1Equal2IsDisplay_WhenEqualIsChoosed_ThenErrorExpressionNotCorrectIsSend() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 1 = 2")
        XCTAssertThrowsError(try newCalcul.calculate(), "The calcul is already done.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.expressionNotCorrect)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 1 = 2")
    }
    
    // Expression Not Correct
    func testGiven1PlusIsDisplay_WhenEqualIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        XCTAssertThrowsError(try newCalcul.calculate(), "Data is missing to perform the calculation.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.expressionNotCorrect)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1 + ")
    }
    
    // Expression Not Enought Long
    func testGiven1IsDisplay_WhenTheEqualIsChoosed_ThenErrorExpressionNotLongEnoughtIsSend() throws {
        newCalcul.addNumber("1")
        XCTAssertThrowsError(try newCalcul.calculate(), "Data is missing to perform the calculation.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.expressionNotEnoughtLong)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1")
    }
    
    // Cannot Add A Point
    func testGiven1Point5IsDisplay_WhenThePointIsChoosed_ThenErrorCannotAddAPointIsSend() throws {
        newCalcul.addNumber("1.5")
        XCTAssertThrowsError(try newCalcul.addAPoint(), "We cannot have 2 commas in the same number.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.cannotAddAPoint)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1.5")
    }
    
    // Cannot Add A Point
    func testGivenNothingDisplay_WhenThePointIsChoosed_ThenErrorCannotAddAPointIsSend() throws {
        newCalcul.addNumber("")
        XCTAssertThrowsError(try newCalcul.addAPoint(), "You cannot start a calculation with a comma.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.cannotAddAPoint)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "")
    }
    
    // Cannot Add A Point
    func testGiven1Plus1Equal2Display_WhenThePointIsChoosed_ThenErrorCannotAddAPointIsSend() throws {
        newCalcul.addNumber("1")
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        try newCalcul.calculate()
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 1 = 2")
        XCTAssertThrowsError(try newCalcul.addAPoint(), "You cannot start a calculation with a comma.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.cannotAddAPoint)
        })
        XCTAssertEqual(newCalcul.textToDisplay, "1 + 1 = 2")
    }
    
    // Start By An Operator +
    func testGivenPlus1IsDisplay_WhenTheEqualIsChoosed_ThenErrorStartByAnOperatorIsSend() throws {
        XCTAssertNoThrow(try newCalcul.addAdditionOperator())
        newCalcul.addNumber("1")
        XCTAssertThrowsError(try newCalcul.calculate(), "You cannot start a calculation with an operator.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.startByAnOperator)
        })
        XCTAssertEqual(newCalcul.textToDisplay, " + 1")
    }
    
    // Start By An Operator -
    func testGivenMinus1IsDisplay_WhenTheEqualIsChoosed_ThenErrorStartByAnOperatorIsSend() throws {
        XCTAssertNoThrow(try newCalcul.addSubstractionOperator())
        newCalcul.addNumber("1")
        XCTAssertThrowsError(try newCalcul.calculate(), "You cannot start a calculation with an operator.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.startByAnOperator)
        })
        XCTAssertEqual(newCalcul.textToDisplay, " - 1")
    }
    
    // Start By An Operator x
    func testGivenMultiplies1IsDisplay_WhenTheEqualIsChoosed_ThenErrorStartByAnOperatorIsSend() throws {
        XCTAssertNoThrow(try newCalcul.addMultiplicationOperator())
        newCalcul.addNumber("1")
        XCTAssertThrowsError(try newCalcul.calculate(), "You cannot start a calculation with an operator.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.startByAnOperator)
        })
        XCTAssertEqual(newCalcul.textToDisplay, " x 1")
    }
    
    // Start By An Operator x
    func testGivenDivide1IsDisplay_WhenTheEqualIsChoosed_ThenErrorStartByAnOperatorIsSend() throws {
        XCTAssertNoThrow(try newCalcul.addDivisionOperator())
        newCalcul.addNumber("1")
        XCTAssertThrowsError(try newCalcul.calculate(), "You cannot start a calculation with an operator.", { error in
            XCTAssertEqual(error as? CalculError, CalculError.startByAnOperator)
        })
        XCTAssertEqual(newCalcul.textToDisplay, " ÷ 1")
    }
    
}
