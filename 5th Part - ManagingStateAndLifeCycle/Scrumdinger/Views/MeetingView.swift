/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()  /// Does the timing of the scrum
    
    var body: some View {
    ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                /// Displays the view for the time bar and the seconds
                MeetingHeaderView(secondsElasped: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                Circle()
                    .strokeBorder(lineWidth: 24)
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
            .padding()
            .foregroundColor(scrum.theme.accentColor)
            .onAppear { /// When the MeetingView is shown, reset and start the scrum timer
                scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
                scrumTimer.startScrum()
            }
            .onDisappear {  /// Stop scrum timer on view dissapearing
                scrumTimer.stopScrum()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
