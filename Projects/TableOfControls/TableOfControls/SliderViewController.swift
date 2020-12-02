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
   // @IBOutlet weak var slider: UISlider!
    //self.sliderNumLabel = indexPath[0]
   // sliderNumLabel.text = ViewController.initialValue
    //@IBAction func sliderValueChanged(_ sender: UISlider) {
    //}
    
    func setLabel(labelValue: String) {
        
    }
    
    
}
