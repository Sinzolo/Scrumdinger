//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 09/09/2023.
//

import SwiftUI

// Takes a scrums data and displays it in more detail
struct DetailView: View {
    let scrum: DailyScrum
    
    @State private var isPresentingEditView = false
    
    var body: some View {
        // List of scrum details
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(5)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in  // For each attendee
                    Label(attendee.name, systemImage: "person") // Add label of attendee name
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {    // When isPresentingEditView is true, present the modal sheet
            NavigationStack {
                DetailEditView()    // Displays edit view
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {   // Adds cancel button
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {   // Adds done button
                            Button("Done") {
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(scrum: DailyScrum.sampleData[0])
        }
    }
}
