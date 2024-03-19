//
//  Data.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation

extension Data {
    var printable: [String: Any]? {
        let jsonObject = try? JSONSerialization.jsonObject(with: self, options: .allowFragments)
        return jsonObject.flatMap { $0 as? [String: Any] }
    }
}
