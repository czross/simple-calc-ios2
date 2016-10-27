//
//  ViewController.swift
//  simple-calc
//
//  Created by Chris Ross on 10/24/16.
//  Copyright © 2016 Chris Ross. All rights reserved.
//

import UIKit

let calculator = Calc()

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // All the number buttons
    @IBAction func numBtnInput(_ sender: UIButton) {
        calculator.nextDigit(input: Int.init(sender.titleLabel!.text!)!)
        resultLabel.text = calculator.retCurrentNum()
        
    }
    
    // All operations buttons including avg, fact, count
    @IBAction func operationBtnInput(_ sender: UIButton) {
        if (calculator.rpnOn) {
            calculator.currentOperator = (sender.titleLabel?.text!)!
            resultLabel.text = calculator.retCurrentNum()
            calculator.rpnStoreNums(next: calculator.currentNum)
            
        } else {
            calculator.setOper(operation: sender.titleLabel!.text!)
            resultLabel.text = calculator.retCurrentNum()
        }
        
    }
    
    // clear button
    @IBAction func clearBtnInput(_ sender: UIButton) {
        calculator.clearAll()
        resultLabel.text = calculator.retCurrentNum()
    }
    
    // Enter button
    @IBAction func enterBtnInput(_ sender: AnyObject) {
        if (calculator.rpnOn) {
            calculator.rpnCalculate()
        } else {
            calculator.setOper(operation: sender.titleLabel!?.text!)
        }
        resultLabel.text = ("\(calculator.results)")
    }
    
    // Adding decimals
    @IBAction func decimalBtnInput(_ sender: AnyObject) {
        calculator.setDecimal()
    }

    // Swithing to RPN setting
    @IBAction func rpnSwitchInput(_ sender: UISwitch) {
        if (sender.isOn) {
            calculator.rpnSetOn()
        } else {
            calculator.rpnSetOff()
        }
    }
    
    @IBAction func rpnNextBtnInput(_ sender: AnyObject) {
        calculator.rpnStoreNums(next: calculator.currentNum)
        calculator.currentNum = 0.0
        resultLabel.text = (calculator.retCurrentNum())
    }


}

