//
//  ViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import UIKit

class ViewController: UIViewController {
    private var controls: [Any] = ["Slider: ", "Segmented: ", "Text: ", "Stepper: ", "Switch: "]
    private var values: [Any] = ["0", "Hello", "Enter Text..", 0, true]
    @IBOutlet weak var todoListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoListTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.todoListTableView.dataSource = self
        self.todoListTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    //let storyboard = UIStoryboard(name: "Main", bundle: nil)
   // let sliderVC = storyboard.instantiateViewController(withIdentifier: "SliderViewController") as! SliderViewController

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let control = self.controls[indexPath.row]
        let value = self.values[indexPath.row]
        cell.todoLabel?.text = "\(control) \(value)"
        return cell
    }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.controls.count
  }
}
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    var initialValue: String
    switch indexPath.row {
    case 0: //slider
        let sliderVC = storyboard.instantiateViewController(identifier: "SliderViewController") as! SliderViewController
        let fieldToEdit = self.values[indexPath.row]
        let initSlider = self.values[indexPath.row]
        sliderVC.editLabel = fieldToEdit as? String
        sliderVC.initialSlider = initSlider as? Float
        sliderVC.delegate = self
        self.navigationController?.pushViewController(sliderVC, animated: true)
    
    case 1: //segmented
        let segmentedVC = storyboard.instantiateViewController(identifier: "SegmentedViewController") as! SegmentedViewController
        let fieldToEdit = self.values[indexPath.row]
        segmentedVC.editLabel = fieldToEdit as? String
        segmentedVC.segDelegate = self
        self.navigationController?.pushViewController(segmentedVC, animated: true)
        
    case 2: //text field
        let textVC = storyboard.instantiateViewController(identifier: "TextViewController") as! TextViewController
        self.navigationController?.pushViewController(textVC, animated: true)
        
    case 3: //stepper
        let stepperVC = storyboard.instantiateViewController(identifier: "StepperViewController") as! StepperViewController
        self.navigationController?.pushViewController(stepperVC, animated: true)
        
    default: //switch
        let switchVC = storyboard.instantiateViewController(identifier: "SwitchViewController") as! SwitchViewController
        self.navigationController?.pushViewController(switchVC, animated: true)
    }
    tableView.reloadData()
  }
    
}

extension ViewController: SliderViewControllerDelegate {
    func update(with newText: String) {
           let selectedIndex = self.todoListTableView.indexPathForSelectedRow?.row
            self.values[selectedIndex ?? 0] = newText
            self.todoListTableView.reloadData()
    }
}

extension ViewController: SegmentedViewControllerDelegate {
    func updateSeg(with segNewText: String) {
        let segSelectedIndex = self.todoListTableView.indexPathForSelectedRow?.row
        self.values[segSelectedIndex ?? 1] = segNewText
        self.todoListTableView.reloadData()
    }
}
    
    

