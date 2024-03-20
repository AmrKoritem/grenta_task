//
//  MatchesListViewController.swift
//  grenta_task
//
//  Created by Amr Koritem on 17/03/2024.
//

import UIKit
import Toast

class MatchesListViewController: UIViewController, FavouritesMatchesDelegateDataSource {
    @IBOutlet weak var allMatchesTableView: UITableView!
    @IBOutlet weak var favouriteMatchesTableView: UITableView!
    @IBOutlet weak var favouritesSwitch: UISwitch!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var favouritesMatchesPerDay: [String : [Match]] {
        var favourites = matchesViewModel.matchesPerDay.filter { keyValue in
            return keyValue.value.contains { $0.isFavourite }
        }
        favourites.keys.forEach { key in
            favourites[key]?.removeAll { !$0.isFavourite }
        }
        return favourites
    }
    
    lazy var matchesViewModel: MatchesListViewModelProtocol = MatchesListViewModel(self)
    lazy var favouritesDelegate: FavouritesMatchesDelegate = FavouritesMatchesDelegate(dataSource: self)
    
    @IBAction func showFavouritesToggled() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            switch self?.favouritesSwitch.isOn {
            case true:
                self?.allMatchesTableView.alpha = 0
                self?.favouriteMatchesTableView.alpha = 1
            default:
                self?.allMatchesTableView.alpha = 1
                self?.favouriteMatchesTableView.alpha = 0
            }
        }) { [weak self] _ in
            self?.allMatchesTableView.reloadData()
            self?.favouriteMatchesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViews()
        getMatches()
    }
    
    func configureTableViews() {
        allMatchesTableView.delegate = self
        allMatchesTableView.dataSource = self
        allMatchesTableView.registerNib(MatchTableViewCell.self)
        
        favouriteMatchesTableView.delegate = favouritesDelegate
        favouriteMatchesTableView.dataSource = favouritesDelegate
        favouriteMatchesTableView.registerNib(MatchTableViewCell.self)
        favouritesDelegate.toggleFavouriteHandler = { [weak self] match in
            self?.matchesViewModel.setMatch(match.id, isFavourite: false)
        }
    }
    
    func getMatches() {
        Task {
            indicator.isHidden = false
            let errorMessage = await matchesViewModel.getMatches()
            indicator.isHidden = true
            guard let errorMessage else {
                allMatchesTableView.reloadData()
                return
            }
            self.view.makeToast(errorMessage)
        }
    }
}

extension MatchesListViewController: MatchesListViewModelDelegate {}

extension MatchesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchesViewModel.matchesPerDay.keys.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(matchesViewModel.matchesPerDay.keys)[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !matchesViewModel.matchesPerDay.keys.isEmpty else { return 0 }
        let day = Array(matchesViewModel.matchesPerDay.keys)[section]
        return matchesViewModel.matchesPerDay[day]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.reuseIdentifier, for: indexPath)
        cell.selectionStyle = .none
        let day = Array(matchesViewModel.matchesPerDay.keys)[indexPath.section]
        guard let match = matchesViewModel.matchesPerDay[day]?[safe: indexPath.row] else { return cell }
        let matchCell = cell as? MatchTableViewCell
        matchCell?.setMatch(match)
        matchCell?.toggleFavouriteHandler = { [weak self] in
            self?.matchesViewModel.setMatch(match.id, isFavourite: !match.isFavourite)
            self?.allMatchesTableView.reloadRows(at: [indexPath], with: .none)
            self?.favouriteMatchesTableView.reloadData()
        }
        return cell
    }
}
