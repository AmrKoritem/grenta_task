//
//  FavouritesMatchesDelegate.swift
//  grenta_task
//
//  Created by Amr Koritem on 20/03/2024.
//

import UIKit

protocol FavouritesMatchesDelegateDataSource {
    var favouritesMatchesPerDay: [String : [Match]] { get }
}

class FavouritesMatchesDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    var dataSource: FavouritesMatchesDelegateDataSource?
    var toggleFavouriteHandler: (Match) -> Void = { _ in}
    
    var favouritesMatchesPerDay: [String : [Match]]? {
        return dataSource?.favouritesMatchesPerDay
    }
    
    init(dataSource: FavouritesMatchesDelegateDataSource) {
        self.dataSource = dataSource
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return favouritesMatchesPerDay?.keys.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sequence = favouritesMatchesPerDay?.keys else { return nil }
        return Array(sequence)[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !(favouritesMatchesPerDay?.keys.isEmpty ?? true),
              let sequence = favouritesMatchesPerDay?.keys else { return 0 }
        let day = Array(sequence)[section]
        return favouritesMatchesPerDay?[day]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.reuseIdentifier, for: indexPath)
        cell.selectionStyle = .none
        guard let selectedMatches = favouritesMatchesPerDay else { return cell }
        let day = Array(selectedMatches.keys)[indexPath.section]
        guard let match = selectedMatches[day]?[safe: indexPath.row] else { return cell }
        let matchCell = cell as? MatchTableViewCell
        matchCell?.setMatch(match)
        matchCell?.toggleFavouriteHandler = { [weak self, match, tableView] in
            self?.toggleFavouriteHandler(match)
            tableView.reloadData()
        }
        return cell
    }
}
