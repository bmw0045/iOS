//
//  SwitchViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import UIKit

class SwitchViewController: UIViewController {
    
    @IBAction func saveSwitch(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
