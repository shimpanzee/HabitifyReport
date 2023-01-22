//
//  RootViewController.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Charts
import CombineCocoa
import Combine
import TinyConstraints
import UIKit

class RootViewController: UIViewController {

    let viewModel: RootViewModel
    var subscriptions = Set<AnyCancellable>()
    var spinner = UIActivityIndicatorView(style: .large)
    let toolbar: ReportToolbar

    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        toolbar = ReportToolbar(viewModel: viewModel.toolbarModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configureToolbar()
        configureChart()
        configureSpinner()

        configureSubscriptions()
    }

    private func configureSubscriptions() {
        toolbar.setupButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .map { true }
            .assign(to: \.viewModel.showSetup, onWeak: self)
            .store(in: &subscriptions)

        viewModel.$showSetup
            .filter { $0 }
            .sink { [weak self] _ in self?.showSetup() }
            .store(in: &subscriptions)

        viewModel.$showSpinner
            .map { !$0 }
            .assign(to: \.spinner.isHidden, onWeak: self)
            .store(in: &subscriptions)

        viewModel.$alert
            .sink { [weak self] _ in self?.presentAlert() }
            .store(in: &subscriptions)
    }

    private func presentAlert() {
        if let alert = viewModel.alert {
            dismiss(animated: true) {
                self.present(alert, animated: true)
                self.viewModel.alert = nil
            }
        }
    }

    private func configureToolbar() {
        let guide = view.safeAreaLayoutGuide

        view.addSubview(toolbar)
        
        toolbar.edgesToSuperview(excluding: [.top, .bottom])
        toolbar.bottom(to: guide)
        toolbar.height(44)

    }

    private func configureChart() {
        let guide = view.safeAreaLayoutGuide

        let chartView = viewModel.chartView
        view.addSubview(chartView)
        chartView.edges(to: guide, excluding: .bottom)
        chartView.bottomToTop(of: toolbar)
    }

    private func configureSpinner() {
        // Create the spinner and bind it to the viewModel.showSpinner property
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.center(in: view)
        spinner.isHidden=false
    }

    private func showSetup() {
        let editor = SingleValueEditor(title: "Setup",
                                       message: "Type or paste api key",
                                       placeholderText: "api key",
                                       value: viewModel.apiKey) { [weak self] newKey in
            self?.viewModel.apiKey = newKey
        }
        present(editor, animated: true)
    }
}
