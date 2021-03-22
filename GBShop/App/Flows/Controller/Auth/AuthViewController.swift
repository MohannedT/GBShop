//
//  AuthViewController.swift
//  GBShop
//
//  Created by Александр Ипатов on 11.03.2021.
//

import UIKit

class AuthViewController: UIViewController {

    var authService: AuthService
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        authView.addGestureRecognizer(tapGesture)
        addButtonTargets()
    }
    init(authService: AuthService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let registerVC = RegisterViewController(authService: authService)
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true, completion: nil)
    }
    private func tryToLogIn() {
        authService.login(userName: authView.userNameTextField.text,
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
        let changeDataVC = MainTabBarController(authService: authService, user: user)
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
