//
//  ViewController.swift
//  Calculator
//
//  Created by Wayne Rumble on 05/06/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainDisplay: UILabel!
    @IBOutlet weak var currentInputDisplay: UILabel!
    @IBOutlet weak var decimalPointButton: UIButton!
    
    private var brain = CalculatorBrain()
    
    var userIsInTheMiddleOfTypingNumber = false
    var displayValue: Double {
        get {
            return Double(mainDisplay.text!) ?? 0
        }
        set {
            mainDisplay.text = String(newValue.cleanValue)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingNumber {
            let textCurrentlyInDisplay = mainDisplay.text!
            mainDisplay.text = textCurrentlyInDisplay + digit
        } else {
            mainDisplay.text = digit
            if digit == "." {
                mainDisplay.text = "0."
            }
            userIsInTheMiddleOfTypingNumber = true
        }
        updateCurrentInputDisplay()
    }
    
    @IBAction func backSpaceButtonWasPressed(_ sender: UIButton) {
        if mainDisplay.text != "" || (mainDisplay.text?.characters.count)! > 0 {
            var newDisplayText = String(mainDisplay.text!.characters.dropLast(1))
            if newDisplayText.characters.count == 0 {
                newDisplayText = ""
                userIsInTheMiddleOfTypingNumber = false
            }
            mainDisplay.text = newDisplayText
        }
    }
    
    @IBAction func decimalPointButtonWasPressed(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func equalsButtonWasPressed(_ sender: UIButton) {
        decimalPointButton.isEnabled = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTypingNumber = false
        }
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(mathmaticalSymbol)
            decimalPointButton.isEnabled = true
        }
        if let result = brain.result {
            displayValue = result
        }
        updateCurrentInputDisplay()
    }
    
    @IBAction func clearButtonWasPressed(_ sender: UIButton) {
        brain = CalculatorBrain()
        mainDisplay.text = "0"
        currentInputDisplay.text = "Input"
    }
    
    private func updateCurrentInputDisplay() {
        guard let brainDescription = brain.description
            else {
                currentInputDisplay.text = "Input"
                return
        }
        
        currentInputDisplay.text = brainDescription
    }
}




