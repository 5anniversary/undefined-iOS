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
    
    let po1 = MTMapPOIItem().then{
        $0.markerType = .redPin
        $0.mapPoint = .init(geoCoord: .init(latitude: 37.517229, longitude: 127.005525))
        $0.showAnimationType = .noAnimation
        $0.tag = 1
        $0.customImageName = "map_pin"
    }
    
    let po2 = MTMapPOIItem().then{
        $0.markerType = .redPin
        $0.mapPoint = .init(geoCoord: .init(latitude: 37.537229, longitude: 127.005525))
        $0.showAnimationType = .noAnimation
        $0.tag = 2
    }
    
    let po3 = MTMapPOIItem().then{
        $0.markerType = .redPin
        $0.mapPoint = .init(geoCoord: .init(latitude: 37.537229, longitude: 127.025525))
        $0.showAnimationType = .noAnimation
        $0.tag = 3
    }
    
    let po4 = MTMapPOIItem().then{
        $0.markerType = .redPin
        $0.mapPoint = .init(geoCoord: .init(latitude: 37.537229, longitude: 127.105525))
        $0.showAnimationType = .noAnimation
        $0.tag = 4
    }
    
    let po5 = MTMapPOIItem().then {
        $0.markerType = .redPin
        $0.mapPoint = .init(geoCoord: .init(latitude: 37.437210, longitude: 127.005525))
        $0.showAnimationType = .noAnimation
        $0.tag = 5
    }
    
    let backButton = UIButton().then {
        $0.setTitle("<", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 70
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        view.addSubview(backButton)
        
        mapView.delegate = self
        mapView.baseMapType = .standard
        mapView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(mapView.snp.top).offset(30)
            make.leading.equalTo(mapView.snp.leading).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        mapView.addPOIItems([po1, po2, po3, po4, po5])
        mapView.fitAreaToShowAllPOIItems()
        
        backButton.makeRounded(cornerRadius: 15)
        
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

extension MapVC: MTMapViewDelegate {}
