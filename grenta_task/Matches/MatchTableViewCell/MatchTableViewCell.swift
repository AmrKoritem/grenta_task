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
    
    func setLabels(homeTeam: String, awayTeam: String, resultOrTime: String?) {
        homeTeamLabel.text = homeTeam
        awayTeamLabel.text = awayTeam
        resultOrTimeLabel.text = resultOrTime
    }
}

extension MatchTableViewCell {
    func setMatch(_ match: Match) {
        let isDraw = match.score.winner == .draw
        let result = match.winnerTeam?.name
        let time = match.time
        let isTime = result == nil && isDraw
        setLabels(
            homeTeam: match.homeTeam.name,
            awayTeam: match.awayTeam.name,
            resultOrTime: isTime ? time : result)
    }
}
