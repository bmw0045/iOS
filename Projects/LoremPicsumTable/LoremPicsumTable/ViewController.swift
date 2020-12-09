//
//  ViewController.swift
//  LoremPicsumTable
//
//  Created by Field Employee on 12/9/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var picsumTableView: UITableView!
    private var picsumArray: [LoremPicsum] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getTenPicsum()
        self.picsumTableView.dataSource = self
    }
    
    func getRandomURL() -> String {
        let randomNum = Int.random(in: 1...250)
        return "https://picsum.photos/id/\(randomNum)/info"
    }
    
    func getTenPicsum() {
        self.picsumTableView.register(UINib(nibName: "PicsumTableViewCell", bundle: nil), forCellReuseIdentifier: "PicsumTableViewCell")
        self.picsumTableView.dataSource = self
        let group = DispatchGroup()
        for _ in 1...10 {
            group.enter()
            NetworkManager.shared.getDecodedObject(from: self.getRandomURL()) {
                (loremPicsum: LoremPicsum?, error) in
                guard let loremPicsum = loremPicsum else { return }
                self.picsumArray.append(loremPicsum)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.picsumTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.picsumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = picsumTableView.dequeueReusableCell(withIdentifier: "PicsumTableViewCell", for: indexPath) as! PicsumTableViewCell
        cell.configure(with: self.picsumArray[indexPath.row])
        return cell
        
    }
}

