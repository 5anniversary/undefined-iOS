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
        collectionView.register(SearchTagCell.self, forCellWithReuseIdentifier: "SearchTagCell")
        collectionView.register(SearchRecentKeywordCell.self, forCellWithReuseIdentifier: "SearchRecentKeywordCell")
        collectionView.register(SearchSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchSectionHeader")
        
        return collectionView
    }()
    let resultViewController = SearchResultContainerVC()
    
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
        
        self.view.addSubview(resultViewController.view)
        self.view.addSubview(collectionView)
        self.searchBar.becomeFirstResponder()
        
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
            make.top.equalTo(searchBarContainerView.snp.bottom).offset(31)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        self.resultViewController.view.snp.makeConstraints { make in
            make.top.equalTo(searchBarContainerView.snp.bottom).offset(31)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func configureEventBinding() {
        self.searchBar.rx.searchButtonClicked.asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                let keyword = self?.searchBar.searchTextField.text
                self?.search(keyword: keyword)
            }).disposed(by: disposeBag)
        
        self.searchBar.searchTextField.rx.controlEvent([.editingDidBegin])
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: {
                self.view.bringSubviewToFront(self.collectionView)
            }).disposed(by: disposeBag)
    }
    
    func search(keyword: String?) {
        if !(keyword?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            self.view.bringSubviewToFront(resultViewController.view)
            self.searchBar.resignFirstResponder()
            
            let keywordModel = SearchKeywordModel(keyword: keyword)
            let keywordViewModel = SearchKeywordCellViewModel(model: keywordModel)
            self.viewModel.recentKeywordViewModels.insert(keywordViewModel, at: 0)
            self.searchBar.searchTextField.text = keyword
            self.collectionView.reloadData()
        }
    }
}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12.0, left: 28.0, bottom: 37.0, right: 28.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchSectionHeader", for: indexPath) as? SearchSectionHeader {
                if indexPath.section == 0 {
                    sectionHeader.headerTitle.text = "추천 태그"
                } else if indexPath.section == 1 {
                    sectionHeader.headerTitle.text = "최신 검색어"
                }
                return sectionHeader
            }
        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

extension SearchVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.tagViewModels.count
        } else {
            return viewModel.recentKeywordViewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchTagCell", for: indexPath) as? SearchTagCell else { return UICollectionViewCell() }
            
            cell.setData(viewModel: viewModel.tagViewModels[indexPath.row])
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchRecentKeywordCell", for: indexPath) as? SearchRecentKeywordCell else { return UICollectionViewCell() }
            
            cell.setData(viewModel: viewModel.recentKeywordViewModels[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var keyword: String?
        if indexPath.section == 0 {
            keyword = viewModel.tagViewModels[indexPath.item].keyword
        } else if indexPath.section == 1 {
            keyword = viewModel.recentKeywordViewModels[indexPath.item].keyword
        }
        
        self.search(keyword: keyword)
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 27.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            guard let keyword = viewModel.tagViewModels[indexPath.row].keyword else { return CGSize.zero }
            
            let size = "#\(keyword)".size(withAttributes: [.font:UIFont.systemFont(ofSize: 13)])
            
            return CGSize(width: size.width + 18, height: 32)
        } else if indexPath.section == 1 {
            let marginLeftRight: CGFloat = 36
            return CGSize(width: collectionView.frame.width - marginLeftRight, height: 24)
        }
        
        return CGSize.zero
    }
}
