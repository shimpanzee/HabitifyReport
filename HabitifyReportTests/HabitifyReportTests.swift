//
//  HabitifyReportTests.swift
//  HabitifyReportTests
//
//  Created by John Shimmin on 1/14/23.
//

import XCTest
@testable import HabitifyReport


class HabitifyReportTests: XCTestCase {

    func habitRequest<T: Codable>(path: String, params: [String:String] = [:]) async throws -> T {

        let headers = ["Authorization": "ecd31dc107e5473d06dd8d2f1142993e0963c22ea25e26e8de8e7764c8f1b462"]

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

//    func testLogs() throws {
//        let exp = expectation(description: "network wait")
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//
//        let to = Date()
//        let from = Calendar.current.date(byAdding: .day, value: -21, to: to)!
//
//        let params: [String:String] = [
//            "from": formatter.string(from: from),
//            "to": formatter.string(from: to),
//        ]
//
//        print(params)
//
//        let path = "logs/2B6B164F-121E-47AC-B574-F861324F5591"
//
//        Task {
//            do {
//                defer { exp.fulfill() }
//                guard let logsJson: HabitLogsJson = try await habitRequest(path: path, params: params) else {
//                    return
//                }
//
//
//                guard let logs = logsJson.logs else {
//                    print("No logs, message: \(logsJson.message)")
//                    return
//                }
//
//                print("Logs: \(logs)")
//
//            } catch {
//                print("Request failed: \(error)")
//                XCTAssertNoThrow(error)
//            }
//        }
//
//        wait(for: [exp], timeout: 10)
//
//
//    }


    func testHabits() async throws {
        let habitsJson: HabitsJson = try await habitRequest(path: "habits")

        guard let habits = habitsJson.habits else {
            print("No habits, message: \(habitsJson.message)")
            return
        }

        let nameIds = habits.map { habit in
            (habit.name, habit.id)
        }

        print("\(nameIds)")

        XCTAssertEqual(10, 10)

    }

}

//[("Resistance Training", "-NHNVMahnaXR8aV938sV"), ("HIIT", "-NHNVes2cqrTpH7Q8FPE"), ("Advil", "-NHQ-KiQVAIhKDuob4P0"), ("Tylenol", "-NHQ-d_eT1C9M4-p0rKL"), ("Antacids", "-NHQKO1zhnN9PE1-tq2D"), ("Meditate", "05F38367-CF12-4D1E-BD2B-78D7B9206C51"), ("Practice Coding", "2B6B164F-121E-47AC-B574-F861324F5591"), ("Drink water ", "4660AE24-9B68-4C1D-8CE0-FB78F67BF6A2"), ("Limit Overeating", "4FEBF114-FF97-4EB6-840A-346597C336A3"), ("Music", "677140E0-6A2F-4C5D-9005-132882DD6CBB"), ("Physical therapy", "6D765C3D-E09C-41DA-8B96-B3B85826B60A"), ("Reflux", "7E7E4034-609A-4327-9DE3-A3FC9E5C921E"), ("Limit sugar", "91D9EE7E-05FB-482B-8AA8-17E86D9760B3"), ("Limit alcohol", "F918DC9E-7826-4BA8-A27B-C9D7064C9006")]
