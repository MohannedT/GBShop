//
//  AddReviewView.swift
//  GBShop
//
//  Created by Александр Ипатов on 26.03.2021.
//

import UIKit

class AddReviewView: UIView {

    // MARK: - Subviews
    let scrollView = UIScrollView(isScrollEnabled: true)
    let reviewLabel = UILabel(text: "Advantages and disadvantages of the product:", font: .infoTextFont(), textAlignment: .center)

    private(set) lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.font = .infoTextFont()
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 0.5
        textView.sizeToFit()
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
       textView.layer.borderColor = UIColor.lightGray.cgColor

        return textView
    }()

    let addReviewButton = UIButton(title: "",
                             image: UIImage(systemName: "plus"),
                             backgroundColor: UIColor(red: 0, green: 0, blue: 1, alpha: 0.5),
                             cornerRadius: 25,
                             isShadow: true)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - Setup constraints
extension AddReviewView {

    private func setupUI() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(reviewLabel)
        scrollView.addSubview(reviewTextView)
        scrollView.addSubview(addReviewButton)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),

            reviewLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            reviewLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            reviewLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),

            reviewTextView.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: 20),
            reviewTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            reviewTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),

            addReviewButton.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 20),
            addReviewButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addReviewButton.widthAnchor.constraint(equalToConstant: 50),
            addReviewButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
