// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(MatchesListResponse.self, from: jsonData)
//
//  MatchesListResponse.swift
//  grenta_task
//
//  Created by Amr Koritem on 18/03/2024.
//

import Foundation

// MARK: - MatchesListResponse
struct MatchesListResponse: Codable {
    let filters: Filters
    let resultSet: ResultSet
    let competition: Competition
    let matches: [Match]
}

// MARK: - Competition
struct Competition: Codable {
    let id: Int
    let name: String
    let code: String
    let type: String
    let emblem: String
}

// MARK: - Filters
struct Filters: Codable {
    let season: String
}
