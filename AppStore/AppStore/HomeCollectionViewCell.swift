//
//  HomeCollectionViewCell.swift
//  AppStore
//
//  Created by Brett Markowitz on 11/6/20.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.layer.cornerRadius = 15
        contentView.layer.cornerCurve = .continuous
        contentView.backgroundColor = .secondarySystemGroupedBackground
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = false
        
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 20
        contentView.layer.shadowOpacity = 0.12
        contentView.layer.rasterizationScale = UIScreen.main.scale
        contentView.layer.shouldRasterize = true
    }
}
