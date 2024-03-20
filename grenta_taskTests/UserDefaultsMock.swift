//
//  UserDefaultsMock.swift
//  grenta_taskTests
//
//  Created by Amr Koritem on 20/03/2024.
//

import Foundation
@testable import grenta_task

class UserDefaultsMock: UserDefaultsProtocol {
    var favouriteMatches: [Int] {
        return favourites
    }
    
    private var favourites: [Int] = []
    
    func set(_ value: Any?, forKey defaultName: String) {
        guard let value = value as? [Int] else { return }
        favourites = value
    }
}
