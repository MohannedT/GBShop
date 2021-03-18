//
//  AuthViewController.swift
//  task7
//
//  Created by Александр Ипатов on 09.03.2021.
//

import UIKit
import Lottie

class AuthView: UIView {
    // MARK: - Subviews
    let animationView = AnimationView(name: "loginLottie")

    let animationLoaderView = LoadingView()

    let userNameImageView = UIImageView(systemImageName: "person")
    let passwordImageView = UIImageView(systemImageName: "lock")

    let signUpLabel = UILabel(text: "Don't have an account yet?", font: .infoTextFont())

    let userNameTextField = UITextField(placeholder: "User name")
    let passwordTextField = UITextField(placeholder: "Password", isSecure: true)

    let loginButton = UIButton(title: "Log in", titleColor: .black, backgroundColor: .lightText, isShadow: true)
    let signUpButton = UIButton(title: "Sign Up", titleColor: .darkGray, backgroundColor: .clear)

    let logoView = LogoView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        animationSetup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup constraints
extension AuthView {
    private func animationSetup() {
        animationView.animationSpeed = 1
        animationView.loopMode = .loop
    }
    private func setupUI() {
        let userNameStackView = UIStackView(arrangedSubviews: [userNameImageView,
                                                               userNameTextField],
                                            axis: .horizontal,
                                            spacing: 5)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordImageView,
                                                               passwordTextField],
                                            axis: .horizontal,
                                            spacing: 5)
        let stackView = UIStackView(arrangedSubviews: [userNameStackView,
                                                       passwordStackView],
                                    axis: .vertical,
                                    spacing: 30)
        let signUpStackView = UIStackView(arrangedSubviews: [signUpLabel,
                                                             signUpButton],
                                          axis: .vertical,
                                          spacing: 0)
        backgroundColor = .white

        addSubview(logoView)
        addSubview(stackView)
        addSubview(loginButton)
        addSubview(signUpStackView)
        addSubview(animationView)
        addSubview(animationLoaderView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        // loaderView.isHidden = true
        NSLayoutConstraint.activate([
            logoView.heightAnchor.constraint(equalToConstant: 70),
            logoView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            logoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),

            animationView.widthAnchor.constraint(equalTo: widthAnchor),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor, multiplier: 0.5),
            animationView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -10),
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),

            userNameImageView.widthAnchor.constraint(equalTo: userNameTextField.heightAnchor),
            userNameImageView.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor),
            passwordImageView.widthAnchor.constraint(equalTo: userNameTextField.heightAnchor),
            passwordImageView.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor),

            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            loginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5),
            loginButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

            signUpStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            signUpStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            animationLoaderView.topAnchor.constraint(equalTo: topAnchor),
            animationLoaderView.widthAnchor.constraint(equalTo: widthAnchor),
            animationLoaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationLoaderView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
