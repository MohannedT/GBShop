//
//  CatalogCollectionViewController.swift
//  GBShop
//
//  Created by Александр Ипатов on 15.03.2021.
//

import UIKit

class CatalogCollectionViewController: UIViewController {
    var user: User
    var requestFactory: RequestFactory
    private var catalogView: CatalogView {
        view as! CatalogView
    }
    private var selectedStyle: PresentationStyle = .table {
        didSet { updatePresentationStyle() }
    }
    let searchController = UISearchController(searchResultsController: nil)
    private(set) lazy var styleDelegates: [PresentationStyle: CollectionViewSelectableItemDelegate] = {
        let result: [PresentationStyle: CollectionViewSelectableItemDelegate] = [
            .table: TabledContentCollectionViewDelegate(),
            .defaultGrid: DefaultGriddedContentCollectionViewDelegate()
        ]
        result.values.forEach {
            $0.didSelectItem = { item in
                self.presentNextVC(item: item)
            }
        }
        return result
    }()
    private var products =  [Product]() {
        didSet {
            DispatchQueue.main.async {
                self.catalogView.collectionView.reloadData()
                self.catalogView.animationView.stop()
                self.catalogView.animationView.isHidden = true
            }

        }
    }
    private var filteredProducts =  [Product]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }

    // MARK: - Init
    init(user: User, requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
  override func loadView() {
        super.loadView()
        self.view = CatalogView()
    }
   override func viewDidLoad() {
        super.viewDidLoad()
    self.catalogView.animationView.play()
    self.getCatalog()
    self.navigationSetUp()
    self.setupSearchBar()
    self.setupCollectionView()
    self.updatePresentationStyle()

    }
    // MARK: - Methods

    private func setupCollectionView() {
        catalogView.collectionView.register(CatalogCollectionViewCell.self,
                                            forCellWithReuseIdentifier: CatalogCollectionViewCell.reuseId)
        catalogView.collectionView.dataSource = self
        catalogView.collectionView.contentInset = .zero
    }
    private func presentNextVC(item: IndexPath) {
    }
    private func getCatalog() {
        let catalogFactory = requestFactory.makeCatalogRequestFactory()
        catalogFactory.getCatalog(pageNumber: 1, idCategory: 1) { (response) in
            switch response.result {
            case .success(let catalog):
                    self.products = catalog.products
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(with: "Oops!", and: error.localizedDescription)
                }
            }
        }

    }
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
       searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    private func updatePresentationStyle() {
        navigationItem.rightBarButtonItem?.tintColor = .black
        catalogView.collectionView.delegate = styleDelegates[selectedStyle]
        catalogView.collectionView.performBatchUpdates({
            catalogView.collectionView.reloadData()
        }, completion: nil)
        navigationItem.rightBarButtonItem?.image = selectedStyle.buttonImage
    }
    private func navigationSetUp() {
        self.navigationItem.title = "Catalog"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: selectedStyle.buttonImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(changeContentLayout))
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    // MARK: - Actions
    @objc private func changeContentLayout() {
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: selectedStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        selectedStyle = allCases[nextIndex]
    }
}
// MARK: - UICollectionViewDataSource
extension CatalogCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.reuseId,
                                                            for: indexPath) as? CatalogCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product =  isFiltering ? filteredProducts[indexPath.row] : products[indexPath.row]
        let cellModel = CatalogCellModelFactory.cellModel(from: product)
        cell.configure(with: cellModel)
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltering ? filteredProducts.count : products.count
    }

}
// MARK: - UISearchResultsUpdating
extension CatalogCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    private func filterContentForSearchText(_ searchText: String) {
        filteredProducts = products.filter({(product: Product) -> Bool in
            return product.productName.lowercased().contains(searchText.lowercased())
        })
        catalogView.collectionView.reloadData()
    }
}
