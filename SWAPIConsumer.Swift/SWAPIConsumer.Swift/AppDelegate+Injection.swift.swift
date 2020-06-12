//
//  AppDelegate+Injection.swift.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 12/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { () -> DatabaseService? in
            return DatabaseService();
        }
        
        //ViewModels
        register { () -> SearchMoviesViewModel? in
            return SearchMoviesViewModel();
        }
        register { () -> DashboardViewModel? in
            return DashboardViewModel();
        }
    }
}
