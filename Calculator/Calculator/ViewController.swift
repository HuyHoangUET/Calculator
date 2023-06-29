//
//  ViewController.swift
//  Calculator
//
//  Created by Phạm Huy Hoàng on 26/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: outlet

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var numNewLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var numOldLabel: UILabel!
    
    var input: String = "" {
        didSet {
            if input == "" {
                return
            }
            isOperator = ["+", "-", "x", "/"].contains(input)
            if isOperator { // nhập toán tử
                if inputField?.text != "" {
                    if result != nil {  // lấy kết quả phép tính trước
                        numOld = result
                        numNew = nil
                        result = nil
                        currentOperator = input
                    } else {    // phép tính mơi
                        if numOld != nil {
                            numNew = Double(inputField?.text ?? "")
                            result = calculate()
                            numOld = result
                            result = nil
                        } else {
                            numOld = Double(inputField?.text ?? "")
                        }
                        numNew = nil
                        currentOperator = input
                    }
                } else {
                    if numOld != nil {
                        currentOperator = input
                    }
                }
                inputField.text = ""
            } else {    // nhập số, kí tự
                if input == "_" {
                    inputField?.text?.append("-")
                } else {
                    inputField?.text?.append(input)
                }
            }
        }
    }
    var isOperator: Bool = false
    var numOld: Double? {
        didSet {
            if numOld != nil {
                if (numOld ?? 0) - Double(Int(oldValue ?? 0)) > 0 {
                    numOldLabel?.text = String(numOld ?? 0)
                } else {
                    numOldLabel?.text = String(Int(numOld ?? 0))
                }
            } else {
                numOldLabel?.text = ""
            }
        }
    }
    var numNew: Double? {
        didSet {
            if numNew != nil {
                if (numNew ?? 0) - Double(Int(oldValue ?? 0)) > 0 {
                    numNewLabel?.text = String(numNew ?? 0)
                } else {
                    numNewLabel?.text = String(Int(numNew ?? 0))
                }
            } else {
                numNewLabel?.text = ""
            }
        }
    }
    var result: Double? {
        didSet {
            if result != nil {
                if (result ?? 0) - Double(Int(oldValue ?? 0)) > 0 {
                    inputField?.text = String(result ?? 0)
                } else {
                    inputField?.text = String(Int(result ?? 0))
                }
            } else {
                inputField?.text = ""
            }
        }
    }
    var currentOperator: String? {
        didSet {
            operatorLabel?.text = currentOperator
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    // algorithm
    
    func sum() -> Double {
        return (numOld ?? 0) + (numNew ?? 0)
    }
    
    func difference() -> Double {
        return (numOld ?? 0) - (numNew ?? 0)
    }

    func product() -> Double {
        return (numOld ?? 0) * (numNew ?? 0)
    }
    
    func quotient() -> Double {
        return (numOld ?? 0) / (numNew ?? 0)
    }
    
    func calculate() -> Double? {
        switch self.currentOperator {
        case "+":
            return sum()
        case "-":
            return difference()
        case "x":
            return product()
        case "/":
            return quotient()
        default:
            if inputField.text != "" {
                return Double(inputField.text ?? "")
            } else {
                return nil
            }
        }
    }
    
    func clear() {
        result = nil
        numOld = nil
        numNew = nil
        currentOperator = nil
        input = ""
    }
    // MARK: action

    @IBAction func selectedEqual(_ sender: Any) {
        if numOld != nil && numNew == nil && inputField.text != "" {
            numNew = Double(inputField.text ?? "")
        }
        result = self.calculate()
    }
    @IBAction func selectedMinus(_ sender: Any) {
        input = "-"
    }
    @IBAction func selectedAdd(_ sender: Any) {
        input = "+"
    }
    @IBAction func selectedMultiply(_ sender: Any) {
        input = "x"
    }
    @IBAction func selectedDivine(_ sender: Any) {
        input = "/"
    }
    @IBAction func selectedNegative(_ sender: Any) {
        input = "_"
    }
    @IBAction func selectedPercent(_ sender: Any) {
        if inputField.text != "" {
            result = (Double(inputField?.text ?? "") ?? 0)/100
        }
    }
    @IBAction func selectedC(_ sender: Any) {
        if inputField.text == "" {
            clear()
        } else {
            inputField.text?.removeLast()
        }
    }
    @IBAction func selectedAC(_ sender: Any) {
        clear()
    }
    @IBAction func selectedNumber(_ sender: UIButton) {
        if sender.tag == 10 {
            if !(inputField.text?.contains(".") ?? false) {
                input = "."
            }
        } else {
            input = String(sender.tag)
        }
            
    }
}

