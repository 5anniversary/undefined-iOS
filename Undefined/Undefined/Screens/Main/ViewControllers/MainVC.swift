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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainListTableView)
        
        mainListTableView.backgroundView = UIView().then {
            $0.backgroundColor = .white
        }
        
        mainListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        mainListTableView.delegate = self
        mainListTableView.dataSource = self
        mainListTableView.separatorStyle = .none
        mainListTableView.register(MainListTVC.self,
                                   forCellReuseIdentifier: MainListTVC.identifier)
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
        
        return 298
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
        
        return 77
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
