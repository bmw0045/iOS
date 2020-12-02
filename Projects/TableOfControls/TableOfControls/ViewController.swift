//
//  ViewController.swift
//  TableOfControls
//
//  Created by Field Employee on 12/1/20.
//

import UIKit

class ViewController: UIViewController {
    private var todos = ["0", "0", "0", "0", "0"]
    
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
        let todo = self.todos[indexPath.row]
        cell.todoLabel.text = todo
        return cell
    }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.todos.count
  }
}
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   // self.todos.remove(at: indexPath.row)
    let segueIdentifier: String
//    var initialValue: String
    switch indexPath.row {
    case 0: //slider
        segueIdentifier = "sliderSegue"
       // initialValue = todos[0]
    case 1: //segmented
        segueIdentifier = "segmentedSegue"
    case 2:
        segueIdentifier = "textSegue"
    case 3:
        segueIdentifier = "stepperSegue"
    default:
        segueIdentifier = "switchSegue"
    }
    self.performSegue(withIdentifier: segueIdentifier, sender: self)
    tableView.reloadData()
  }
}

