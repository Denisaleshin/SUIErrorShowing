//
//  TabView.swift
//  ErrorHandlingExamples
//
//  Created by Denis Aleshyn on 07/01/2024.
//

import SwiftUI

struct OptionsView: View {
    var body: some View {
        TabView {
            SheetErrorThrowingView()
                .tabItem {
                    Label("Sheet Error", systemImage: "")
                }
            AlertErrorTrowignView()
                .withErrorHandling()
                .tabItem {
                    Label("Alert Error", systemImage: "")
                }
        }
    }
}

#Preview {
    OptionsView()
}
