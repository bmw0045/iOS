//
//  SliderViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import Foundation
import UIKit

protocol SliderViewControllerDelegate: class {
    func editItem(_ item: String)
}

//let ViewController: ViewController?

class SliderViewController: UIViewController {
    @IBOutlet weak var sliderNumLabel: UILabel!
    var editLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sliderNumLabel?.text = self.editLabel
    }
    @IBAction func editSlider(_ sender: UISlider) {
        
    }
    
    @IBAction func saveSlider(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func setLabel(labelValue: String) {
        
    }
    
    
}
