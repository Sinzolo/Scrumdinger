/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    /// Does the timing of the scrum
    @StateObject var scrumTimer = ScrumTimer()
    
    /// Ding noise
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    var body: some View {
    ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElasped: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                Circle()
                    .strokeBorder(lineWidth: 24)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
            .padding()
            .foregroundColor(scrum.theme.accentColor)
            .onAppear { /// When the MeetingView is shown, reset and start the scrum timer
                scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
                scrumTimer.speakerChangedAction = {
                    player.seek(to: .zero)
                    player.play()
                }
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
