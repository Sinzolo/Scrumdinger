//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 16/09/2023.
//

import SwiftUI

/// Creates a segment of a circle based on what speaker your up to and the total of speakers.
struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeakers: Int
    
    /// Number of degrees of a circle per speaker.
    private var degreesPerSpeaker: Double {
        360.0 / Double(totalSpeakers)
    }
    /// Starting angle of the current speaker in reference to their index position in the total list of speakers.
    private var startAngle: Angle {
        Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0)
    }
    /// Ending angle of the current speaker in reference to their index position in the total list of speakers.
    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
    }

    /// Returns a segment of a circle based on `speakerIndex` and `totalSpeakers`.
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
