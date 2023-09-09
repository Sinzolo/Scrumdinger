//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 09/09/2023.
//

import Foundation


struct DailyScrum: Identifiable {
    let id: UUID
    var title: String
    var attendees: [Attendee]   // Array of type Attendee
    var lengthInMinutes: Int
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        let attendeeTypeAttendees = attendees.map { Attendee(name :$0) }    // Changes each string in the basic array into an Attendee type.
        self.attendees = attendeeTypeAttendees.sorted { $0.name < $1.name } // Sorts the Attendees alphabetically
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable {     // Attendee struct
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
}


extension DailyScrum {
    static var sampleData: [DailyScrum] {
        [
            DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, theme: .yellow),
            DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, theme: .orange),
            DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .poppy)
        ]
    }
}
