//
//  StepperViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import UIKit

protocol StepperViewControllerDelegate {
    func stepperUpdate(with newStep: String)
}

class StepperViewController: UIViewController {
    var stepDelegate: StepperViewControllerDelegate?
    var editLabel: String?
    
    @IBOutlet weak var stepper: UIStepper!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepLabel?.text = self.editLabel
    }
    
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBAction func stepperChanged(_ sender: Any) {
        let currentValue = Int(stepper.value)
        stepLabel.text = "\(currentValue)"
    }
    
    @IBAction func saveStep(_ sender: Any) {
        self.stepDelegate?.stepperUpdate(with: self.stepLabel.text ?? "default")
        self.navigationController?.popViewController(animated: true)
    }
    
}
