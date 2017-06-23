//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Wayne Rumble on 05/06/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorBrainTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstants() {
        let symbolsAndValues = ["π": Double.pi, "e": M_E]
        for (symbol, value) in symbolsAndValues {
            let result = returnConstantValue(symbol: symbol)
            
            XCTAssertEqual(result, value.roundTo(places: 6))
        }
    }
    
    func testUnaryFunctions() {
        let unaryConstant: Double = 5
        let unaryFunctionsAndAnswers = ["log": 1.609438, "sin": -0.958924, "cos": 0.283662, "tan": -3.380515, "√": 2.236068, "±": -5]
        for (symbol,answer) in unaryFunctionsAndAnswers {
            let result = returnUnaryOperationResult(unaryOperator: unaryConstant, symbol: symbol)
            
            
            XCTAssertEqual(result, answer)
        }
    }
    
    func testBinaryFunctions() {
        let firstOperator: Double = 7
        let secondOperator: Double = 2
        let binaryFunctionsAndAnswers = ["+": 9, "-": 5, "x": 14, "÷": 3.5]
        
//        let result = binaryFunctionsAndAnswers.reduce(0.0) { accumulator, operation in
//            return returnBinaryOperationResult(firstOperator: accumulator, symbol: operation.key, secondOperator: operation.value)
//        }
        
        for (symbol,answer) in binaryFunctionsAndAnswers {
            let result = returnBinaryOperationResult(firstOperator: firstOperator, symbol: symbol, secondOperator: secondOperator)
            
            XCTAssertEqual(result, answer)
        }
    }
    
    func testConstantsDescription() {
        let constants = ["e", "π"]
        constants.forEach { constant in
            
            let result = returnConstantDescription(symbol: constant)
            XCTAssertEqual(result, constant)
        }
    }
    
    func testUnaryDescription() {
        let unarySymbols = ["log", "sin", "cos", "tan", "√", "±"]
        
        unarySymbols.forEach { symbol in
            let description = "\(symbol)(5)"
            let result = returnUnaryDescription(unaryOperator: 5, symbol: symbol)
        
            XCTAssertEqual(result, description)
        }
    }
    
    // Example found in task 7.a --- touching 7 + would show “7 + ...” (with 7 still in the display)
    // FIXME Display is set at this level in the view controller as shown to do so in the lectures. Will refactor it after the second project task if he does not require it in setup.
    func testExampleSevenA() {
        var brain = CalculatorBrain()
        brain.setOperand(7)
        brain.performOperation("+")
        let description = brain.description!
        
        XCTAssertEqual(description, "7+...")
    }
    
    // Example found in task 7.b --- 7 + 9 would show “7 + ...” (9 in the display)
    func testExampleSevenB() {
        var brain = CalculatorBrain()
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+...")
        XCTAssertEqual(result, 9)
    }
    
    //Example found in task 7.c --- c. 7 + 9 = would show “7 + 9 =” (16 in the display)
    func testExampleSevenC() {
        var brain = CalculatorBrain()
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+9=")
        XCTAssertEqual(result, 16)
    }
    
    //Example found in task 7.d --- 7 + 9 = √ would show “√(7 + 9) =” (4 in the display)
    func testExampleSevenD() {
        var brain = CalculatorBrain()
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        brain.performOperation("√")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "√(7+9)=")
        XCTAssertEqual(result, 4)
    }
    
    //Example found in task 7.e --- 7 + 9 = √ + 2 = would show “√(7 + 9) + 2 =” (6 in the display)
    func testExampleSevenE() {
        var brain = CalculatorBrain()
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        brain.performOperation("√")
        brain.performOperation("+")
        brain.setOperand(2)
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "√(7+9)+2=")
        XCTAssertEqual(result, 6)
    }
    
    //Example found in task 7.f --- 7 + 9 √ would show “7 + √(9) ...” (3 in the display)
    func testExampleSevenF() {
        var brain = CalculatorBrain()
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("√")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+√(9)...")
        XCTAssertEqual(result, 3)
    }
    
    //Example found in task 7.g --- 7 + 9 √ = would show “7 + √(9) =“ (10 in the display)
    func testExampleSevenG() {
        var brain = CalculatorBrain()
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("√")
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+√(9)=")
        XCTAssertEqual(result, 10)
    }
    
    //Example found in task 7.h --- 7 + 9 = + 6 = + 3 = would show “7 + 9 + 6 + 3 =” (25 in the display)
    func testExampleSevenH() {
        var brain = CalculatorBrain()
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        brain.performOperation("+")
        brain.setOperand(6)
        brain.performOperation("=")
        brain.performOperation("+")
        brain.setOperand(3)
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+9+6+3=")
        XCTAssertEqual(result, 25)
    }
    
    //Example found in task 7.i --- 7 + 9 = √ 6 + 3 = would show “6 + 3 =” (9 in the display)
    func testExampleSevenI() {
        var brain = CalculatorBrain()
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        brain.performOperation("√")
        brain.setOperand(6)
        brain.performOperation("+")
        brain.setOperand(3)
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "6+3=")
        XCTAssertEqual(result, 9)
    }
    
    //Example found in task 7.j --- 5 + 6 = 7 3 would show “5 + 6 =” (73 in the display)
    func testExampleSevenJ() {
        var brain = CalculatorBrain()
        brain.setOperand(5)
        brain.performOperation("+")
        brain.setOperand(6)
        brain.performOperation("=")
        //Brain description is reset after this point but the label in the display is not ??
        let description = brain.description!
        brain.setOperand(73)
        let result = brain.result!
        
        XCTAssertEqual(description, "5+6=")
        XCTAssertEqual(result, 73)
    }
    
    //Example found in task 7.k --- 4 × π = would show “4 x π =“ (12.566371 in the display)
    func testExampleSevenK() {
        var brain = CalculatorBrain()
        brain.setOperand(4)
        brain.performOperation("x")
        brain.performOperation("π")
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "4xπ=")
        XCTAssertEqual(result, 12.566371)
    }
        
    //Helper Methods
    func returnConstantDescription(symbol: String) -> String {
        var brain = CalculatorBrain()
        brain.performOperation(symbol)
        
        return brain.description!
    }
    
    func returnUnaryDescription(unaryOperator: Double, symbol: String) -> String {
        var brain = CalculatorBrain()
        brain.setOperand(unaryOperator)
        brain.performOperation(symbol)
        
        return brain.description!
    }
    
    func returnConstantValue(symbol: String) -> Double {
        var brain = CalculatorBrain()
        brain.performOperation(symbol)
        
        return brain.result!
    }
    
    func returnUnaryOperationResult(unaryOperator: Double, symbol: String) -> Double {
        var brain = CalculatorBrain()
        brain.setOperand(unaryOperator)
        brain.performOperation(symbol)
        
        return brain.result!
    }
    
    func returnBinaryOperationResult(firstOperator: Double, symbol: String, secondOperator: Double) -> Double {
        var brain = CalculatorBrain()
        brain.setOperand(firstOperator)
        brain.performOperation(symbol)
        brain.setOperand(secondOperator)
        brain.performOperation("=")
        
        return brain.result!
    }
}
