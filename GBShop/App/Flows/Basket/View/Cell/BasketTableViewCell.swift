//
//  BasketTableViewCell.swift
//  GBShop
//
//  Created by Александр Ипатов on 23.03.2021.
//

import UIKit
import Kingfisher

class BasketTableViewCell: UITableViewCell, SelfConfiguringCell {

    static var reuseId: String = "BasketCollectionViewCell"

    private(set) lazy var titleLabel = UILabel(text: "", font: .infoTextFont(), numberOfLines: 2, textAlignment: .left)
    private(set) lazy var priceLabel = UILabel(text: "", font: .priceFont(), textAlignment: .left)
    private(set) lazy var productImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.layer.cornerRadius =  7
        img.contentMode = .scaleAspectFit
        return img
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
        self.setupLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupConstraints()
    }

    func configure<U>(with value: U) where U : Hashable {
        guard let product: Product = value as? Product else { return }
        titleLabel.text = product.productName
        priceLabel.text = "\(product.price) руб."
        productImageView.kf.setImage(with: URL(string: product.photo))
    }

    // MARK: - setupUI
    private func setupLayer() {
        backgroundColor = .white
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius =  7
        self.layer.shadowRadius = 7
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.5
        self.layer.borderColor = UIColor.black.cgColor
    }
    private func setupConstraints() {
        contentView.addSubview(productImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([

            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            productImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 10),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor),

            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            priceLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 5),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),

            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
