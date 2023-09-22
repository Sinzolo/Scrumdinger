//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 22/09/2023.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                    .fontWeight(.bold)
                Text("Attendees")
                    .font(.system(size: 21))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 1)
                Text(history.attendeeString)
                Text("Transcipt")
                    .font(.system(size: 21))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top, 8)
                    .padding(.bottom, 1)
                if let transcript = history.transcript {
                    Text("\"\(transcript)\"")
                }
                else {
                    Text("Transcript Unavailable")
                        .fontWeight(.medium)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 1.0, brightness: 0.657)/*@END_MENU_TOKEN@*/)
                        
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map{ $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(date: Date(), attendees: [
            DailyScrum.Attendee(name: "Jon"),
            DailyScrum.Attendee(name: "Darla"),
            DailyScrum.Attendee(name: "Luis")])
//        ],
//                transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI...")
    }
    
    static var previews: some View {
        HistoryView(history: history)
    }
}
