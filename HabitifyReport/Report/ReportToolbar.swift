//
//  ReportToolbar.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Combine
import CombineCocoa
import TinyConstraints
import UIKit

class ReportToolbar: UIToolbar {

    let viewModel: ReportToolbarViewModel

    let setupButton = UIButton()
    let habitLabel = UITextField()
    var habitPicker: UIPickerView!

    var subscriptions = Set<AnyCancellable>()

    init(viewModel: ReportToolbarViewModel) {
        self.viewModel = viewModel

        super.init(frame: .null)

        habitPicker = DismissablePickerView { [weak self] in self?.endEditing(true) }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        let spacer = {
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        }

        setupButton.setImage(UIImage(systemName: "gear"), for: .normal)
        let setupItem = UIBarButtonItem(customView: setupButton)

        habitLabel.inputView = habitPicker
        habitLabel.placeholder="Select habit"
        habitPicker.dataSource = self
        habitPicker.delegate = self

        let habitPickerItem = UIBarButtonItem(customView: habitLabel)

        let startDatePicker = UIDatePicker()
        startDatePicker.datePickerMode = .date
        startDatePicker.date = viewModel.from

        startDatePicker.datePublisher
            .removeDuplicates()
            .filter { [weak self] fromDate in
                return self?.viewModel.dateRangeIsValid(candidateFromDate: fromDate) ?? false
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.viewModel.from, onWeak: self)
            .store(in: &subscriptions)

        let endDatePicker = UIDatePicker()
        endDatePicker.datePickerMode = .date
        endDatePicker.date = viewModel.to
        endDatePicker.datePublisher
            .removeDuplicates()
            .filter { [weak self] toDate in
                return self?.viewModel.dateRangeIsValid(candidateToDate: toDate) ?? false
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.viewModel.to, onWeak: self)
            .store(in: &subscriptions)

        let startDatePickerItem = UIBarButtonItem(customView: startDatePicker)
        let endDatePickerItem = UIBarButtonItem(customView: endDatePicker)

        let items = [
            spacer(),
            habitPickerItem,
            spacer(),
            startDatePickerItem,
            spacer(),
            endDatePickerItem,
            spacer(),
            setupItem,
            spacer()
        ]

        setItems(items, animated: false)

        configureSubscriptions()
    }

    private func configureSubscriptions() {
        // Update the habit dropdown label when the habit property is set
        viewModel.$habit
            .map { $0?.name ?? "" }
            .assign(to: \.habitLabel.text, onWeak: self)
            .store(in: &subscriptions)

        // Force a reconfiguration of the habitPicker when the habits property is set
        viewModel.$habits
            .sink { [weak self] _ in
                if let self = self {
                    self.habitPicker.reloadAllComponents()
                    self.selectRow()
                }
            }
            .store(in: &subscriptions)
    }
}

extension ReportToolbar: UIPickerViewDataSource, UIPickerViewDelegate {

    func selectRow() {
        // Make sure the dropdown reflects the current value of habitId
        if let index = viewModel.habits.firstIndex(where: { $0.id == viewModel.habitId }) {
            habitPicker.selectRow(index, inComponent: 0, animated: true)
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.habits.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.habits[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let habit = viewModel.habits[row]
        viewModel.habit = habit

        // endEditing is required to make the dropdown disappear after selection
        self.endEditing(true)
    }

}
