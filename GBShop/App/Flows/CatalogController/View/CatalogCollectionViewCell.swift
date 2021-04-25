//
//  CatalogCollectionViewCell.swift
//  GBShop
//
//  Created by Александр Ипатов on 15.03.2021.
//

import UIKit
import Kingfisher

class CatalogCollectionViewCell: UICollectionViewCell {

    static let reuseId: String = "CatalogCollectionViewCell"
    // MARK: - Subviews

    private(set) lazy var labelStackView = UIStackView(arrangedSubviews: [priceLabel,
                                                                          titleLabel],
                                                       axis: .vertical,
                                                       spacing: 0)
    private(set) lazy var stackView = UIStackView(arrangedSubviews: [
                                                    productImageView,
                                                    labelStackView
                                                    ],
                                                  axis: .vertical,
                                                  spacing: 1)

    private(set) lazy var productImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.layer.cornerRadius =  7
        img.contentMode = .scaleAspectFit
        return img
    }()
    private(set) lazy var priceLabel = UILabel(text: "", font: .priceFont(), numberOfLines: 1)
    private(set) lazy var titleLabel = UILabel(text: "", font: .infoTextFont(), numberOfLines: 2)

    private(set) lazy var addToBasketButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0,
                                            width: 50,
                                            height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        button.setImage(UIImage(systemName: "cart.badge.plus", withConfiguration: boldConfig), for: .normal)
        return button
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupLayer()
    }
     override func layoutSubviews() {
        super.layoutSubviews()
        updateContentStyle()
    }

    override func prepareForReuse() {
        self.productImageView.kf.cancelDownloadTask()
    }
     // MARK: - Methods

    private func updateContentStyle() {
        let isHorizontalStyle = bounds.width > 2 * bounds.height
        let oldAxis = stackView.axis
        let newAxis: NSLayoutConstraint.Axis = isHorizontalStyle ? .horizontal : .vertical
        guard oldAxis != newAxis else { return }

        stackView.axis = newAxis
        stackView.spacing = isHorizontalStyle ? 4 : 1
        priceLabel.textAlignment = isHorizontalStyle ? .left : .center
        titleLabel.textAlignment = isHorizontalStyle ? .left : .center
        let fontTransform: CGAffineTransform = isHorizontalStyle ? .identity : CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(withDuration: 0.3) {
            self.priceLabel.transform = fontTransform
            self.layoutIfNeeded()
        }
    }

    func configure(with cellModel: CatalogCellModel) {
        self.titleLabel.text = cellModel.title
        self.priceLabel.text = cellModel.price + " p"
        self.productImageView.kf.setImage(with: URL(string: cellModel.productImage ?? ""))
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
    private func setupUI() {

        contentView.addSubview(stackView)
        contentView.addSubview(addToBasketButton)
        NSLayoutConstraint.activate([
            addToBasketButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            addToBasketButton.rightAnchor.constraint(equalTo: contentView.rightAnchor , constant: -5),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),

            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor),
            titleLabel.heightAnchor.constraint(equalTo: labelStackView.heightAnchor, multiplier: 0.5)
])
    }
}
