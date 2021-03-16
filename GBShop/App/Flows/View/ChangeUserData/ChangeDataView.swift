//
//  ChangeDataViewController.swift
//  task7
//
//  Created by Александр Ипатов on 08.03.2021.
//
//
import UIKit

class ChangeDataView: UIView {

    // MARK: - Subviews

    let genderSegControl = UISegmentedControl(items: ["Male", "Female"])
    let userNameImageView = UIImageView(systemImageName: "person")
    let emailImageView = UIImageView(systemImageName: "at")
    let passwordImageView = UIImageView(systemImageName: "lock")
    let confirmRasswordImageView = UIImageView(systemImageName: "lock.fill")
    let creditCardImageView =  UIImageView(systemImageName: "creditcard")
    let bioImageView = UIImageView(systemImageName: "quote.bubble")

    let userNameTextField = UITextField(isChangeData: true)
    let emailTextField = UITextField(isChangeData: true)
    let passwordTextField = UITextField(isSecure: true, isChangeData: true)
    let confirmPasswordTextField = UITextField(isSecure: true, isChangeData: true)
    let creditCardTextField = UITextField(isSecure: true, isChangeData: true)
    let bioTextField = UITextField(isChangeData: true)

    let scrollView = UIScrollView(isScrollEnabled: true)

    let saveButton = UIButton(title: "Save", titleColor: .black, backgroundColor: .lightText, isShadow: true)

    let infoLabel = UILabel(text: "To change information about yourself, just correct it and save your changes",
                            font: .infoTextFont())

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
extension ChangeDataView {
    private func layoutForImages(imageVeiws: [UIImageView]) {
        imageVeiws.forEach({ (image) in
            NSLayoutConstraint.activate([
                image.widthAnchor.constraint(equalTo: userNameTextField.heightAnchor),
                image.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor)
            ])
        })
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
        addSubview(infoLabel)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(saveButton)
        // MARK: Убрать хардкрод с высоты скрол вью
        scrollView.contentSize = CGSize(width: frame.width - 20, height: 450)
        layoutForImages(imageVeiws: [userNameImageView,
                                     passwordImageView,
                                     confirmRasswordImageView,
                                     emailImageView,
                                     creditCardImageView,
                                     bioImageView])
        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: -10),
            infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            infoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            scrollView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),

            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),

            saveButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5),
            saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}
