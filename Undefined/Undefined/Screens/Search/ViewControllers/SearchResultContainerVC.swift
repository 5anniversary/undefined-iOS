//
//  SearchResultContainerVC.swift
//  Undefined
//
//  Created by summer on 2020/09/16.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class SearchResultContainerVC: UIViewController {
    var currentIndex: Int = 0
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController] = []
    
    let menuBar: MenuBar = {
        let menuBar = MenuBar()
        return menuBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuBar()
        setupViewControllers()
        setupPageViewController()
    }
    
    func refreshData() {
        guard let placeVC = viewControllers[0] as? SearchResultPlaceVC else { return }
        placeVC.collectionView.reloadData()
    }
    
    private func setupViewControllers() {
        let resultPlaceViewController = SearchResultPlaceVC()
        let resultPlatzViewController = SearchResultPlatzVC()
        
        viewControllers.append(resultPlaceViewController)
        viewControllers.append(resultPlatzViewController)
    }
    
    private func setupPageViewController() {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                       navigationOrientation: .horizontal)
        self.pageViewController?.view.frame = CGRect.init(x: 0,
                                                          y: 56.0,
                                                          width: self.view.frame.width,
                                                          height: self.view.frame.height - 56.0)
        self.pageViewController.view.backgroundColor = .white
        
        self.addChild(pageViewController)
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.pageViewController.didMove(toParent: self)
        
        self.menuBar.collectionView.selectItem(at: IndexPath(item: 0, section: 0),
                                               animated: true,
                                               scrollPosition: .centeredVertically)
        
        guard let vc = viewController(at: 0) else { return }
        self.pageViewController.setViewControllers([vc],
                                                   direction: .forward,
                                                   animated: true)
    }
    
    private func setupMenuBar() {
        menuBar.menuDelegate = self
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(55.0)
        }
        
        menuBar.tabs = ["장소", "플라츠"]
    }
    
    func viewController(at index: Int) -> UIViewController? {
        if ((self.menuBar.tabs.count == 0) || (index >= self.menuBar.tabs.count)) {
            return nil
        }
        self.currentIndex = index
        self.menuBar.collectionView.selectItem(at: IndexPath(item: self.currentIndex, section: 0),
                                               animated: true,
                                               scrollPosition: .centeredVertically)
        return viewControllers[index]
    }
}

extension SearchResultContainerVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished && completed {
            var index = 0
            if let vc = pageViewController.viewControllers?.first as? SearchResultPlaceVC {
                index = vc.pageIndex
            } else if let vc = pageViewController.viewControllers?.first as? SearchResultPlatzVC {
                index = vc.pageIndex
            }
            let indexPath = IndexPath(item: index, section: 0)
            menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
            menuBar.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            
        }
    }
}

extension SearchResultContainerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = 0
        if let vc = viewController as? SearchResultPlaceVC {
            index = vc.pageIndex
        } else if let vc = viewController as? SearchResultPlatzVC {
            index = vc.pageIndex
        }
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = 0
        
        if let vc = viewController as? SearchResultPlaceVC {
            index = vc.pageIndex
        } else if let vc = viewController as? SearchResultPlatzVC {
            index = vc.pageIndex
        }
        
        if (index == menuBar.tabs.count) || (index == NSNotFound) {
            return nil
        }
        
        index += 1
        return self.viewController(at: index)
    }
}

extension SearchResultContainerVC: MenuBarSelectable {
    
    func menuBarDidSelectItemAt(menu: MenuBar, index: Int) {
        if index != currentIndex {
            if index > currentIndex {
                self.pageViewController.setViewControllers([viewController(at: index)!],
                                                           direction: .forward,
                                                           animated: true)
            } else {
                self.pageViewController.setViewControllers([viewController(at: index)!],
                                                           direction: .reverse,
                                                           animated: true)
            }
            menuBar.collectionView.scrollToItem(at: IndexPath.init(item: index, section: 0),
                                                at: .centeredHorizontally,
                                                animated: true)
        }
    }
}
