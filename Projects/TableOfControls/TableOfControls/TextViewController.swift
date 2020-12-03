//
//  File.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import UIKit

protocol TextViewControllerDelegate {
    func updateText(with newText: String)
}
class TextViewController: UIViewController {
    var textDelegate: TextViewControllerDelegate?
    var editLabel: String?
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLabel?.text = self.editLabel
    }
    @IBAction func saveText(_ sender: Any) {
        self.textDelegate?.updateText(with: self.textField.text ?? "default")
        self.navigationController?.popViewController(animated: true)
    }
}
