//
//  MainNavigationController.swift
//  LoginGuide
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let defaults = UserDefaults()
        if defaults.isLoggedIn()
        {
            let homeController = HomeController()
            viewControllers = [homeController]
        }
        else
        {
            perform(#selector(ShowLoginController), with: nil, afterDelay:0.01)
        }
    }
    @objc func ShowLoginController()
    {
        let loginController = LoginController()
        self.present(loginController, animated: true) {
            
        }
    }
 
}
