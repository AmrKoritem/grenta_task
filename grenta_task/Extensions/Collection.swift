//
//  Collection.swift
//  grenta_task
//
//  Created by Amr Koritem on 20/03/2024.
//

import Foundation

extension Sequence where Element: Hashable {
    var uniqued: [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
