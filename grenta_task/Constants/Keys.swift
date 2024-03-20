//
//  Keys.swift
//  grenta_task
//
//  Created by Amr Koritem on 20/03/2024.
//

import Foundation

extension String {
    enum Keys: String {
        case auth = "X-Auth-Token"
    }
}

extension UserDefaults {
    enum Keys: String {
        case favourites
    }
}
