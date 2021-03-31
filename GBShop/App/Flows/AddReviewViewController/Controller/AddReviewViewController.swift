//
//  AddReviewViewController.swift
//  GBShop
//
//  Created by Александр Ипатов on 26.03.2021.
//

import UIKit

class AddReviewViewController: UIViewController {
    var user: User
    var requestFactory: RequestFactory
    var analytics: FirebaseAnalytics

    private  var addReviewView: AddReviewView {
        view as! AddReviewView
    }
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = AddReviewView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addReviewView.addGestureRecognizer(tapGesture)
        addButtonTargets()
    }
    // MARK: - Init
    init(user: User, requestFactory: RequestFactory, analytics: FirebaseAnalytics) {
        self.analytics = analytics
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    private func addButtonTargets() {
        addReviewView.addReviewButton.addTarget(self, action: #selector(addReviewButtonTapped), for: .touchUpInside)
    }

    private func tryToAddReview() {
        guard let reviewText = addReviewView.reviewTextView.text, reviewText != "" else {
            self.showAlert(with: "Oops!", and: AuthError.notFilled.localizedDescription)
            return}
        let addReviewFactory = requestFactory.makeAddReviewRequestFactory()
        addReviewFactory.addReview(idUser: user.idUser, text: reviewText) { (responce) in
            switch responce.result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.analytics.addReview()
                    self.showAlert(with : "Thanks", and: result.userMessage)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(with:"Oops!", and: error.localizedDescription)
                }
            }

        }

    }
//    private func setUpReview() {
//        if addReviewView.ratingView.starButtonRating1.isSelected {
//            print(addReviewView.ratingView.starButtonRating1)
//        }
//    }
    // MARK: - keyboard methods
    @objc func hideKeyboard() {
        addReviewView.endEditing(true)
    }
}
// MARK: - Actions
extension AddReviewViewController {
    @objc private func addReviewButtonTapped() {
        tryToAddReview()
    }

}
