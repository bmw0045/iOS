//
//  SegmentedViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import Foundation
import UIKit

class SegmentedViewController: UIViewController {
    
    @IBOutlet weak var segmentedLabel: UILabel!
    @IBOutlet weak var segmentedButtons: UISegmentedControl!
    @IBAction func saveSlider(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
