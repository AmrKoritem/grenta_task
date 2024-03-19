//
//  String+Date.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation

extension Date {
    func toString(withFormat format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
