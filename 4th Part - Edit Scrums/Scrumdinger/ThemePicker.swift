//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 10/09/2023.
//

import SwiftUI

// This confuses me a little but it lists each theme as a selectable option
struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}
