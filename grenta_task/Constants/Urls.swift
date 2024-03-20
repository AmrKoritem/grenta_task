//
//  Urls.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation

extension String {
    enum Urls: String {
        case base = "https://api.football-data.org/v4"
        case matches = "/competitions/PL/matches"
        
        func withFilters(_ filters: [Filter : String?]) -> String {
            let fltrs = filters.reduce("") { partialResult, keyValue in
                return keyValue.value == nil ? "" : "\(partialResult)\(keyValue.key.rawValue)\(keyValue.value!)&"
            }
            return rawValue + "?\(fltrs)"
        }
    }
    
    enum Filter: String, Hashable {
        case dateFrom
        case dateTo
    }
}
