//
//  Codable.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation

extension Data {
    func get<T: Codable>(_ class: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch {
            printInDebug("\(error)")
            return nil
        }
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return jsonObject.flatMap { $0 as? [String: Any] }
    }
}
