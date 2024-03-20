//
//  UserDefaults.swift
//  grenta_task
//
//  Created by Amr Koritem on 20/03/2024.
//

import Foundation

protocol UserDefaultsProtocol {
    var favouriteMatches: [Int] { get }
    func set(_ value: Any?, forKey defaultName: String)
}

extension UserDefaults: UserDefaultsProtocol {
    var favouriteMatches: [Int] {
        return array(forKey: UserDefaults.Keys.favourites.rawValue) as? [Int] ?? []
    }
}
