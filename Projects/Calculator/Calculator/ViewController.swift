//  Brett Walton
//  ViewController.swift
//  Calculator
//
//  Created by Field Employee on 11/29/20.
//

import UIKit

class ViewController: UIViewController {
    
    var numOnScreen: Double = 0
    var previousNum: Double = 0
    var operation = 0
    var doingMath = false
    
    @IBOutlet var Calculator: UIView!
    @IBOutlet weak var label: UILabel!
    @IBAction func numbers(_ sender: UIButton) {
        if doingMath == true {
            label.text = String(sender.tag-1)
            numOnScreen = Double(label.text!)!
            doingMath = false
        }
        else if label.text == "0" {
            label.text = String(sender.tag-1)
            numOnScreen = Double(label.text!)!
        }
        else if sender.tag == 0 {
            label.text = label.text! + "."
        }
        else {
            label.text = label.text! + String(sender.tag-1)
            numOnScreen = Double(label.text!)!
            }

    }
    
    @IBAction func buttons(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16 {
            previousNum = Double(label.text!)!
            if sender.tag == 12 {
                doingMath = true
                previousNum = Double(label.text!)!
                label.text = "÷"
                operation = sender.tag
            }
            if sender.tag == 13 {
                doingMath = true
                previousNum = Double(label.text!)!
                label.text = "x"
                operation = sender.tag
            }
            if sender.tag == 14 {
                doingMath = true
                previousNum = Double(label.text!)!
                label.text = "-"
                operation = sender.tag
            }
            if sender.tag == 15 {
                doingMath = true
                previousNum = Double(label.text!)!
                label.text = "+"
                operation = sender.tag
            }
            if sender.tag == 17 {
                numOnScreen = -numOnScreen
                label.text = String(numOnScreen)
            }
            if sender.tag == 18 {
                numOnScreen = numOnScreen/100
                label.text = String(numOnScreen)
            }
        }
        else if sender.tag == 16 {
            if operation == 12 {
                label.text = String(previousNum / numOnScreen)
            }
            else if operation == 13{ //Multiply
                label.text = String(previousNum * numOnScreen)
            }
            else if operation == 14{ //Subtract
                label.text = String(previousNum - numOnScreen)
            }
            else if operation == 15{ //Add
                label.text = String(previousNum + numOnScreen)
            }
        }
        else if sender.tag == 11{
            label.text = "0"
            previousNum = 0
            numOnScreen = 0
            operation = 0
            }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

