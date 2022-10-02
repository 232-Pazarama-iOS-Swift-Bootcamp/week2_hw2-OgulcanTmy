//
//  ViewController.swift
//  CalculatorOdev2
//
//  Created by Oğulcan Tamyürek on 2.10.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var equationLabel: UILabel!
    
    var numberOnScreen: String?
    var numberOnSecondScreen: String?
    var previousSign: String = "+"
    var calculate: Bool? = true
    var previousButton: String = ""
    
    var result: Double = 0
    
    @IBAction func numberDidTapped(_ sender: UIButton) {
        if previousButton == "+" ||
            previousButton == "-" ||
            previousButton == "x" ||
            previousButton == "÷" ||
            previousButton == "%" {
            
            calculate = false
        }
        
        if calculate! {
            self.clearScreen()
        }
        
        calculate = false
        
        numberOnScreen = resultLabel.text
        if sender.titleLabel?.text == "." {
            if resultLabel.text!.contains(".") {
                return
            }
            if numberOnScreen == "0" {
                resultLabel.text = numberOnScreen! + (sender.titleLabel?.text)!
                return
            }
        }
        if numberOnScreen == "0" {
            numberOnScreen = ""
        }
        resultLabel.text = numberOnScreen! + (sender.titleLabel?.text)!
        
        previousButton = (sender.titleLabel?.text)!
    }
    
    @IBAction func operatorDidTapped(_ sender: UIButton) {
        if (previousButton == "+" ||
            previousButton == "-" ||
            previousButton == "x" ||
            previousButton == "÷" ||
            previousButton == "%") &&
            sender.titleLabel?.text != "=" {
            if let pressedOperation = sender.titleLabel?.text {
                equationLabel.text = "\(formatNumber(result)) \(pressedOperation) "
                previousButton = (sender.titleLabel?.text)!
                previousSign = previousButton
            }
            return
        }
        
        if sender.titleLabel?.text! == "=" {
            if equationLabel.text! == "" || previousButton == "="{
                return
            }
        }
        
        numberOnSecondScreen = equationLabel.text!
        
        if sender.titleLabel?.text != "=" {
            if numberOnSecondScreen == "" {
                numberOnSecondScreen = resultLabel.text!
                equationLabel.text = numberOnSecondScreen! + (sender.titleLabel?.text)!
            } else {
                numberOnSecondScreen = equationLabel.text!
                equationLabel.text = numberOnSecondScreen! + resultLabel.text! + (sender.titleLabel?.text)!
            }
        } else {
            if numberOnSecondScreen == "" {
                numberOnSecondScreen = resultLabel.text!
                equationLabel.text = numberOnSecondScreen!
            } else {
                numberOnSecondScreen = equationLabel.text!
                equationLabel.text = numberOnSecondScreen! + resultLabel.text!
            }
        }
        
        switch previousSign {
        case "+":
            result += Double(resultLabel.text!)!
        case "-":
            result -= Double(resultLabel.text!)!
        case "x":
            result *= Double(resultLabel.text!)!
        case "÷":
            result /= Double(resultLabel.text!)!
        case "%":
            result = result.truncatingRemainder(dividingBy: Double(resultLabel.text!)!)
        default:
            print("err")
        }
        
        if sender.titleLabel?.text! == "=" {
            equationLabel.text = "\(equationLabel.text!) "
            
            if formatNumber(result) == "inf" || formatNumber(result) == "nan" {
                resultLabel.text = "Error"
            } else {
                resultLabel.text = formatNumber(result)
            }
            self.resetCalculator()
        } else {
            equationLabel.text = "\(formatNumber(result)) \((sender.titleLabel?.text)!) "
            previousSign = (sender.titleLabel?.text)!
            
            resultLabel.text = "0"
        }

        previousButton = (sender.titleLabel?.text)!
    }
    
    @IBAction func otherButtonTap(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "C" {
            self.clearScreen()
        } else if sender.titleLabel?.text == "+/-" {
            var tempNum = Double(resultLabel.text!)!
            tempNum = -tempNum
            resultLabel.text = self.formatNumber(tempNum)
        } else {
            if sender.titleLabel?.text == "x!" {
                if let number = Int(resultLabel.text!) {
                    resultLabel.text = String(factorial(n: number))
                }
            }
            if sender.titleLabel?.text == "√ x" {
                resultLabel.text = String(sqrt(Double(resultLabel.text!)!))
            }
            if sender.titleLabel?.text == "x²" {
                resultLabel.text = String(pow(Double(resultLabel.text!)!, 2))
            }
        }
        
        previousButton = (sender.titleLabel?.text)!
    }
    
    func clearScreen() {
        equationLabel.text = ""
        resultLabel.text = "0"
        result = 0
        previousSign = "+"
        calculate = true
    }
    
    func resetCalculator() {
        previousSign = "+"
        calculate = true
        result = 0
    }
    
    func factorial(n: Int) -> Int {
        var result = 1
        if(n > 0) {
            for i in 1...n {
                result *= i
            }
        }
        return result
    }
    
    func formatNumber(_ number: Double) -> String{
        return String(format: "%g", number)
    }
}

