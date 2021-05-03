//
//  AddNewReviewCell.swift
//  GBShop
//
//  Created by Александр Ипатов on 26.03.2021.
//

import UIKit

class AddNewReviewCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "AddNewReviewCell"

    private lazy var addNewReviewLabel = UILabel(text: "",
                                                 font: .productInfoDescriptionFont(),
                                                 textColor: .white,
                                                 textAlignment: .center)
    private lazy var plusView = UIImageView(systemImageName: "pencil", tintColor: .white)

    func configure<U>(with value: U) where U : Hashable {
        guard let user: User = value as? User else { return }
        addNewReviewLabel.text = "Hey, \(user.username)! do you want to write a review about the product?"
    }
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
        setupConstraints()
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup constraints

    private func setupConstraints() {
      contentView.addSubview(addNewReviewLabel)
      contentView.addSubview(plusView)

        NSLayoutConstraint.activate([
            addNewReviewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            addNewReviewLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
        addNewReviewLabel.rightAnchor.constraint(equalTo: plusView.leftAnchor, constant: 5),
            addNewReviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            plusView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            plusView.widthAnchor.constraint(equalToConstant: 40),
            plusView.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
}
