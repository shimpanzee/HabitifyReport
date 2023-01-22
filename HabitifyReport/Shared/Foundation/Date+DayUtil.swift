//
//  Date+DayUtil.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Foundation


extension Date {
    /// Trim date to beginning of day (midnight)
    func beginningOfDay() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))!
    }

    /// Trim date to end of day (midnight the next day)
    func endOfDay() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self.beginningOfDay())!
    }
}
