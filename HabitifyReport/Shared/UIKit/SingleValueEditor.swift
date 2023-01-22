//
//  SingleValueEditor.swift
//  HabitifyReport
//
// Provides a controller that approximates the visuals of a UIAlertController but
// is specialized to edit a single value.  The main change is that the value of
// the field can be validated when a dialog button is clicked and an error message
// displayed.  If invalid, the dialog will not be dismissed.
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Combine
import TinyConstraints
import UIKit

class SingleValueEditor: UIViewController {
    enum ValidationResult: Equatable {
        case valid
        case invalid(message: String)
    }

    var valueValidator: ((String) -> ValidationResult)?

    private var subscriptions = Set<AnyCancellable>()

    private var titleStr: String
    private var message: String
    private var placeholderText: String
    private var valueUpdated: (String) -> Void
    private var errorMessage: String? {
        didSet {
            configureErrorLabel()
        }
    }

    private var errorLabelHeightConstraint: NSLayoutConstraint

    private let valueField = UITextField()
    private let okButton = UIButton()
    private let cancelButton = UIButton()
    private let errorLabel = UILabel()
    private let modalView = UIView()
    private let toolbar = UIView()

    init(
        title: String,
        message: String,
        placeholderText: String,
        value: String?,
        valueUpdated: @escaping (String) -> Void) {
        titleStr = title
        self.message = message
        self.placeholderText = placeholderText
        self.valueUpdated = valueUpdated
        valueField.text = value

        errorLabelHeightConstraint = errorLabel.heightAnchor.constraint(equalToConstant: 0)

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .clear

        modalView.backgroundColor = .white

        view.addSubview(modalView)

        modalView.backgroundColor = .systemGroupedBackground
        modalView.layer.cornerRadius = 13
        modalView.clipsToBounds = true

        let guide = view.safeAreaLayoutGuide

        modalView.center(in: guide)
        modalView.size(CGSize(width: 270, height: 166))

        configureLabels()

        toolbar.addSubview(cancelButton)
        toolbar.addSubview(okButton)
        toolbar.addSeparator(at: .top, color: .lightGray.withAlphaComponent(0.5))

        configureButtons()

        modalView.addSubview(toolbar)
        toolbar.edges(to: modalView, excluding: .top)
        toolbar.height(44)

        modalView.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = .systemFont(ofSize: 13)
        errorLabel.textColor = .red

        NSLayoutConstraint.activate([
            errorLabel.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 15),
            errorLabel.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -15),
            errorLabelHeightConstraint,
            errorLabel.lastBaselineAnchor.constraint(equalTo: toolbar.topAnchor, constant: -15.0)
        ])

        configureValueField()
    }

    func configureLabels() {
        let titleLabel = UILabel()
        titleLabel.text = titleStr
        titleLabel.font = .systemFont(ofSize: 17)
        modalView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = .systemFont(ofSize: 13)
        modalView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: modalView.centerXAnchor),
            titleLabel.firstBaselineAnchor.constraint(equalTo: modalView.topAnchor, constant: 36),
            messageLabel.centerXAnchor.constraint(equalTo: modalView.centerXAnchor),
            messageLabel.firstBaselineAnchor.constraint(
                equalTo: titleLabel.lastBaselineAnchor,
                constant: 20)
        ])
    }

    func configureButtons() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.systemBlue, for: .normal)
        cancelButton.sizeToFit()
        cancelButton.addSeparator(at: .right, color: .lightGray.withAlphaComponent(0.5))
        cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        cancelButton.tapPublisher
            .sink { [weak self] in self?.dismiss(animated: true) }
            .store(in: &subscriptions)

        okButton.setTitle("Ok", for: .normal)
        okButton.setTitleColor(.systemBlue, for: .normal)
        okButton.setTitleColor(.lightGray, for: .disabled)
        okButton.sizeToFit()
        okButton.isEnabled = !(valueField.text?.isEmpty ?? true)
        okButton.addTarget(self, action: #selector(okClicked), for: .touchUpInside)

        cancelButton.edges(to: toolbar, excluding: .right)
        cancelButton.right(to: toolbar, toolbar.centerXAnchor)

        okButton.edges(to: toolbar, excluding: .left)
        okButton.left(to: toolbar, toolbar.centerXAnchor)
    }

    private func configureValueField() {
        modalView.addSubview(valueField)
        valueField.placeholder = placeholderText
        valueField.backgroundColor = .white
        valueField.font = .systemFont(ofSize: 13)
        valueField.layer.cornerRadius = 7
        valueField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        valueField.layer.borderWidth = 1

        let paddingView =
            UIView(frame: CGRect(x: 0, y: 0, width: 10,
                                 height: valueField.intrinsicContentSize.height))
        valueField.leftView = paddingView
        valueField.leftViewMode = .always

        valueField.addTarget(self, action: #selector(valueDidUpdate), for: .editingChanged)

        valueField.edges(to: modalView, excluding: [.top, .bottom], insets: .horizontal(15))
        valueField.height(30)
        valueField.bottom(to: errorLabel, errorLabel.firstBaselineAnchor, offset: -15)
    }

    func configureErrorLabel() {
        let noMessage = errorMessage?.isEmpty ?? true
        errorLabelHeightConstraint.constant = noMessage ? 0 : 20
        errorLabel.text = errorMessage
    }

    @objc func okClicked() {
        let newValue = valueField.text!
        if let validator = valueValidator {
            switch validator(newValue) {
            case .valid:
                valueUpdated(newValue)
                dismiss(animated: true)
            case .invalid(let message):
                errorMessage = message
            }
        } else {
            valueUpdated(newValue)
            dismiss(animated: true)
        }
    }

    @objc func valueDidUpdate() {
        if let text = valueField.text {
            errorMessage = nil
            okButton.isEnabled = text.count > 0
        }
    }
}
