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
        let view = UIView.init(frame: .zero).then {
            $0.layer.cornerRadius = 19.5
            $0.backgroundColor = .white
            
            $0.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowRadius = 3.0
            $0.layer.shadowColor = UIColor(red: 149.0/255.0,
                                           green: 149.0/255.0,
                                           blue: 149.0/255.0,
                                           alpha: 1.0).cgColor
        }
        return view
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: .zero)
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .white
        
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: tagLayout)
        collectionView.backgroundColor = .white
        collectionView.register(SearchTagCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(SearchSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchSectionHeader")
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureConstraints()
     
        self.configureEventBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        
        self.collectionView.backgroundColor = .white
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
                self?.navigationController?.pushViewController(SearchResultVC(), animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let keyword = viewModel.cellViewModels[indexPath.row].name else { return CGSize.zero }
        
        let size = "#\(keyword)".size(withAttributes: [.font:UIFont.systemFont(ofSize: 13)])
        
        return CGSize(width: size.width + 18, height: 32)
    }
}
