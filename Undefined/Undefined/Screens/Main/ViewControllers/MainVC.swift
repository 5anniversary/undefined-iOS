//
//  ViewController.swift
//  Undefined
//
//  Created by 오준현 on 2020/07/26.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

import Then
import SnapKit

class MainVC: UIViewController {

    let mainListTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .white
    }
    
    let searchTextField = UITextField().then {
        $0.text = "당신의 플라츠를 검색해보세요!"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .lightishPurple
    }
    
    let searchButton = UIButton().then {
        $0.setImage(UIImage(named: "search"), for: .normal)
    }
        
    let searchView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 19.5
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainListTableView)
        view.addSubview(searchView)
        view.addSubview(searchButton)
        view.addSubview(searchTextField)

        searchView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(17)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
            make.height.equalTo(40)
        }
        
        searchButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(searchTextField.snp.leading).offset(-6)
            make.centerY.equalTo(searchView.snp.centerY)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }

        searchTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(searchView.snp.centerY)
            make.centerX.equalTo(searchView.snp.centerX).offset(13)
            make.width.equalTo(180)
            make.height.equalTo(20)
        }

        mainListTableView.backgroundView = UIView().then {
            $0.backgroundColor = .white
        }
        
        mainListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(68)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        mainListTableView.delegate = self
        mainListTableView.dataSource = self
        mainListTableView.separatorStyle = .none
        mainListTableView.register(MainListTVC.self,
                                   forCellReuseIdentifier: MainListTVC.identifier)
        
        searchView.layer.applyShadow(color: UIColor(red: 149/255,
                                                    green: 149/255,
                                                    blue: 149/255,
                                                    alpha: 1),
                                     alpha: 0.5,
                                     x: 2,
                                     y: 3,
                                     blur: 7)

        mainListTableView.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        mainListTableView.layer.borderWidth = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
}


extension MainVC: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        
        return 320
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let view = MainHeaderView()
        
        view.layout()
        view.backgroundColor = .white

        return view
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 144
    }
}

extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainListTVC.identifier,
                                                 for: indexPath) as! MainListTVC
        
        cell.setUpLayout()
        cell.likeButton.isHidden = true
        cell.contentView.backgroundColor = UIColor.white

        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let vc = MapVC()
        
        vc.modalPresentationStyle = .overFullScreen
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
