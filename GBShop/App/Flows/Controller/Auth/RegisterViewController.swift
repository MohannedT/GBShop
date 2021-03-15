//
//  RegisterViewController.swift
//  GBShop
//
//  Created by Александр Ипатов on 11.03.2021.
//
import UIKit

class RegisterViewController: UIViewController {

    let authService: AuthService

    var user: User?

    private var userGender: String?

    private var registerView: RegisterView {
        view as! RegisterView
    }

    override func loadView() {
        super.loadView()
        self.view = RegisterView()
    }
    init(authService: AuthService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonTargets()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        registerView.addGestureRecognizer(tapGesture)
    }
    // MARK: - Methods
    private func addButtonTargets() {
        registerView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        registerView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        registerView.genderSegControl.addTarget(self, action: #selector(genderSegTapped), for: .valueChanged)
    }
    private func backToLogIn() {
        self.dismiss(animated: true, completion: nil)
    }
    private func tryToSignUp() {
        authService.register(userName: registerView.userNameTextField.text,
                      password: registerView.passwordTextField.text,
                      email: registerView.emailTextField.text,
                      conconfirmPassword: registerView.confirmPasswordTextField.text,
                      gender: userGender,
                      creditCard: registerView.creditCardTextField.text,
                      bio:  registerView.bioTextField.text) { (result) in
            switch result {
            case .success(let result):
                self.user = result
                // MARK: Разобраться с потоками
                DispatchQueue.main.async {
                    self.showAlert(with: "Welcome!", and: "\(result.username)") {
                        self.presentNextVC()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                self.showAlert(with: "Oops!", and: error.localizedDescription)
            }
            }
        }
    }
    private func presentNextVC() {
        guard let user = user else { showAlert(with: "Oops!",
                                               and: AuthError.unknownError.localizedDescription)
            return
        }
        let tabBarVC = MainTabBarController(authService: authService, user: user)
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
    // MARK: - keyboard methods
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0)
        registerView.scrollView.contentInset = contentInsets
        registerView.scrollView.scrollIndicatorInsets = contentInsets
    }
    @objc func hideKeyboard() {
        registerView.endEditing(true)
    }
    @objc func keyboardWillHide(notification: Notification) {
        registerView.scrollView.contentInset = UIEdgeInsets.zero
        registerView.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
// MARK: - Actions
extension RegisterViewController {

    @objc private func signUpButtonTapped() {
        tryToSignUp()
    }
    @objc private func backButtonTapped() {
        backToLogIn()
    }
    @objc private func genderSegTapped() {
        switch registerView.genderSegControl.selectedSegmentIndex {
        case 0: userGender = "m"
        case 1: userGender = "w"
        default:
            break
        }
    }
}
