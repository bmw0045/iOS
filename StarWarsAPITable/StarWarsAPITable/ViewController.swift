//
//  ViewController.swift
//  StarWarsAPITable
//
//  Created by Field Employee on 12/18/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var characterTableView: UITableView!
    
    //var characters: [
    var characters: [PaginatedCharacter] = []
    var characterBatch: [SWCharacterResult] = []
    var nextURL: String = ""
    public var suffix: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Star Wars Characters"
        // Do any additional setup after loading the view.
        self.characterTableView.dataSource = self
        self.characterTableView.delegate = self
        self.characterTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.getInitialData()
    }
    
    func getInitialData() {
        characterBatch = []
        nextURL = "https://swapi.dev/api/people/?page=1"
        getCharacterData()
    }
    
    func getCharacterData() {
        //if isArrayFull() == false {
         guard let urlObj = URL(string: nextURL) else {return}
         URLSession.shared.dataTask(with: urlObj) {[weak self](data, response, error) in
             guard let data = data else {return}
             do {
                let downloadedCharacters = try JSONDecoder().decode(PaginatedCharacter.self, from: data)
                self?.characterBatch.append(contentsOf: downloadedCharacters.results)
                self?.nextURL = downloadedCharacters.next
                 
                 DispatchQueue.main.async {
                     self?.characterTableView.reloadData()
                 }
             }
            catch {
                 print(error)
             }
            }
         .resume()
        }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailVC", sender: self)
        print(characterBatch[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.myCharacter = characterBatch[characterTableView.indexPathForSelectedRow!.row]
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characterBatch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = characterBatch.count
        let lastElement = count - 1
        if indexPath.row == lastElement {
            getCharacterData()
        }
        let cell = self.characterTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(with: self.characterBatch[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    
}

