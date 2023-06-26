//
//  ViewController.swift
//  Calculator
//
//  Created by Phạm Huy Hoàng on 26/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: outlet

    var input: String = ""
    var numOld: Double = 0
    var numNew: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // algorithm
    
    func sum() -> Double {
        return numOld + numNew
    }
    
    func difference() -> Double {
        return numOld - numNew
    }

    func product() -> Double {
        return numOld * numNew
    }
    
    func quotient() -> Double {
        return numOld / numNew
    }
    // MARK: action

    @IBAction func selectedEqual(_ sender: Any) {
    }
    @IBAction func selectedMinus(_ sender: Any) {
    }
    @IBAction func selectedAdd(_ sender: Any) {
    }
    @IBAction func selectedMultiply(_ sender: Any) {
    }
    @IBAction func selectedDivine(_ sender: Any) {
    }
    @IBAction func selectedNegative(_ sender: Any) {
    }
    @IBAction func selectedPercent(_ sender: Any) {
    }
    @IBAction func selectedC(_ sender: Any) {
    }
    @IBAction func selectedAC(_ sender: Any) {
        
    }
    @IBAction func selectedNumber(_ sender: UIButton) {
        if sender.tag == 10 {
            input = ","
        } else {
            input = String(sender.tag)
        }
            
    }
}

