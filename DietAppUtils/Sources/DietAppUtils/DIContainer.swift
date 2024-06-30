//
//  DIContainer.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 29/06/2024.
//
//  Based on: https://www.avanderlee.com/swift/dependency-injection/
//
//  InjectedValues[\.networkProvider] = MockedNetworkProvider()
//  classInstace.networkProvider = NetworkProvider()

import Foundation

public protocol InjectionKey {

    associatedtype Value

    static var currentValue: Self.Value { get set }
}

public struct DIContainer {
    
    private static var current = DIContainer()
    
    public static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    public static subscript<T>(_ keyPath: WritableKeyPath<DIContainer, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
public struct Inject<T> {
    private let keyPath: WritableKeyPath<DIContainer, T>
    public var wrappedValue: T {
        get { DIContainer[keyPath] }
        set { DIContainer[keyPath] = newValue }
    }
    
    public init(_ keyPath: WritableKeyPath<DIContainer, T>) {
        self.keyPath = keyPath
    }
}
