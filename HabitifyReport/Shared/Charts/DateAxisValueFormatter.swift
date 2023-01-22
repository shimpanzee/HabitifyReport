//
//  DateAxisValueFormatter.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Charts

class DateAxisValueFormatter: AxisValueFormatter {
    /// .
    /// Override the default AxisValueFormatter implementation and treat
    /// the value as a unix time stamp which we can convert to a formatted
    /// Date String
    ///
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String {
        let dt = Date(timeIntervalSince1970: value)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let result = dateFormatter.string(from: dt)

        return result
    }
}
