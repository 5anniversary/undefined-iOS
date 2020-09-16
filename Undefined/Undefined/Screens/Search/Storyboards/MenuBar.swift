//
//  MenuBar.swift
//  Undefined
//
//  Created by summer on 2020/09/09.
//  Copyright © 2020 Undefined. All rights reserved.
//

import Foundation

protocol MenuBarSelectable {
    func menuBarDidSelectItemAt(menu: MenuBar, index: Int)
}

class MenuBar: UIView {
    var menuDelegate: MenuBarSelectable?
    var tabs: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let divideLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 216.0/255.0,
                                       green: 216.0/255.0,
                                       blue: 216.0/255.0,
                                       alpha: 1.0)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        self.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: "MenuBarCell")
        
        self.addSubview(collectionView)
        self.addSubview(divideLine)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(55.0)
        }
        divideLine.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MenuBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuBarCell", for: indexPath) as? MenuBarCell else { return UICollectionViewCell() }

        cell.menuLabel.text = tabs[indexPath.item]
        cell.backgroundColor = .white
        return cell
    }
    
    
}

extension MenuBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuDelegate?.menuBarDidSelectItemAt(menu: self, index: indexPath.item)
    }
}

extension MenuBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(tabs.count), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class MenuBarCell: UICollectionViewCell {
    let menuLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            print("isSelected: \(isHighlighted)")
            menuLabel.textColor = isSelected ? .red : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        self.contentView.addSubview(menuLabel)
        menuLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
