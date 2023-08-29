//
//  MyCell.swift
//  ExDynamicHeight
//
//  Created by 김종권 on 2023/08/29.
//

import UIKit
import SnapKit
import Kingfisher

final class MyCell: UICollectionViewCell {
    private let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    var url: URL? {
        didSet {
            guard let url else { return }
            imageView.kf.setImage(with: url) { [weak self] result in
                guard case .success(let value) = result, let self else { return }
                imageView.snp.updateConstraints {
                    $0.height.equalTo(value.image.size.height).priority(999)
                }
                invalidateIntrinsicContentSize()
            }
            // TODO
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        url = nil
        imageView.image = nil
    }

    private func setupUI() {
        backgroundColor = .lightGray
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width).priority(999)
            $0.height.equalTo(50).priority(999)
        }
    }
}
