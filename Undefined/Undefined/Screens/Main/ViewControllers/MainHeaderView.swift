//
//  MainHeaderView.swift
//  Undefined
//
//  Created by 오준현 on 2020/09/03.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class MainHeaderView: UIView {
    
    let searchTextField = UITextField().then {
        $0.textAlignment = .center
        $0.text = "당신의 플라츠를 검색해보세요!"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .lightishPurple
    }
    
    let listCVHeaderLabel = UILabel().then {
        $0.text = "추천 큐레이터"
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    let searchView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 19.5
    }
    
    let listTVHeaderLabel = UILabel().then {
        $0.text = "추천 플라츠 리스트"
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    let mainListCollectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout:UICollectionViewLayout()).then
        {
            $0.isScrollEnabled = true
            $0.allowsMultipleSelection = true
            $0.isPrefetchingEnabled = true
            $0.backgroundColor = .white
            $0.showsHorizontalScrollIndicator = false
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 3
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
            $0.collectionViewLayout = layout
    }
    
    func layout(){
        addSubview(searchView)
        addSubview(searchTextField)
        addSubview(listCVHeaderLabel)
        addSubview(listTVHeaderLabel)
        addSubview(mainListCollectionView)
        
        
        mainListCollectionView.delegate = self
        mainListCollectionView.dataSource = self
        
        mainListCollectionView.register(MainListCVC.self,
                                        forCellWithReuseIdentifier: MainListCVC.identifier)
        
        searchView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(37)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().inset(28)
            make.height.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(37)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().inset(28)
            make.height.equalTo(40)
        }
        
        listCVHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(104)
            make.leading.equalToSuperview().offset(18)
        }
        
        listTVHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(263)
            make.leading.equalToSuperview().offset(18)
        }

        mainListCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(140)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(89)
        }
        
        searchView.layer.applyShadow(color: UIColor(red: 149/255,
                                                    green: 149/255,
                                                    blue: 149/255,
                                                    alpha: 1),
                                     alpha: 0.5,
                                     x: 2,
                                     y: 3,
                                     blur: 7)
    }
}

extension MainHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 89, height: 86)
    }
}

extension MainHeaderView: UICollectionViewDelegate { }

extension MainHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainListCVC.identifier,
                                                      for: indexPath) as! MainListCVC
        
        cell.setUpLayout()
        
        return cell
    }
    
    
}

extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
    
}
