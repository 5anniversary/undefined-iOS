//
//  ScrollableBottomSheetViewController.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/21.
//  Copyright © 2020 Undefined. All rights reserved.
//


import UIKit

class ScrollableBottomSheetVC: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let fullView: CGFloat = UIScreen.main.bounds.height / 2
    
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 70
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "default")
//
//        searchBar.isUserInteractionEnabled = false
        
        let gesture =
            UIPanGestureRecognizer.init(target: self,
                                        action: #selector(ScrollableBottomSheetVC.panGesture))
        gesture.delegate = self
        
        view.addGestureRecognizer(gesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareBackgroundView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0,
                                      y: yComponent!,
                                      width: frame!.width,
                                      height: frame!.height - 100)
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)

        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0,
                                     y: y + translation.y,
                                     width: view.frame.width,
                                     height: view.frame.height)
            
            recognizer.setTranslation(CGPoint.zero,
                                      in: self.view)
        }
        
        if recognizer.state == .ended {
            let full = Double((y - fullView) / -velocity.y)
            let partial = Double((partialView - y) / velocity.y )
            
            var duration =  velocity.y < 0 ? full : partial
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration,
                           delay: 0.0,
                           options: [.allowUserInteraction],
                           animations: {
                            
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0,
                                             y: self.partialView,
                                             width: self.view.frame.width,
                                             height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0,
                                             y: self.fullView,
                                             width: self.view.frame.width,
                                             height: self.view.frame.height)
                }
                
                }, completion: { [weak self] _ in
                    if ( velocity.y < 0 ) {
                        print("테이블뷰 구성 되면 넣어주세요")
//                        self?.tableView.isScrollEnabled = true
                    }
            })
        }
    }
    
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        view.insertSubview(bluredView, at: 0)
    }

}

extension ScrollableBottomSheetVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "default")!
    }
}

extension ScrollableBottomSheetVC: UIGestureRecognizerDelegate {

    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y

        let y = view.frame.minY
        
        if (y == fullView && tableView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
        
        return false
    }
    
}
