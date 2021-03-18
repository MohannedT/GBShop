//
//  AuthViewController.swift
//  GBShop
//
//  Created by Александр Ипатов on 11.03.2021.
//

import UIKit

class AuthViewController: UIViewController {
    let auth = AuthService()
    var user: User?
    private  var authView: AuthView {
        view as! AuthView
    }
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = AuthView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        authView.passwordTextField.text = "@!awdw1ivanIvanov"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        authView.addGestureRecognizer(tapGesture)
        addButtonTargets()
    }
    // MARK: - Methods
    private func showLoader() {
        authView.animationLoaderView.showLoadingView()
    }
    private func hideLoader() {
        authView.animationLoaderView.hideLoadingView()
    }
    private func addButtonTargets() {
        authView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        authView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    private func presentSignUp() {
        let registerVC = RegisterViewController(authService: auth)
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true, completion: nil)
    }
    private func tryToLogIn() {
        auth.login(userName: authView.userNameTextField.text,
                   password: authView.passwordTextField.text) { (result) in
            switch result {
            case .success(let user):
                self.user = user
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.showAlert(with: "Welcome!",
                                   and: "\(user.username)") {
                        self.presentNextVC()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.showAlert(with: "Oops!",
                                   and: error.localizedDescription)
                }
            }
        }
    }
    private func presentNextVC() {
        guard let user = user else { showAlert(with: "Oops!",
                                               and: AuthError.unknownError.localizedDescription)
            return
        }
        let changeDataVC = MainTabBarController(authService: auth, user: user)
        changeDataVC.modalPresentationStyle = .fullScreen
        present(changeDataVC, animated: true, completion: nil)
    }

    // MARK: - keyboard methods
    @objc func hideKeyboard() {
        authView.endEditing(true)
    }
}
// MARK: - Actions
extension AuthViewController {
    @objc private func signUpButtonTapped() {
        presentSignUp()
    }
    @objc private func loginButtonTapped() {
        showLoader()
        tryToLogIn()
    }
}

// MARK: - SwiftUI
import SwiftUI

struct AuthV2VCProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView().previewDevice("iPhone 12 Pro Max").edgesIgnoringSafeArea(.all)
            ContainerView().previewDevice("iPhone 8").edgesIgnoringSafeArea(.all)
        }
    }
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = AuthViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthV2VCProvider.ContainerView>)
        -> AuthViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: AuthV2VCProvider.ContainerView.UIViewControllerType,
                                    context: UIViewControllerRepresentableContext<AuthV2VCProvider.ContainerView>) {
        }
    }
}
