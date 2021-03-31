//
//  DetailCatalogDescriptionCell.swift
//  GBShop
//
//  Created by Александр Ипатов on 18.03.2021.
//
import UIKit
import Kingfisher

class DescriptionDetailCatalogCell: UICollectionViewCell, SelfConfiguringCell {

    static var reuseId: String = "DetailCatalogDescriptionCell"

    private(set) lazy var priceLabel = UILabel(text: "", font: .productInfoPriceFont())
    private(set) lazy var nameLabel = UILabel(text: "", font: .productInfoNameFont())
    private(set) lazy var descriptionLabel = UILabel(text: "", font: .productInfoDescriptionFont())
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        additionalLabelsParameters()
    }

    private func additionalLabelsParameters() {
        descriptionLabel.textAlignment = .left
        priceLabel.textColor = .systemGray
    }

    func configure<U>(with value: U) where U : Hashable {
        guard let product: ProductWithDescription = value as? ProductWithDescription else { return }
        nameLabel.text = product.productName
        descriptionLabel.text = product.productDescription
        priceLabel.text = String("\(product.productPrice) pуб.")

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup constraints

    private func setupConstraints() {
        contentView.addSubview(priceLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])

    }
}
