//
//  DependencyContainer.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation

final class DependencyContainer {
    
    private static var cache: [String: Any] = [:]
    private static var generators: [String: () -> Any] = [:]
    
    static func register<Service>(type: Service.Type,
                                  as dependencyType: DependencyType = .automatic,
                                  _ factory: @autoclosure @escaping () -> Service
    ) {
        generators[String(describing: type.self)] = factory
        
        if dependencyType == .singleton {
            cache[String(describing: type.self)] = factory()
        }
    }
    
    static func resolve<Service>(_ type: Service.Type,
                                 as dependencyType: DependencyType = .automatic
    ) -> Service? {
        let key = String(describing: type.self)
        switch dependencyType {
        case .singleton:
            if let cachedService = cache[key] as? Service {
                return cachedService
            } else {
                fatalError("\(String(describing: type.self)) is not registeres as singleton")
            }
            
        case .automatic:
            if let cachedService = cache[key] as? Service {
                return cachedService
            }
            fallthrough
            
        case .newInstance:
            if let service = generators[key]?() as? Service {
                cache[String(describing: type.self)] = service
                return service
            } else {
                return nil
            }
        }
    }
}
