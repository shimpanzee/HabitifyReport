//
//  ChartDataEntry+Utils.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Charts

extension ChartDataSet {
    /// Collapses multiple entries at a given X into a single data point
    func mergeXValues() {
        let mergedEntries = entries.reduce([], {result,v -> [ChartDataEntry] in
            var arr = result
            if let last = arr.last, last.x == v.x {
                arr[arr.count-1].y += v.y
            } else {
                arr.append(v)
            }
            return arr
        })

        replaceEntries(mergedEntries)
    }
}
