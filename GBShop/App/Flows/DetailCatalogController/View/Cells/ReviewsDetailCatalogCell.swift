//
//  ReviewsDetailCatalogCell.swift
//  GBShop
//
//  Created by Александр Ипатов on 18.03.2021.
//

import UIKit
import Kingfisher

class ReviewsDetailCatalogCell: UICollectionViewCell, SelfConfiguringCell {

    static var reuseId: String = "ReviewsDetailCatalogCell"

    private(set) lazy var userNamelabel = UILabel(text: "", font: .priceFont(), textAlignment: .left)
    private(set) lazy var textLabel = UILabel(text: "", font: . infoTextFont(), textAlignment: .left)
    private(set) lazy var markLabel = UILabel(text: "", font: . infoTextFont())
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2
        additionalLabelParameters()
    }

    private func additionalLabelParameters() {
        markLabel.textColor = .darkGray
    }

    func configure<U>(with value: U) where U : Hashable {
        guard let review: Review = value as? Review else { return }
        userNamelabel.text = review.username
        textLabel.text = review.text
        markLabel.text = "\(review.productMark) / 10"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup constraints
    private func setupConstraints() {
        contentView.addSubview(markLabel)
        contentView.addSubview(userNamelabel)
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([

            userNamelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            userNamelabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            userNamelabel.widthAnchor.constraint(equalTo: contentView.widthAnchor , multiplier: 0.7),

            markLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            markLabel.leftAnchor.constraint(equalTo: userNamelabel.rightAnchor),
            markLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,  constant: -20),

            textLabel.topAnchor.constraint(equalTo: userNamelabel.bottomAnchor, constant: 10),
            textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])

    }
}
