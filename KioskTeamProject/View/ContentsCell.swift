//
//  ContentsCell.swift
//  KioskTeamProject
//
//  Created by 전성진 on 7/2/24.
//

import UIKit

class ContentsCell: UICollectionViewCell {
    var book: Book?
    
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        guard let book = self.book else { return }
        titleImageView.image = book.image
        titleLabel.text = book.title
        priceLabel.text = "\(book.price) 원"
        
        [titleImageView, titleLabel, priceLabel].forEach {
            self.addSubview($0)
        }
        
        titleImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 80, height: 100))
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(40)
        }
    }
}
