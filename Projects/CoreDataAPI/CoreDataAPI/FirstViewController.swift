//
//  ViewController.swift
//  CoreDataAPI
//
//  Created by Field Employee on 12/27/20.
//

import UIKit

struct Ship: Codable {
    var id: Int = 0
    var title: String?
    var description: String?
    
    init(withData data:[String:AnyObject]) {
        self.id = data["id"] as? Int ?? 0
        self.title = data["title"] as? String ?? "untitled"
        self.description = data["description"] as? String ?? "unknown"
    }
}

class FirstViewController: UIViewController {
    @IBOutlet weak var charTableView: UITableView!
    
    var ships : [Ship] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.charTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.charTableView.dataSource = self
        self.charTableView.delegate = self
        fetchShips()
        print("\(ships)")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetchShips()
    }
    
    func fetchShips() {
        if let url = URL(string: "https://assets.shpock.com/mobile/interview-test/pirateships") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                }
   
                guard let data = data else {return}
                //let decoder = JSONDecoder()
                if let ship = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    //print("Got the ships: \(ship["ships"] as? [Any])")
                    if let ships = ship["ships"] as? [Any] {
                        let filtered = ships.compactMap { one in
                            one as? [String:AnyObject]
                        }
                        filtered.forEach { one in
                            let ship = Ship(withData: one)
                            self.ships.append(ship)
                        }
                }
            }
        }.resume()
    }
}
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.charTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(with: self.ships[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
}

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailVC", sender: self)
        print(ships[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondViewController {
            destination.myShip = ships[charTableView.indexPathForSelectedRow!.row]
        }
    }
    
}

