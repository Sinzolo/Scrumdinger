//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Melchizedek Gray on 15/09/2023.
//

import Foundation

/// Wraps an error with guidance
struct ErrorWrapper: Identifiable {
    let id : UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
