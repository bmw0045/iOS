//
//  SegmentedViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import Foundation
import UIKit

protocol SegmentedViewControllerDelegate {
    func updateSeg(with newText: String)
    
}
class SegmentedViewController: UIViewController {
    
    @IBOutlet weak var segmentedLabel: UILabel!
    @IBOutlet weak var segmentedButtons: UISegmentedControl!
    var editLabel: String?
    var segDelegate: SegmentedViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentedLabel?.text = self.editLabel
        
    }
    @IBAction func segmentChanged(_ sender: Any) {
        segmentedLabel.text = segmentedButtons.titleForSegment(at: segmentedButtons.selectedSegmentIndex)
    }
    @IBAction func saveSeg(_ sender: Any) {
        self.segDelegate?.updateSeg(with: self.segmentedLabel.text ?? "default")
        self.navigationController?.popViewController(animated: true)
    }
    
}
