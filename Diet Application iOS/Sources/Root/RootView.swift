//
//  RootView.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var viewModel = RootViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                Text("loading")
            case .login:
                Button("login") {
                    viewModel.onLoginButtonTap()
                }
            case .authenticated:
                Button("logout") {
                    viewModel.onLogoutButtonTap()
                }
            case .error:
                Text("error")
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }
}
