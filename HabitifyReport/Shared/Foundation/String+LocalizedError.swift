//
//  String+LocalizedError.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Foundation

extension String: LocalizedError {
    ///  Allow Strings to be thrown directly
    public var errorDescription: String? { return self }
}
