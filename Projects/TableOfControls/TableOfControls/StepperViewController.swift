//
//  StepperViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import UIKit

class StepperViewController: UIViewController {
    
    @IBAction func saveSlider(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
