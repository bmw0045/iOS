//
//  SliderViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import Foundation
import UIKit

protocol SliderViewControllerDelegate {
    func update(with newText: String)
    
}

//let ViewController: ViewController?

class SliderViewController: UIViewController {
    @IBOutlet weak var sliderNumLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    var editLabel: String?
    var initialSlider: Float?
    var delegate: SliderViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sliderNumLabel?.text = self.editLabel
        self.slider.value = self.initialSlider ?? 0
    }
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider!) {
        let currentValue = Int(sender.value)
        sliderNumLabel.text = "\(currentValue)"
        
    }
    
    @IBAction func saveSlider(_ sender: Any) {
        self.delegate?.update(with: self.sliderNumLabel.text ?? "default")
        self.navigationController?.popViewController(animated: true)
    }
//    func setLabel(labelValue: String) {
//
//    }
    
    
}
