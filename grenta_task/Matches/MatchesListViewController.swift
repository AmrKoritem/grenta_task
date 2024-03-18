//
//  MatchesListViewController.swift
//  grenta_task
//
//  Created by Amr Koritem on 17/03/2024.
//

import UIKit

class MatchesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(MatchTableViewCell.self)
    }
}

extension MatchesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.reuseIdentifier, for: indexPath)
        return cell
    }
}
