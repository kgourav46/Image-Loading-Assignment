//
//  ImageCollectionViewCell.swift
//  Image Loading Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(viewModel: ImageCellViewModelProtocol?) {
        if let url = viewModel?.url {
            imageView.loadImage(from: url)
        }
    }
}

final class CollectionViewFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
