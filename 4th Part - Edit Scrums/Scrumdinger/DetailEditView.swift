//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 09/09/2023.
//

import SwiftUI

// View to edit the details of a scrum
struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""

    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {    // Slider of 5 to 30 going up in steps of 1
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                }
                ThemePicker(selection: $scrum.theme)    // Adds the ability to change the theme through a different view
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in  // Lists each attendee
                    Text(attendee.name)
                }
                .onDelete { indices in  // Allows user to swipe an attendee to delete
                    scrum.attendees.remove(atOffsets: indices)  // Deletes the swiped on attendee
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {    // Takes the user entered name and adds it to the scrum
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
