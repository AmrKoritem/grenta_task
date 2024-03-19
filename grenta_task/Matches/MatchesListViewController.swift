//
//  MatchesListViewController.swift
//  grenta_task
//
//  Created by Amr Koritem on 17/03/2024.
//

import UIKit
import Toast

class MatchesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var matchesViewModel: MatchesListViewModelProtocol = MatchesListViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getMatches()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(MatchTableViewCell.self)
    }
    
    func getMatches() {
        Task {
            let errorMessage = await matchesViewModel.getMatches()
            guard let errorMessage else {
                tableView.reloadData()
                return
            }
            self.view.makeToast(errorMessage)
        }
    }
}

extension MatchesListViewController: MatchesListViewModelDelegate {}

extension MatchesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchesViewModel.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.reuseIdentifier, for: indexPath)
        let match = matchesViewModel.matches[indexPath.row]
        let matchCell = cell as? MatchTableViewCell
        matchCell?.setMatch(match)
        return cell
    }
}
