import Foundation

// List of errors
enum CalculError: Error {
    case cannotAddOperator, cannotAddAPoint, unknownOperator, expressionNotCorrect, expressionNotEnoughtLong, divideByZero, nothingToRemove, startByAnOperator
}

class Calcul {
    
    private(set) var textToDisplay: String = ""
    
    var elements: [String] {
        return textToDisplay.split(separator: " ").map { "\($0)" }
    }
    
    // The last character must not be an operator
    var expressionIsCorrectLast: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    // The first character must not be an operator
    var expressionIsCorrectFirst: Bool {
        return elements.first != "+" && elements.first != "-" && elements.first != "x" && elements.first != "÷"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var expressionHaveResult: Bool {
        return textToDisplay.firstIndex(of: "=") != nil
    }
    
    
    private var expressionHaveAMultiply: Bool {
        return textToDisplay.firstIndex(of: "x") != nil
    }
    
    private var expressionHaveADivide: Bool {
        return textToDisplay.firstIndex(of: "÷") != nil
    }
    
    func addNumber(_ numberText: String) {
        if expressionHaveResult {
            textToDisplay = ""
        }
        textToDisplay.append(numberText)
    }
    
    //MARK: - Adding operators
    
    // This method adds a plus sign to the current calculation.
    func addAdditionOperator() throws {
        try addAnOperator(operatorAsString: "+")
    }
    
    // This method adds a minus sign to the current calculation.
    func addSubstractionOperator() throws {
        try addAnOperator(operatorAsString: "-")
    }
    
    // This method adds a multiply sign to the current calculation.
    func addMultiplicationOperator() throws {
        try addAnOperator(operatorAsString: "x")
    }
    
    // This method adds a divide sign to the current calculation.
    func addDivisionOperator() throws {
        try addAnOperator(operatorAsString: "÷")
    }
    
    
    
    //MARK: - Decimal
    
    var numbers: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    // To add the comma.
    func addAPoint() throws {
        guard cannotAddAPoint() == true else {
            throw CalculError.cannotAddAPoint
        }
        textToDisplay.append(".")
    }
    
    // Check if it's already a comma.
    func alreadyDecimalNumber() -> Bool {
        guard let lastElement = elements.last else {
            return false
        }
        if lastElement.contains(".") {
            return true
        }
        return false
    }
    
    
    // Check if a point can be added.
    private func cannotAddAPoint() -> Bool {
        var isANumber = false
        guard !expressionHaveResult else {
            return false
        }
        guard !hasAlreadyAPoint() else {
            return false
        }
        
        // Check if the last element is a number.
        let last = textToDisplay.suffix(1)
        for i in numbers {
            if last == i {
                isANumber = true
            }
        }
        return isANumber
    }
    
    
    // Check if the last character is already a point.
    func hasAlreadyAPoint() -> Bool {
        guard let lastElement = elements.last else {
            return false
        }
        if lastElement.contains(".") {
            return true
        }
        return false
    }
    
    
    //MARK: - Functions delete
    //To delete characters when A/C button is pressed (short or long)
    
    func deleteAll() {
        textToDisplay.removeAll()
    }
    
    func deleteTheLast() {
        var text = Array(textToDisplay)
        text.remove(at: textToDisplay.count - 1)
        textToDisplay = String(text)
    }
    
    //MARK: - Test Phase
    // To realize the calculation.
    func calculate() throws {
        
        // Checks if the calculation is not already done.
        guard expressionHaveResult == false else {
            throw CalculError.expressionNotCorrect
        }
        
        // Checks if the last character is a number and not an operator.
        guard expressionIsCorrectLast else {
            throw CalculError.expressionNotCorrect
        }
        
        // Checks if the firts character is a number and not an operator.
        guard expressionIsCorrectFirst else {
            throw CalculError.startByAnOperator
        }
        
        // Checks if the calculation has all the necessary elements.
        guard expressionHaveEnoughElement else {
            throw CalculError.expressionNotEnoughtLong
        }
        
        // Creates local copy of operations.
        var operationsToReduce = elements
        
        // Iterates over operations while an operand still here.
        while operationsToReduce.count > 1 {
            
            // Priorization of calculations.
            var i = 1
            
            if expressionHaveAMultiply {
                i = (operationsToReduce.firstIndex(of: "x") ?? 1)
            }
            if expressionHaveADivide {
                i = (operationsToReduce.firstIndex(of: "÷") ?? 1)
            }
            
            // Defines the range to remove after the elementary calculation.
            let rangeToRemove = i-1...i+1
            
            // Defines both side of elementary calculation.
            let left = Double(operationsToReduce[i-1])!
            let operand = operationsToReduce[i]
            let right = Double(operationsToReduce[i+1])!
            
            var result: Double
            
            // Realizes the calculation according to the operator.
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = left / right
                // Division by 0 is forbidden.
                guard right != 0 else {
                    throw CalculError.divideByZero
                }
            default: throw CalculError.unknownOperator
            }
            // Removes the calculation just done and put the result.
            operationsToReduce.removeSubrange(rangeToRemove)
            operationsToReduce.insert("\(result)", at: i-1)
        }
        textToDisplay.append(" = \(operationsToReduce.first!)")
        if textToDisplay.hasSuffix(".0") {
            textToDisplay.removeLast(2)
        }
    }
    
    
    // This method deletes the previous calculation and keeps the result.
    func deleteThePreviousCalculation() {
        while !textToDisplay.hasPrefix("=") {
            textToDisplay.removeFirst()
        }
        textToDisplay.removeFirst(2)
    }
    
    // This method adds an operator to the current calculation. If there is already a calculation, it keeps the result.
    private func addAnOperator(operatorAsString: String) throws {
        
        // Keeps the result of last calculation.
        if expressionHaveResult {
            deleteThePreviousCalculation()
        }
        if canAddOperator {
            textToDisplay.append(" " + operatorAsString + " ")
        } else {
            throw CalculError.cannotAddOperator
        }
    }
    
    
    
}
