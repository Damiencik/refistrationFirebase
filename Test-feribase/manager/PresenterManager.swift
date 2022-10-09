//
//  PresenterManager.swift
//  Test-feribase
//
//  Created by Baxtiyor on 15/09/22.
//


import UIKit

class PresenterManager{
    static let shared = PresenterManager()
    
    private init() {}
    
    enum VC{
        case mainTabBarController
        case onboarding
    }
    
    func show(vc : VC){
        
        var viewController: UIViewController
        
        switch vc {
        case .mainTabBarController:
            viewController =  UIStoryboard(name: K.StoryboadrID.main , bundle: nil).instantiateViewController(withIdentifier: K.StoryboadrID.mainTabBarController)
        case .onboarding:
            viewController = UIStoryboard(name: K.StoryboadrID.main , bundle: nil).instantiateViewController(withIdentifier: K.StoryboadrID.onboardingViewController)
        }
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window{
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.25 , options: .transitionCrossDissolve, animations: nil, completion: nil )
        }
    }
}
