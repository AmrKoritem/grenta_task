//
//  Team.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation

// MARK: - WinnerClass
struct Team: Codable {
    let id: Int
    let name: String
    let shortName: String
    let tla: String
    let crest: String
    let address: String
    let website: String
    let founded: Int
    let clubColors: String
    let venue: String
    let lastUpdated: Date
}
