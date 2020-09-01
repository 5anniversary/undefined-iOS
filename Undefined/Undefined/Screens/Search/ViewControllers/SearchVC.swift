//
//  SearchVC.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

let cellIdentifier = "SearchTagCell"
class SearchVC: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()
    var viewModel: SearchViewModel = SearchViewModel()
    
    var searchBarContainerView: UIView = {
        let view = UIView.init(frame: .zero)
        view.layer.cornerRadius = 19.5
        view.backgroundColor = .white
 
        return view
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: .zero)
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .white
        // TODO: string 빼기
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "당신의 플라츠를 검색해보세요!",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 162.0/255.0,
                                                                         green: 62.0/255.0,
                                                                         blue: 255.0/255.0,
                                                                         alpha: 1.0),
                         NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular",
                                                             size: 14.0)!,
        ])
        return searchBar
    }()
    
    
    var collectionView: UICollectionView = {
        let tagLayout = SearchTagFlowLayout()
        tagLayout.estimatedItemSize = CGSize(width: 64, height: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: tagLayout)
        collectionView.backgroundColor = .white
        collectionView.register(SearchTagCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(SearchSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchSectionHeader")
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: UIColor 따로 빼기
        
        self.configureUI()
        self.configureConstraints()
     
        self.configureEventBinding()
    }
    
    private func configureUI() {
        self.view.backgroundColor = UIColor(red: 162.0/255.0,
                                            green: 62.0/255.0,
                                            blue: 255.0/255.0,
                                            alpha: 1.0)
        
        self.collectionView.backgroundColor = UIColor(red: 162.0/255.0,
                                                      green: 62.0/255.0,
                                                      blue: 255.0/255.0,
                                                      alpha: 1.0)
        self.view.addSubview(searchBarContainerView)
        self.searchBarContainerView.addSubview(searchBar)
        self.view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureConstraints() {
        searchBarContainerView.snp.makeConstraints({ make in
            make.top.equalTo(34.0)
            make.leading.equalTo(28.0)
            make.width.equalTo(320.0)
            make.height.equalTo(40.0)
        })
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(58.0)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.collectionView.snp.makeConstraints({ make in
            make.top.equalTo(searchBarContainerView.snp.bottom).offset(37)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
    }

    private func configureEventBinding() {
        self.searchBar.rx.searchButtonClicked.asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
            }).disposed(by: disposeBag)
    }
}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12.0, left: 28.0, bottom: 37.0, right: 28.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchSectionHeader", for: indexPath) as? SearchSectionHeader {
                sectionHeader.headerTitle.text = "추천 태그"
                return sectionHeader
            }
        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 27.0)
    }
}
