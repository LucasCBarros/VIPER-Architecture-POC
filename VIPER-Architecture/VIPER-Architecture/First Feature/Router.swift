//
//  Router.swift
//  VIPER-Architecture
//
//  Created by Lucas C Barros on 2023-06-18.
//

import UIKit

// Ojbect
// Entry point for the VIPER module

/// Create a typealias to help with the entrypoint
typealias EntryPoint = AnyView & UIViewController

/// Let's start with Router since it setups up our entire pattern
// Starting with the protocol
protocol AnyRouter { // Can be just Router too
    
    // This is how we are going to tell our AppDelegate what the entryPoint of our actual aplication is
    var entry: EntryPoint? { get }
    
    // Can call Create() or Start()
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        // Assign VIP
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
//        interactor.getUsers() // Can be done here after instantiated but it's not the Routers job to do these calls
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
