//
//  ChartDataEntry+Date.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Charts

extension ChartDataEntry {
    /// Dates are natively supported in Charts, so provide a convenience that can handle
    /// them.
    ///
    /// - Parameters
    ///   - x: the x value
    ///   - y: the y value (the actual value of the entry)
    ///   - granularity: if provided, truncate the date to provided granularity
    ///     
    convenience init(x: Date, y: Double, granularity: Calendar.Component? = nil) {
        let orderedComponents: [Calendar.Component] = [
            .year, .month, .day, .hour, .minute, .second ]

        var adjustedX = x

        if let granularity = granularity,
           let index = orderedComponents.firstIndex(of: granularity),
           let component = orderedComponents[safe: index+1],
           let x = x.dateTruncated(from: component) {

            adjustedX = x
        }

        self.init(x: adjustedX.timeIntervalSince1970, y: Double(y))
    }

}
