//
//  ImagesViewModel.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import Foundation

protocol ImagesViewModelProtocol {
    init(delegate: ImagesViewModelOutputProtocol,
         service: ImageServiceProtocol)
    func fetchData()
    func refreshData()
    func numberOfRows() -> Int
    func item(at indexPath: IndexPath) -> ImageCellViewModelProtocol?
    func loadMoreImages(indexPath: IndexPath)
    var isLoading: Bool { get }
}

protocol ImagesViewModelOutputProtocol: AnyObject {
    func reloadData(indexPaths: [IndexPath])
    func showHideLoading()
    func showError(message: String)
}

final class ImagesViewModel: ImagesViewModelProtocol {
    
    private weak var delegate: ImagesViewModelOutputProtocol?
    private let service:ImageServiceProtocol
    private var images = [ImageData]()
    private var cells = [ImageCellViewModel]()
    private var page: Int = 1
    var isLoading: Bool = false
    
    required init(delegate: ImagesViewModelOutputProtocol,
                  service: ImageServiceProtocol) {
        self.delegate = delegate
        self.service = service
    }
    
    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        delegate?.showHideLoading()
        Task {
            do {
                let model = try await service.getImages(router: .getPhotos(page))
                if let error = model.error {
                    isLoading = false
                    await MainActor.run {
                        delegate?.showHideLoading()
                        delegate?.showError(message: error)
                    }
                } else {
                    isLoading = false
                    let oldCount = self.cells.count
                    self.cells.append(contentsOf: model.images.compactMap({ .init(image: $0)}))
                    await MainActor.run {
                        var indexPaths = [IndexPath]()
                        for i in oldCount..<cells.count {
                            indexPaths.append(IndexPath(item: i, section: 0))
                        }
                        delegate?.reloadData(indexPaths: indexPaths)
                        delegate?.showHideLoading()
                    }
                }
            } catch {
                isLoading = false
                delegate?.showHideLoading()
                delegate?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func refreshData() {
        cells.removeAll()
        fetchData()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func item(at indexPath: IndexPath) -> ImageCellViewModelProtocol? {
        return cells[indexPath.row]
    }
    
    func loadMoreImages(indexPath: IndexPath) {
        if indexPath.row == cells.count - 1 {
            page += 1
            fetchData()
        }
    }
}
