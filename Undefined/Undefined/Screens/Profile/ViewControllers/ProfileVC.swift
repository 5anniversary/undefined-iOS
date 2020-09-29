//
//  ProfileVC.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

import SnapKit
import Then

class ProfileVC: UIViewController {
    
    // MARK: - UI components
    
    let profileTableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
    }
    
    // MARK: - Variable and Properties
    
    let data = ["오픈소스 라이센스", "버전정보", "로그아웃", "회원탈퇴"]
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        setTableView()
    }
    
}

// MARK: - Helper

extension ProfileVC {
    
    func layout() {
        view.addSubview(profileTableView)
        
        profileTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
    func setTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(ProfileTVC.self, forCellReuseIdentifier: ProfileTVC.identifier)
    }
}


// MARK: - TableView Code

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let view = ProfileView()
        
        view.layout()
        
        return view
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTVC.identifier,
                                                 for: indexPath) as! ProfileTVC
        
        cell.label.text = data[indexPath.row]
        cell.layout()
        cell.contentView.backgroundColor = .white
        
        return cell
    }
    
    
}
