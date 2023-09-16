/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?  /// A question mark initially sets it to `nil`

    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                /// This Task gets passed through to ScrumsView and gets stored in saveAction (I think)
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            /// Task to do before the ScrumsView is shown
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            /// Sheet gets shown if the errorWrapper binding is not nil
            .sheet(item: $errorWrapper) {
                /// This closure gets run when the sheet is dismissed
                /// If error, load sample data
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                /// This is the content the sheet will display
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
