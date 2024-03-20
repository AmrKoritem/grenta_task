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

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension MutableCollection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        get {
            indices.contains(index) ? self[index] : nil
        }
        set {
            guard let newValue = newValue, indices.contains(index) else { return }
            self[index] = newValue
        }
    }
}
