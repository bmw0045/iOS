//
//  ViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import UIKit

class ViewController: UIViewController {
    private var controls: [Any] = ["Slider: ", "Segmented: ", "Text: ", "Stepper: ", "Switch: "]
    private var values: [Any] = ["0", "Hello", "Enter Text..", "0", "On"]
    @IBOutlet weak var todoListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoListTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.todoListTableView.dataSource = self
        self.todoListTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
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
        let fieldToEdit = self.values[indexPath.row]
        textVC.editLabel = fieldToEdit as? String
        textVC.textDelegate = self
        self.navigationController?.pushViewController(textVC, animated: true)
        
    case 3: //stepper
        let stepperVC = storyboard.instantiateViewController(identifier: "StepperViewController") as! StepperViewController
        let fieldToEdit = self.values[indexPath.row]
        stepperVC.editLabel = fieldToEdit as? String
        stepperVC.stepDelegate = self
        self.navigationController?.pushViewController(stepperVC, animated: true)
        
    default: //switch
        let switchVC = storyboard.instantiateViewController(identifier: "SwitchViewController") as! SwitchViewController
        let fieldToEdit = self.values[indexPath.row]
        switchVC.editLabel = fieldToEdit as? String
        switchVC.switchDelegate = self
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

extension ViewController: TextViewControllerDelegate {
    func updateText(with newText: String) {
        let textSelectedIndex = self.todoListTableView.indexPathForSelectedRow?.row
        self.values[textSelectedIndex ?? 2] = newText
        self.todoListTableView.reloadData()
    }
}

extension ViewController: StepperViewControllerDelegate {
    func stepperUpdate(with newStep: String) {
        self.values[3] = newStep
        self.todoListTableView.reloadData()
    }
}

extension ViewController: SwitchViewControllerDelegate {
    func switchUpdate(with newSwitch: String) {
        self.values[4] = newSwitch
        self.todoListTableView.reloadData()
    }
    
    
}

    
    

