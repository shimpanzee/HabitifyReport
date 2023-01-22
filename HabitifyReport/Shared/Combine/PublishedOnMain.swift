//
//  PublishedOnMain.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Combine
import Foundation

@propertyWrapper
class PublishedOnMain<Value> {
    @Published var value: Value

    var wrappedValue: Value {
        get { value }
        set { value = newValue }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        return $value
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    init(wrappedValue initialValue: Value) {
        value = initialValue
    }
}
