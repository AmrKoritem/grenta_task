//
//  ApiError.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation

struct ApiError: Codable {
    let errorCode: Int
    let message: String
}
