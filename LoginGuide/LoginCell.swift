//
//  LoginCell.swift
//  LoginGuide
//
//  Created by Sherif  Wagih on 9/1/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    let logoImageView:UIImageView = {
        let image = UIImage(named: "logo")
        let imagev = UIImageView(image:image)
        return imagev
    }()
    let mailTextField : leftPaddedTextField = {
        let textField = leftPaddedTextField()
        textField.placeholder = "Enter e-mail"
        textField.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
        textField.minimumFontSize = 18
        textField.layer.borderWidth = 2
        textField.keyboardType = .emailAddress
        return textField
    }()
    let passwordTextField : leftPaddedTextField = {
        let textField = leftPaddedTextField()
        textField.placeholder = "Enter Password"
        textField.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
        textField.minimumFontSize = 18
        textField.layer.borderWidth = 2
        textField.keyboardType = .emailAddress
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton : UIButton = {
        let btn = UIButton(type:.system)
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = .orange
        btn.setTitleColor(.white, for: .normal)
       
        return btn
    }()
    @objc func handleLogin()
    {
        delegate?.finishLoggingIn()
    }
    weak var delegate:LoginControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        setupAutoLayout()
    }
    func setupAutoLayout()
    {
        backgroundColor = .white
        addSubview(logoImageView)
        addSubview(mailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: centerYAnchor,constant:-210),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant:180),
            logoImageView.heightAnchor.constraint(equalToConstant: 180),
            //logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            //logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        logoImageView.backgroundColor = .green
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                mailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant:20),
                //mailTextField.widthAnchor.constraint(equalTo: logoImageView.widthAnchor),
                //mailTextField.heightAnchor.constraint(equalToConstant: 40),
                mailTextField.heightAnchor.constraint(equalToConstant: 40),
                mailTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant:35),
                mailTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant:-35)
                
            ]
        )
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor,constant:20),
                passwordTextField.heightAnchor.constraint(equalToConstant: 40),
                passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant:35),
                passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant:-35)
                
            ]
        )
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant:20),
                loginButton.heightAnchor.constraint(equalToConstant: 40),
                loginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant:35),
                loginButton.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor,constant:-35)
                
            ]
        )
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class leftPaddedTextField:UITextField
{
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y , width: bounds.width - 10 , height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y , width: bounds.width - 10 , height: bounds.height)
    }
}
