//
//  SwitchViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import UIKit

protocol SwitchViewControllerDelegate {
    func switchUpdate(with newSwitch: String)
}
class SwitchViewController: UIViewController {
    
    var editLabel: String?
    var switchDelegate: SwitchViewControllerDelegate?
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchLabel?.text = self.editLabel
    }
    
    @IBAction func switcher(_ sender: Any) {
        if switchButton.isOn == true {
            switchLabel.text = "On"
        }
        else {
            switchLabel.text = "Off"
        }
    }
    
    
    @IBAction func saveSwitch(_ sender: UIButton) {
        self.switchDelegate?.switchUpdate(with: self.switchLabel.text ?? "default")
        self.navigationController?.popViewController(animated: true)
    }
}
