//
//  AlertErrorTrowignView.swift
//  ErrorHandlingExamples
//
//  Created by Denis Aleshyn on 07/01/2024.
//

import SwiftUI

struct AlertErrorTrowignView: View {
    @EnvironmentObject var errorHandling: ErrorHandling
    var body: some View {
        VStack {
            Button("Throw Error") {
                do {
                    throw SampleError.operationFailed
                } catch {
                    self.errorHandling.handle(error: error)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    AlertErrorTrowignView()
}

struct ErrorAlert: Identifiable {
    var id = UUID()
    var message: String
    var dismissAction: (() -> Void)?
}

class ErrorHandling: ObservableObject {
    @Published var currentAlert: ErrorAlert?

    func handle(error: Error) {
        currentAlert = ErrorAlert(message: error.localizedDescription)
    }
}


struct HandleErrorsByShowingAlertViewModifier: ViewModifier {
    @StateObject var errorHandling = ErrorHandling()

    func body(content: Content) -> some View {
        content
            .environmentObject(errorHandling)
            // Applying the alert for error handling using a background element
            // is a workaround, if the alert would be applied directly,
            // other .alert modifiers inside of content would not work anymore
            .background(
                EmptyView()
                    .alert(item: $errorHandling.currentAlert) { currentAlert in
                        Alert(
                            title: Text("Error"),
                            message: Text(currentAlert.message),
                            dismissButton: .default(Text("Ok")) {
                                currentAlert.dismissAction?()
                            }
                        )
                    }
            )
    }
}

extension View {
    func withErrorHandling() -> some View {
        modifier(HandleErrorsByShowingAlertViewModifier())
    }
}
