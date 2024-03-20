//
//  UserDefaults.swift
//  grenta_task
//
//  Created by Amr Koritem on 20/03/2024.
//

import Foundation

extension UserDefaults {
    static var favouriteMatches: [Int] {
        return UserDefaults.standard.array(forKey: UserDefaults.Keys.favourites.rawValue) as? [Int] ?? []
    }
}
