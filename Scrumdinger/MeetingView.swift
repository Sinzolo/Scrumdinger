//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 08/09/2023.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 15)
            HStack {
                Text("Seconds Elasped...")
                Text("Seconds asdmadsf...")
            }
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
