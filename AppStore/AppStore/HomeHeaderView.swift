//
//  HomeHeaderView.swift
//  AppStore
//
//  Created by Brett Markowitz on 11/6/20.
//

import UIKit
import SwiftUI

class HomeHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeader() {
        let headerViewHostingController = UIHostingController(rootView: HomeHeaderContentView())
        let headerView = headerViewHostingController.view
        headerView?.clipsToBounds = false
        
        
        addSubview(headerView!)
        
        headerView?.translatesAutoresizingMaskIntoConstraints = false
        headerView?.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            headerView!.topAnchor.constraint(equalTo: topAnchor),
            headerView!.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerView!.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView!.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
