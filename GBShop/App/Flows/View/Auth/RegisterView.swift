//
//  RegisterViewController.swift
//  task7
//
//  Created by Александр Ипатов on 07.03.2021.
//

import UIKit

class RegisterView: UIView {

    // MARK: - Subviews
    let animationLoaderView = LoadingView()

    let genderSegControl = UISegmentedControl(items: ["Male", "Female"])
    let userNameImageView = UIImageView(systemImageName: "person")
    let emailImageView = UIImageView(systemImageName: "at")
    let passwordImageView = UIImageView(systemImageName: "lock")
    let confirmRasswordImageView = UIImageView(systemImageName: "lock.fill")
    let creditCardImageView =  UIImageView(systemImageName: "creditcard")
    let bioImageView = UIImageView(systemImageName: "quote.bubble")

    let userNameTextField = UITextField(placeholder: "Username")
    let emailTextField = UITextField(placeholder: "Email")
    let passwordTextField = UITextField(placeholder: "Password", isSecure: true)
    let confirmPasswordTextField = UITextField(placeholder: "Confirm password", isSecure: true)
    let creditCardTextField = UITextField(placeholder: "Credit card", isSecure: true)
    let bioTextField = UITextField(placeholder: "Hy! I want to buy something")

    let scrollView = UIScrollView(isScrollEnabled: true, accessibilityIdentifier: "scrollView")

    private(set) lazy var signUpButton = UIButton(title: "Sign Up",
                                                  titleColor: .black,
                                                  backgroundColor: .lightText,
                                                  isShadow: true)
    let backButton = UIButton(title: "Already have an account", titleColor: .darkGray, backgroundColor: .clear)

    let logoView = LogoView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup constraints
extension RegisterView {

    private func layoutForImages(imageVeiws: [UIImageView]) {
        imageVeiws.forEach({ (image) in
            NSLayoutConstraint.activate([
                image.widthAnchor.constraint(equalTo: userNameTextField.heightAnchor),
                image.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor)
            ])
        })
    }
    private func setupUI() {
        accessibilityIdentifier = "registerView"
        let userNameStackView = UIStackView(arrangedSubviews: [userNameImageView,
                                                               userNameTextField],
                                            axis: .horizontal,
                                            spacing: 5)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordImageView,
                                                               passwordTextField],
                                            axis: .horizontal,
                                            spacing: 5)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmRasswordImageView,
                                                                      confirmPasswordTextField],
                                                   axis: .horizontal,
                                                   spacing: 5)
        let emailStackView = UIStackView(arrangedSubviews: [emailImageView,
                                                            emailTextField],
                                         axis: .horizontal,
                                         spacing: 5)
        let bioStackView = UIStackView(arrangedSubviews: [bioImageView,
                                                          bioTextField],
                                       axis: .horizontal,
                                       spacing: 5)
        let creditCardStackView = UIStackView(arrangedSubviews: [creditCardImageView,
                                                                 creditCardTextField],
                                              axis: .horizontal,
                                              spacing: 5)
        let stackView = UIStackView(arrangedSubviews: [userNameStackView,
                                                       emailStackView,
                                                       passwordStackView,
                                                       confirmPasswordStackView,
                                                       genderSegControl,
                                                       creditCardStackView,
                                                       bioStackView],
                                    axis: .vertical,
                                    spacing: 30)
        backgroundColor = .white
        addSubview(logoView)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(signUpButton)
        addSubview(backButton)
        addSubview(animationLoaderView)
        // MARK: Убрать хардкрод с высоты скрол вью
        scrollView.contentSize = CGSize(width: frame.width - 20, height: 450)
        layoutForImages(imageVeiws: [userNameImageView,
                                     passwordImageView,
                                     confirmRasswordImageView,
                                     emailImageView,
                                     creditCardImageView,
                                     bioImageView])

        NSLayoutConstraint.activate([
            logoView.heightAnchor.constraint(equalToConstant: 70),
            logoView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            logoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),

            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            scrollView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),

            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),

            signUpButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            signUpButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5),
            signUpButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            backButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            backButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

            animationLoaderView.topAnchor.constraint(equalTo: topAnchor),
            animationLoaderView.widthAnchor.constraint(equalTo: widthAnchor),
            animationLoaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationLoaderView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
