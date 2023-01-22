//
//  HabitUnit.swift
//  HabitifyReport
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Foundation

enum HabitUnit: String, RawRepresentable {
    case kM
    case m
    case ft
    case yd
    case mi
    case L
    case mL
    case floz
    case cup
    case kg
    case g
    case mg
    case oz
    case lb
    case mcg
    case sec
    case min
    case hr
    case J
    case kJ
    case kCal
    case cal
    case rep

    func description() -> String {
        switch self {
        case .kM: return "Kilometers"
        case .m: return "Meters"
        case .ft: return "Feet"
        case .yd: return "Yards"
        case .mi: return "Miles"
        case .L: return "Liters"
        case .mL: return "Milliliters"
        case .floz: return "Fluid Ounces"
        case .cup: return "Cups"
        case .kg: return "Kilograms"
        case .g: return "Grams"
        case .mg: return "Milligrams"
        case .oz: return "Ounces"
        case .lb: return "Pounds"
        case .mcg: return "Microgram"
        case .sec: return "Seconds"
        case .min: return "Minutes"
        case .hr: return "Hours"
        case .J: return "Joules"
        case .kJ: return "Kilojoules"
        case .kCal: return "Kilocalories"
        case .cal: return "Calories"
        case .rep: return "Reps"
        }
    }
}

