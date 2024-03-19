//
//  Match.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation

// MARK: - Match
struct Match: Codable {
    let area: Area
    let competition: Competition
    let season: Season
    let id: Int
    let utcDate: Date
    let status: String
    let matchday: Int
    let stage: String
    let lastUpdated: Date
    let homeTeam, awayTeam: Team
    let score: Score
    let odds: Odds
    let referees: [Referee]
    
    var winnerTeam: Team? {
        switch score.winner {
        case .homeTeam:
            return homeTeam
        case .awayTeam:
            return awayTeam
        default:
            return nil
        }
    }
    var time: String? {
        return utcDate.toString(withFormat: "HH:mm")
    }
}
