//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 09/09/2023.
//

import SwiftUI

// Honestly don't really understand why the tutorial had me doing this
// Something to do with keeping trailing and leading padding the same or something not sure
struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
