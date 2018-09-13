//
//  HomeController.swift
//  LoginGuide
//
//  Created by Sherif  Wagih on 9/3/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class HomeController:UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "You are logged in!"
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home")
        view.addSubview(imageView)
        imageView.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target:self , action: #selector(logoutHandle))
    }
    @objc func logoutHandle()
    {
        let defaults = UserDefaults()
        defaults.setLoginValue(value:false)
        print(defaults.isLoggedIn())

        present(LoginController(),animated: true,completion: nil)
    }
}
