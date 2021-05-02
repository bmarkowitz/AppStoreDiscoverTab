//
//  ViewController.swift
//  AppStore
//
//  Created by Brett Markowitz on 10/31/20.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    /// A collection view that displays a list of cards with shadows
    var collectionView: UICollectionView!
    
    ///A visual effect view which changes from completely transparent to blurred after beginning to scroll the collection view down.
    var topView: UIVisualEffectView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, HomeItem>!
    
    enum Section: CaseIterable {
        case main
    }
    
    struct HomeItem: Hashable {
        var title: String
    }
    
    let homeItems = [
        HomeItem(title: "Test Title"),
        HomeItem(title: "Test Title 2"),
        HomeItem(title: "Test Title 3"),
        HomeItem(title: "Test Title 4"),
        HomeItem(title: "Test Title 5"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTopView()
        configureCollectionView()
        configureDataSource()
        
        refreshData(animated:
                        false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.verticalScrollIndicatorInsets = UIEdgeInsets(top: topView.frame.height, left: 0, bottom: 0, right: 0)
    }
    
    private func configureTopView() {
        let blurEffect = UIBlurEffect(style: .regular)
        topView = UIVisualEffectView(effect: blurEffect)
        topView.alpha = 0
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, HomeItem>(collectionView: collectionView) {
            collectionView, indexPath, homeItem -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: "Header", for: indexPath) as! HomeHeaderView
            
            return sectionHeader
        }
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: "Header")
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        view.sendSubviewToBack(collectionView)

        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 30

        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: "Header", alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) in
            
            return section
        }
        return layout
    }
    
    private func refreshData(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HomeItem>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(homeItems, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topView.alpha = (scrollView.contentOffset.y / 44.0) + 1
    }
}
