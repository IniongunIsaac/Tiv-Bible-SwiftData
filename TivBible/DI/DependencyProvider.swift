//
//  DependencyProvider.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation

@propertyWrapper
struct Provided<Dependency> {
    
    var dependency: Dependency
    
    init(as dependencyType: DependencyType = .newInstance) {
        guard let dependency = DependencyContainer.resolve(Dependency.self, as: dependencyType) else {
            fatalError("No dependency of type \(String(describing: Dependency.self)) registered!")
        }
        
        self.dependency = dependency
    }
    
    var wrappedValue: Dependency {
        get { self.dependency }
        mutating set { dependency = newValue }
    }
}
