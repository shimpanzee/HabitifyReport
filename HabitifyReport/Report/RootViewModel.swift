//
//  RootViewModel.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Foundation
import Combine
import Charts
import SwiftDate
import SwiftUI

class RootViewModel {
    let api = HabitifyAPI()

    @PublishedOnMain
    var to: Date

    @PublishedOnMain
    var from: Date

    // If true, show the API key configuration dialog
    @PublishedOnMain
    var showSetup: Bool = false

    @PublishedOnMain
    var showSpinner: Bool = true

    // All available habits owned by the user
    @PublishedOnMain
    var habits: [Habit] = []

    @PublishedOnMain
    var alert: UIAlertController?

    @AppStorage("apiKey") var apiKey: String = "" {
        didSet {
            if needHabitRefresh {
                fetchHabits()
            } else {
                updateChartData()
            }
        }
    }

    private (set) var toolbarModel: ReportToolbarViewModel
    let chartView = LineChartView()
    private var chartData = LineChartData()
    private var needHabitRefresh = true

    private var subscriptions = Set<AnyCancellable>()

    init() {
        let defaultTo = Date().beginningOfDay()
        let defaultFrom = Calendar.current.date(byAdding: .day, value: -21, to: defaultTo)!.endOfDay()

        to = defaultTo
        from = defaultFrom

        toolbarModel = ReportToolbarViewModel(to: defaultTo, from: defaultFrom)

        configureSubscriptions()

        if apiKey.isEmpty {
            showSetup = true
        } else {
            fetchHabits()
        }
    }

    func configureSubscriptions() {

        // Update chart data if currently selected habit, start date, or end date
        // change
        $from
            .combineLatest($to, toolbarModel.$habit)
            .removeDuplicates(by: ==)
            .filter { (_, _, habit) in habit != nil }
            .sink { [weak self] tup in
                self?.updateChartData()
            }
            .store(in: &subscriptions)

        // Mirror habits to the habits dropdown (which is fed by toolbarModel)
        $habits
            .assign(to: \.toolbarModel.habits, onWeak: self)
            .store(in: &subscriptions)

        toolbarModel.$to
            .dropFirst()
            .map {
                $0.beginningOfDay()
            }
            .assign(to: \.to, onWeak: self)
            .store(in: &subscriptions)

        toolbarModel.$from
            .dropFirst()
            .map {
                $0.beginningOfDay()
            }
            .assign(to: \.from, onWeak: self)
            .store(in: &subscriptions)

        toolbarModel.$errorMessage
            .filter { $0 != nil }
            .sink { [weak self] in
                self?.displayError(message: $0!)
            }
            .store(in: &subscriptions)
    }

    func displayError(message: String) {
        alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert!.addAction(UIAlertAction(title: "Ok", style: .default))
        toolbarModel.errorMessage = nil
    }

    func fetchHabits() {
        // Fetch habits if needed which is either because we just started the app
        // or the apiKey has changed

        if !needHabitRefresh {
            return
        }
        Task {
            habits = try await api.getHabits()
            needHabitRefresh = false
        }
    }

    private func getLogs() async -> [HabitLog] {
        guard let habit = toolbarModel.habit else {
            print("Habit is not set")
            return []
        }

        do {
            let to = to.endOfDay()
            return try await api.getHabitLogs(for: habit.id, to: to, from: from)
        } catch {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
}

extension RootViewModel {

    func updateChartData() {
        guard !apiKey.isEmpty else {
            return
        }
        Task {
            self.showSpinner = true

            let logs = await getLogs()

            if logs.count == 0 {
                clearChartView()
                return
            }

            var unitLabel = "Missing units"
            if let unitType = toolbarModel.habit?.goal.unitType {
                if let habitUnit = HabitUnit(rawValue: unitType) {
                    unitLabel = habitUnit.description()
                } else {
                    print("Unknown unitType found: \(unitType)")
                    unitLabel = unitType
                }
            }

            // translate the raw HabitLog data into ChartDataEntry objects for graphing
            let chartDataEntries = logs.map {
                ChartDataEntry(x: $0.createdDate, y: Double($0.value), granularity: .day)
            }

            let dataSet = LineChartDataSet(entries: chartDataEntries, label:  unitLabel)
            // If there are multiple entries in a day, combine them
            dataSet.mergeXValues()
            dataSet.colors = [.blue]

            chartData = LineChartData(dataSet: dataSet)

            updateChartView()
        }
    }

    func clearChartView() {
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                self.chartData = LineChartData()
                self.chartView.data = nil
                // setting chartView.data to nil doesn't seem to automatically refresh the graph
                // so force it here
                self.chartView.setNeedsDisplay()
                self.showSpinner = false
            }
        }
    }

    func updateChartView() {
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                self.chartView.data = self.chartData

                let xAxis = self.chartView.xAxis
                xAxis.valueFormatter = DateAxisValueFormatter()
                xAxis.axisMinimum = self.from.beginningOfDay().timeIntervalSince1970
                xAxis.axisMaximum = self.to.endOfDay().timeIntervalSince1970
                self.showSpinner = false
            }
        }
    }
}
