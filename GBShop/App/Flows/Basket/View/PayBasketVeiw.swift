//
//  PayBasketVeiw.swift
//  GBShop
//
//  Created by Александр Ипатов on 21.03.2021.
//

import UIKit

class PayBasketVeiw : UIView {

    private(set) lazy var priceLabel = UILabel(text: "", font: .productInfoPriceFont(), numberOfLines: 1, textAlignment: .center)
    private(set) lazy var payButton = UIButton(title: "Оплатить ",
                                               titleColor: .white,
                                               backgroundColor: UIColor(red: 0, green: 0, blue: 1, alpha: 0.5),
                                               cornerRadius: 10,
                                               font: .productInfoNameFont(),
                                               isShadow: true )
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupLayer()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setupUI
    private func setupLayer() {
        backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 7
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.5
        self.layer.borderColor = UIColor.black.cgColor
    }

    private func setupConstraints() {
         translatesAutoresizingMaskIntoConstraints = false
         self.addSubview(payButton)
        self.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            payButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            payButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            payButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            payButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),

        priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        priceLabel.rightAnchor.constraint(equalTo: payButton.leftAnchor, constant: 5)
         ])
     }
}
