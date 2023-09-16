//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 16/09/2023.
//

import SwiftUI

/// Displays the view of the circle with who is speaking in the centre.
struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    
    /// Returns the name of the first speaker who has not completed talking. If no-one, return the string "`Someone`"
    private var currentSpeaker: String {
        speakers.first(where: {!$0.isCompleted })?.name ?? "Someone"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                /// For each speaker that has completed speaking, add an arc to the circle.
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: {$0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12) /// Traces the edge of the shape (in this case a circle which makes an arc)
                            .brightness(-0.2)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Bill", isCompleted: true), ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
    }
    
    static var previews: some View {
        MeetingTimerView(speakers: speakers, theme: .yellow)
    }
}
