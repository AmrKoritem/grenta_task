//
//  MatchTableViewCell.swift
//  grenta_task
//
//  Created by Amr Koritem on 18/03/2024.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var resultOrTimeLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var toggleFavouriteHandler: () -> Void = {}
    
    @IBAction func toggleFavourite() {
        toggleFavouriteHandler()
    }
    
    func setLabels(homeTeam: String, awayTeam: String, resultOrTime: String?) {
        homeTeamLabel.text = homeTeam
        awayTeamLabel.text = awayTeam
        resultOrTimeLabel.text = resultOrTime
    }
    
    func setFavourite(_ isFavourite: Bool) {
        favouriteButton.setImage(UIImage(systemName: "star\(isFavourite ? ".fill" : "")"), for: .normal)
    }
}

extension MatchTableViewCell {
    func setMatch(_ match: Match) {
        let isDraw = match.score.winner == .draw
        let winner = match.winnerTeam?.name
        let result = isDraw ? "Draw" : "Winner is: \(winner ?? "")"
        let time = "Starts on: \(match.time ?? "")"
        let isTime = winner == nil && !isDraw
        setLabels(
            homeTeam: match.homeTeam.name,
            awayTeam: match.awayTeam.name,
            resultOrTime: isTime ? time : result)
    }
}
