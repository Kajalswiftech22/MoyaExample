//
//  ComicsViewController.swift
//  MoyaExample
//
//  Created by intern on 6/6/23.
//

import UIKit

class ComicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var comicsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.comicsTableView.delegate = self
        self.comicsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = comicsTableView.dequeueReusableCell(withIdentifier: "comicsCell", for: indexPath) as! ComicsTableViewCell
        return cell
    }
}
