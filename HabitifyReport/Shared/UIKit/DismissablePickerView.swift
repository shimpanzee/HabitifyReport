//
//  DismissablePickerView.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import UIKit

class DismissablePickerView: UIPickerView {
    let dismisser: ()->Void

    init(dismisser: @escaping ()->Void) {
        self.dismisser = dismisser
        super.init(frame: .null)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointInside = super.point(inside: point, with: event)

        if !pointInside {
            dismisser()
        }
        return pointInside
    }
}

