//
//  ContentView.swift
//  ErrorHandlingExamples
//
//  Created by Denis Aleshyn on 07/01/2024.
//

import SwiftUI

struct ShoeErrorEnvironmentKey: EnvironmentKey {
    static var defaultValue: (Error, String) -> Void = { _, _ in }
}

extension EnvironmentValues {
    var showError: (Error, String) -> Void {
        get { self[ShoeErrorEnvironmentKey.self] }
        set {self[ShoeErrorEnvironmentKey.self] = newValue }
    }
}

struct SheetErrorThrowingView: View {
    
    @Environment(\.showError) var showError
    
    var body: some View {
        VStack {
            Button("Throw Error") {
                do {
                    throw SampleError.operationFailed
                } catch {
                    showError(error, "try again later")
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct ContentContainerView: View {
    @State  var errorWrapper: ErrorWrapper?
    var body: some View {
        SheetErrorThrowingView()
            .environment(\.showError) { error, guidance in
                errorWrapper = ErrorWrapper(error, guidance: guidance)
            }
            .sheet(item: $errorWrapper) { errorWrapper in
                ErrorView(errorWrapper: errorWrapper)
            }
    }
}

#Preview {
    ContentContainerView()
}


struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String?
    
    init(_ error: Error, guidance: String? = nil) {
        self.id = UUID()
        self.error = error
        self.guidance = guidance
    }
}

enum SampleError: Error {
    case operationFailed
}
