//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 09/09/2023.
//

import SwiftUI

// Displays a list of scrums
struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]    // Takes in an array of DailyScrums

    var body: some View {
        NavigationStack {   // Initiates the stack for navigation views
            List($scrums) { $scrum in     // Lists each scrum
                NavigationLink(destination: DetailView(scrum: $scrum)) { // Each scrum can be clicked to take you to the detailed view.
                    CardView(scrum: scrum)  // Creates a basic card view of each scrum in the list
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {} ) {     // Will add functionality later to add scrums
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
    }
}


struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData))
    }
}
