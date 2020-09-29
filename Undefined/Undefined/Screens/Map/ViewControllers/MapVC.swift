//
//  MapVC.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class MapVC: UIViewController {
    
    let mapView = MTMapView().then {
        $0.setMapCenter(.init(geoCoord: .init(latitude: 37.537229, longitude: 127.005515)),
                        animated: true)
    }
    
    var poList: [MTMapPOIItem] = []
    
    let backButtonView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "leftArrow"), for: .normal)
        $0.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    let likeButtonView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    
    let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "leftArrow"), for: .normal)
        $0.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }

    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 70
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        view.addSubview(backButtonView)
        view.addSubview(backButton)
        view.addSubview(likeButtonView)
        view.addSubview(likeButton)

        mapView.delegate = self
        mapView.baseMapType = .standard
        mapView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        backButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(mapView.snp.top).offset(49)
            make.leading.equalTo(mapView.snp.leading).offset(18)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }

        backButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(backButtonView.snp.centerX)
            make.centerY.equalTo(backButtonView.snp.centerY)
            make.height.equalTo(23)
            make.width.equalTo(11)
        }
        
        likeButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(mapView.snp.top).offset(49)
            make.trailing.equalTo(mapView.snp.trailing).offset(-18)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }

        likeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(likeButtonView.snp.centerX)
            make.centerY.equalTo(likeButtonView.snp.centerY)
            make.height.equalTo(23)
            make.width.equalTo(11)
        }
        var num = 0.001
        
        for i in 0 ..< 6 {
            let po = MTMapPOIItem()
            po.setPoint(37.437210 + num, 127.005525 + num, i)
            num += num
            
            poList.append(po)
        }
        
        mapView.addPOIItems(poList)
        mapView.fitAreaToShowAllPOIItems()
        
        mapView.setZoomLevel(8, animated: false)
        addBottomSheetView(scrollable: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    
}

// MARK: - helper

extension MapVC {
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func addNavigationBar(){
        
    }
    
    func addBottomSheetView(scrollable: Bool? = true) {
        let bottomSheetVC = scrollable! ? ScrollableBottomSheetVC() : BottomSheetVC()
        
        let floatingBar = UIView().then {
//            $0.backgroundColor = UIColor(red: 92/255, green: 92/255, blue: 92/255, alpha: 1)
            $0.backgroundColor = .black
            $0.alpha = 0
        }
        
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        
        view.addSubview(floatingBar)
        
        bottomSheetVC.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        
        bottomSheetVC.view.layer.cornerRadius = 15
        bottomSheetVC.view.layer.masksToBounds = true
        bottomSheetVC.view.layer.isOpaque = false
        
        bottomSheetVC.view.backgroundColor = .white

        bottomSheetVC.view.frame = CGRect(x: 0,
                                          y: self.view.frame.maxY,
                                          width: width,
                                          height: height)

        floatingBar.snp.makeConstraints { (make) in
            make.bottom.equalTo(bottomSheetVC.view.snp.top).offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalTo(58)
            make.height.equalTo(4)
        }

        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseIn,
                       animations: {
                        floatingBar.alpha = 1
        })

        
    }
    
}

extension MapVC: MTMapViewDelegate { }

extension MTMapPOIItem {
    func setPoint(_ lat: Double, _ long: Double, _ tag: Int) {
        self.markerType = .customImage
        self.customImageName = "locationPin"
        self.mapPoint = .init(geoCoord: .init(latitude: lat, longitude: long))
        self.showAnimationType = .noAnimation
        
        self.tag = tag
    }
}
