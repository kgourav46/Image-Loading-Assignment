//
//  ViewController.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import UIKit

final class ImagesViewController: BaseViewController {
    
    static var storyBoardId: String = ViewControllerId.imagesViewController
    static var storyBoardName: String = Storyboard.main
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: ImagesViewModelProtocol?
    let refreshControl = UIRefreshControl()
    private let footerView = UIActivityIndicatorView(style: .medium)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.tintColor = .black
        collectionView.register(cellClass: ImageCollectionViewCell.self)
        collectionView.register(CollectionViewFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 50)
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        viewModel?.fetchData()
    }
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        viewModel?.refreshData()
    }
}

extension ImagesViewController: ImagesViewModelOutputProtocol {
    func reloadData(indexPaths: [IndexPath]) {
        collectionView.insertItems(at: indexPaths)
    }
    
    func showHideLoading() {
        guard let isLoading = viewModel?.isLoading, isLoading else {
            footerView.isHidden = true
            footerView.stopAnimating()
            return
        }
        footerView.isHidden = false
        footerView.startAnimating()
    }
    
    func showError(message: String) {
        showAlert(message: message)
    }
}

extension ImagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel else { return 0 }
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel else { return UICollectionViewCell() }
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(viewModel: viewModel.item(at: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel?.loadMoreImages(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            footer.addSubview(footerView)
            footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
        }
        return UICollectionReusableView()
    }
}

extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - 42) / 2
        return CGSize(width: width, height: width)
    }
}
