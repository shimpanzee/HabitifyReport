//
//  HabitifyAPI.swift
//  HabitifyReport
//
//  Wrapper for the habitify api: https://docs.habitify.me/
//
//  Copyright © 2023 John Shimmin. All rights reserved.
//

import Foundation
import SwiftUI

class HabitifyAPI {
    @AppStorage("apiKey") var apiKey: String = ""

    func getHabits() async throws -> [Habit] {
        let habitsJson: HabitsJson = try await habitRequest(path: "habits")

        guard let habits = habitsJson.habits else {
            throw "No habits, message: \(habitsJson.message)"
        }

        return habits
    }

    func getHabitLogs(for id: String, to: Date, from: Date) async throws -> [HabitLog] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        let params: [String:String] = [
            "from": formatter.string(from: from),
            "to": formatter.string(from: to),
        ]

        let path = "logs/\(id)"

        let logsJson: HabitLogsJson = try await habitRequest(path: path, params: params)

        guard let logs = logsJson.logs else {
            throw "No logs, message: \(logsJson.message)"
        }

        return logs
    }


    private func habitRequest<T: Codable>(path: String, params: [String:String] = [:]) async throws -> T {
        if apiKey.isEmpty {
            throw "apiKey not set"
        }
        
        let headers = ["Authorization": apiKey]

        var url = URLComponents(string: "https://api.habitify.me/\(path)")!
        url.queryItems = params.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        var request = URLRequest(url: url.url!)
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .useProtocolCachePolicy

        let (data, response) =  try await URLSession.shared.data(for: request)

        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard statusCode == 200 else {
          throw "The server responded with an error: \(statusCode)."
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw "Failed to decode: \(error.localizedDescription)"
        }
    }

    
}
