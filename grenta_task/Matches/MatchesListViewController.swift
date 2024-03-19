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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
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
            indicator.isHidden = false
            let errorMessage = await matchesViewModel.getMatches()
            indicator.isHidden = true
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchesViewModel.days.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return matchesViewModel.days[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !matchesViewModel.days.isEmpty else { return 0 }
        let day = matchesViewModel.days[section]
        return matchesViewModel.matchesPerDay[day]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.reuseIdentifier, for: indexPath)
        let day = matchesViewModel.days[indexPath.section]
        guard let match = matchesViewModel.matchesPerDay[day]?[indexPath.row] else { return cell }
        let matchCell = cell as? MatchTableViewCell
        matchCell?.setMatch(match)
        return cell
    }
}
