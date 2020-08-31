//
//  SearchVC.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit
import SnapKit

let cellIdentifier = "SearchTagCell"
class SearchVC: UIViewController {
    var viewModel: SearchViewModel = SearchViewModel()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: .zero)
        searchBar.backgroundImage = UIImage()
        
        return searchBar
    }()
    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.register(SearchTagCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.snp.makeConstraints({ make in
            make.top.equalTo(34.0)
            make.leading.equalTo(28.0)
            make.width.equalTo(320.0)
        })
        
        self.collectionView.snp.makeConstraints({ make in
            make.top.equalTo(searchBar.snp.bottom).offset(37)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
    }

}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 28.0, bottom: 0, right: 28.0)
    }
}

extension SearchVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SearchTagCell else { return UICollectionViewCell() }
        
        cell.setData(viewModel: viewModel.cellViewModels[indexPath.row])
        return cell
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64.0, height: 20.0)
    }
}
