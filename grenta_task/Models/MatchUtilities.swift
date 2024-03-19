//
//  MatchUtilities.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation

// MARK: - Area
struct Area: Codable {
    let id: Int
    let name: String
    let code: String
    let flag: String
}

// MARK: - Odds
struct Odds: Codable {
    let msg: String
}

// MARK: - Referee
struct Referee: Codable {
    let id: Int
    let name: String
    let type: String
    let nationality: String?
}

// MARK: - Score
struct Score: Codable {
    let winner: ScoreWinner?
    let duration: String
    let fullTime, halfTime: Time
}

enum ScoreWinner: String, Codable {
    case awayTeam = "AWAY_TEAM"
    case draw = "DRAW"
    case homeTeam = "HOME_TEAM"
}

// MARK: - Time
struct Time: Codable {
    let home, away: Int?
}

// MARK: - Season
struct Season: Codable {
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int
    let winner: Team?
}

// MARK: - ResultSet
struct ResultSet: Codable {
    let count: Int
    let first, last: String
    let played: Int
}
