//
//  SearchResultPlaceVC.swift
//  Undefined
//
//  Created by summer on 2020/09/16.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

struct PlaceModel {
    var title: String?
    var address: String?
}

struct SearchPlaceCellViewModel {
    var title: String?
    var address: String?
    
    init(model: PlaceModel) {
        self.title = model.title
        self.address = model.address
    }
}

struct SearchResultPlaceViewModel {
    var dataSource = [SearchPlaceCellViewModel]()
   
    mutating func setDummyData() {
        let data: [PlaceModel] = [PlaceModel(title: "다로베", address: "1층 다로베"),
            PlaceModel(title: "다로베", address: "2층 다로베")]
        
        dataSource = data.map { (map) -> SearchPlaceCellViewModel in
            return SearchPlaceCellViewModel(model: map)
        }
    }
    init() {
        setDummyData()
    }
}

class SearchResultPlaceVC: UIPageViewController {
    let pageIndex = 0
    var viewModel: SearchResultPlaceViewModel = SearchResultPlaceViewModel()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(SearchPlaceCell.self, forCellWithReuseIdentifier: "SearchPlaceCell")
        
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        configureConstraints()
    }
    
    private func configureConstraints() {
        self.collectionView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(29.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
    }
}

extension SearchResultPlaceVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18.0, bottom: 0, right: 17.0)
    }
}

extension SearchResultPlaceVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPlaceCell", for: indexPath) as? SearchPlaceCell else { return UICollectionViewCell() }
        
        cell.setData(viewModel: viewModel.dataSource[indexPath.row])
        return cell
    }
}

extension SearchResultPlaceVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 80)
    }
}
