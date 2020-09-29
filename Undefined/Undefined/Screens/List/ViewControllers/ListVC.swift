//
//  ListVC.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

import Then
import SnapKit

class ListVC: UIViewController {
    
    // MARK: - UI Components
    
    let listTableView = UITableView(frame: .zero,
                                    style: .grouped).then
        {
            $0.separatorStyle = .none
            $0.backgroundColor = .white
    }
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        tableView()
    }
    
}

// MARK: - Helper

extension ListVC {
    
    func layout() {
        view.addSubview(listTableView)
        
        listTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func tableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(MainListTVC.self, forCellReuseIdentifier: MainListTVC.identifier)
    }
    
}

// MARK: Table View Code

extension ListVC: UITableViewDelegate {
}

extension ListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainListTVC.identifier,
                                                 for: indexPath) as! MainListTVC
        
        cell.setUpLayout()
        cell.rootVC = self
        cell.contentView.backgroundColor = .white
        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 144
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        
        return 217
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        
        let view = ProfileView()
        
        view.layout()
        view.layoutListView()
        
        return view
    }
    
}
