//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 14/09/2023.
//

import SwiftUI

@MainActor
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    /// Returns a URL that points to where to save the scrums
    private static func fileURL() throws -> URL {
        // Gets the URL for the users document folder with "scrums.data" appended
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("scrums.data")
    }
    
    /// Loads and then stores the scrums in `scrums`
    func load() async throws {
        /// Task to load and return the scrums
        let task = Task<[DailyScrum], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            return dailyScrums
        }
        // Attempts to load scrums and store them
        self.scrums = try await task.value
    }
    
    /// Saves the given scrums to persistent storage
    func save(scrums: [DailyScrum]) async throws {
        let task = Task {
            // Encodes the scrums and then writes them to storage
            let data = try JSONEncoder().encode(scrums)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
