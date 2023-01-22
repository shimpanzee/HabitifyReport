//
//  ReportToolbarViewModel.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import SwiftUI

class ReportToolbarViewModel {
    @PublishedOnMain
    var to: Date

    @PublishedOnMain
    var from: Date

    @PublishedOnMain
    var habits: [Habit] = [] {
        didSet {
            // If habits update, make sure we refresh our currently selected habit object
            if let index = habits.firstIndex(where: { $0.id == habitId }){
                habit = habits[index]
            }
        }
    }

    @PublishedOnMain
    var habit: Habit? = nil {
        didSet {
            if let habit = habit {
                // make sure to keep habitId in sink with the current habit.
                habitId = habit.id
            }
        }
    }

    @PublishedOnMain
    var errorMessage: String? = nil

    // habitId is primarily used as the hook into UserDefaults (via AppStorage).
    // AppStorage mirrors UserDefaults so that we don't have to do so directly.
    @AppStorage("habitId")
    var habitId: String = ""

    init(to: Date, from: Date) {
        self.to = to
        self.from = from
    }

    func dateRangeIsValid(candidateFromDate: Date) -> Bool {
        if to < candidateFromDate {
            errorMessage = "From date must be before to date"
            return false
        }
        return true
    }

    func dateRangeIsValid(candidateToDate: Date) -> Bool {
        if from > candidateToDate {
            errorMessage = "To date must be after from date"
            return false
        }
        return true
    }
}
