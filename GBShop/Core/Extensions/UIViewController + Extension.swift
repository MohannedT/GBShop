//
//  UIViewController + Extension.swift
//  GBShop
//
//  Created by Александр Ипатов on 11.03.2021.
//

import UIKit

extension UIViewController {
    func showAlert(needСancellation: Bool = false,
                   with title: String,
                   and message: String,
                   completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        if needСancellation {
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            alertController.addAction(cancelAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView,
                                                        cellType: T.Type,
                                                        with value: U,
                                                        for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId,
                                                            for: indexPath) as? T else { fatalError() }
        cell.configure(with: value)
        return cell
    }
    func secureCreditCard(creditCardNumber: String) -> String {
        String("***" + creditCardNumber.dropFirst(13))
    }
}
