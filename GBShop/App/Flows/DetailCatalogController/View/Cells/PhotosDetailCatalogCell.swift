//
//  DetailCatalogPhotosCell.swift
//  GBShop
//
//  Created by Александр Ипатов on 18.03.2021.
//

import UIKit
import Kingfisher

class PhotosDetailCatalogCell: UICollectionViewCell, SelfConfiguringCell {

    static var reuseId: String = "DetailCatalogPhotosCell"

    private(set) lazy var productImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .white
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView

    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }

    func configure<U>(with value: U) where U : Hashable {
        guard  let productPhoto: String = value as? String else { return }
        productImageView.kf.setImage(with: URL(string: productPhoto))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup constraints

    private func setupConstraints() {
        contentView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalTo: widthAnchor),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor),
            productImageView.leftAnchor.constraint(equalTo: leftAnchor),
            productImageView.topAnchor.constraint(equalTo: topAnchor)

        ])

    }
}
