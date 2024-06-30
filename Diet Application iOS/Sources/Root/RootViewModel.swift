//
//  RootViewModel.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

import DietAppService
import DietAppUtils
import SwiftUI

@Observable
final class RootViewModel: ObservableObject {
    
    @ObservationIgnored
    @Inject(\.authorization) private var authorization
    
    @ObservationIgnored
    @Inject(\.authTokenStore) private var authTokenStore
    
    enum State {
        case loading, login, authenticated, error
    }
    
    private(set) var state: State = .loading
    
    func onAppear() async {
        
        if let _ = authTokenStore.getAuthToken() {
            setState(to: .authenticated)
        } else {
            setState(to: .login)
        }
    }
    
    func onLoginButtonTap() {
        setState(to: .loading)
        
        Task {
            do {
                try await authorization.authorize(using: .init(login: "aaa", password: "aaa"))
            } catch {
                print(error.localizedDescription)
            }
            
            setState(to: .authenticated)
        }
    }
    
    func onLogoutButtonTap() {
        authTokenStore.clearAuthToken()
        setState(to: .loading)
    }
    
    private func setState(to newState: State) {
        withAnimation {
            state = newState
        }
    }
}
