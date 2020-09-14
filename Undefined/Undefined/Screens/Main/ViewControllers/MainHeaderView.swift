//
//  MainHeaderView.swift
//  Undefined
//
//  Created by 오준현 on 2020/09/03.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class MainHeaderView: UIView {
    
    let listCVHeaderLabel = UILabel().then {
        $0.text = "추천 큐레이터"
        $0.font = .systemFont(ofSize: 15, weight: .bold)
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
            $0.isScrollEnabled = false
            
            let layout = UICollectionViewFlowLayout()
            
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 3
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

            $0.collectionViewLayout = layout
    }
    
    func layout(){
        addSubview(listCVHeaderLabel)
        addSubview(listTVHeaderLabel)
        addSubview(mainListCollectionView)
        
        
        mainListCollectionView.delegate = self
        mainListCollectionView.dataSource = self
        
        mainListCollectionView.register(MainListCVC.self,
                                        forCellWithReuseIdentifier: MainListCVC.identifier)
        
        
        listCVHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(18)
        }
        
        listTVHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(286)
            make.leading.equalToSuperview().offset(18)
        }

        mainListCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(47)
            make.centerX.equalToSuperview()
            make.width.equalTo(342)
            make.height.equalTo(199)
        }
        
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
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainListCVC.identifier,
                                                      for: indexPath) as! MainListCVC
        
        cell.setUpLayout()
        
        return cell
    }
    
    
}

