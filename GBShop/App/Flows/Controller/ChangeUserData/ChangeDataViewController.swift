//
//  ChangeDataViewController.swift
//  GBShop
//
//  Created by Александр Ипатов on 11.03.2021.
//

import UIKit

class ChangeDataViewController: UIViewController {

    private let authService: AuthService
    var user: User

    private lazy var userGender = user.gender
    private var changeDataView: ChangeDataView {
        self.view as! ChangeDataView
    }

    // MARK: - Init
    init(authService: AuthService, user: User) {
        self.authService = authService
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = ChangeDataView()
    }
    override func viewDidLoad() {
        self.navigationItem.title = "User info"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        setupUserData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        changeDataView.addGestureRecognizer(tapGesture)
        addButtonTargets()
    }
    // MARK: - Methods
    private func addButtonTargets() {
        changeDataView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        changeDataView.genderSegControl.addTarget(self, action: #selector(genderSegTapped), for: .valueChanged)

    }
    private func backToLogIn() {
        self.dismiss(animated: true, completion: nil)
    }
    private func tryToSaveInfo() {
        authService.changeUserData(idUser: user.idUser, userName: changeDataView.userNameTextField.text,
                      password: changeDataView.passwordTextField.text,
                      email: changeDataView.emailTextField.text,
                      conconfirmPassword: changeDataView.confirmPasswordTextField.text,
                      gender: userGender,
                      creditCard: changeDataView.creditCardTextField.text,
                      bio:  changeDataView.bioTextField.text) { (result) in
            switch result {
            case .success:
                // MARK: Разобраться с потоками
                DispatchQueue.main.async {
                    self.showAlert(with: "Welcome!",
                                   and: "Data changed successfully")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                self.showAlert(with: "Oops!",
                               and: error.localizedDescription)
            }
            }
        }
    }

    // MARK: - keyboard methods
        @objc func keyboardWillShown(notification: Notification) {
              let info = notification.userInfo! as NSDictionary
              let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
              let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0)
            changeDataView.scrollView.contentInset = contentInsets
            changeDataView.scrollView.scrollIndicatorInsets = contentInsets
          }
        @objc func hideKeyboard() {
            changeDataView.endEditing(true)
         }
        @objc func keyboardWillHide(notification: Notification) {
            changeDataView.scrollView.contentInset = UIEdgeInsets.zero
            changeDataView.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        }
    }
// MARK: - Actions
extension ChangeDataViewController {
    @objc private func saveButtonTapped() {
        tryToSaveInfo()
    }
    @objc private func genderSegTapped() {
        switch changeDataView.genderSegControl.selectedSegmentIndex {
        case 0: userGender = "m"
        case 1: userGender = "w"
        default:
            break
        }
}
}
// MARK: - SetupTextFieldsData
extension ChangeDataViewController {
    private func setupUserData() {
        changeDataView.userNameTextField.text = user.username
        changeDataView.emailTextField.text = user.email
        changeDataView.genderSegControl.selectedSegmentIndex = userGender == "m" ? 0 : 1
        changeDataView.creditCardTextField.text = user.creditCard
        changeDataView.bioTextField.text = user.bio
    }
}
