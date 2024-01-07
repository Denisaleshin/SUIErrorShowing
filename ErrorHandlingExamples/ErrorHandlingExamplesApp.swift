//
//  ErrorHandlingExamplesApp.swift
//  ErrorHandlingExamples
//
//  Created by Denis Aleshyn on 07/01/2024.
//

import SwiftUI

@main
struct ErrorHandlingExamplesApp: App {
    
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            OptionsView()
                .environment(\.showError, { error, guidance in
                    errorWrapper = ErrorWrapper(error, guidance: guidance)
                })
                .sheet(item: $errorWrapper) { errorWrapper in
                    ErrorView(errorWrapper: errorWrapper)
                }
            
        }
    }
}
