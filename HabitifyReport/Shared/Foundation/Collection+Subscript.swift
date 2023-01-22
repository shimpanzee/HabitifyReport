//
//  Collection+Subscript.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
