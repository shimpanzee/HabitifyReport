//
//  Publisher+WeakAssign.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Combine

extension Publisher where Self.Failure == Never {
    func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
                      onWeak object: Root) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
