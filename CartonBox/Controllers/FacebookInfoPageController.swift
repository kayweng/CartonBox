//
//  FacebookInfoPageController.swift
//  CartonBox
//
//  Created by kay weng on 11/10/2017.
//  Copyright © 2017 kay weng. All rights reserved.
//

import Foundation
import UIKit

class FacebookInfoPageController: UIPageViewController {

    var pages: [UIViewController] = []
    var currentPageIndex:Int = 0
    lazy var timer:Timer = Timer()
    var scrollView: UIScrollView?
    var pgFacebookInfo:UIPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        self.assignPages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let first = self.pages.first {
            self.setViewControllers([first], direction: .forward, animated: false, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Methods
    fileprivate func assignPages(){
        func initPageController(_ name:String)->UIViewController{
            return sb.instantiateViewController(withIdentifier: name)
        }
        
        let fbPage1 = initPageController("FacebookInfo1") as! FacebookPageInfo1Controller
        let fbPage2 = initPageController("FacebookInfo2") as! FacebookPageInfo2Controller
        
        if pages.count > 0 {
            for i in 0...self.pages.count-1{
                pages[i].willMove(toParent: nil)
                pages[i].removeFromParent()
            }
        }
        
        pages.removeAll()
        pages.append(fbPage1)
        pages.append(fbPage2)
        
        self.pgFacebookInfo?.numberOfPages = pages.count
        
        startPagesSpining(true)
    }
    
    func startPagesSpining(_ started:Bool){
        if started{
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(FacebookInfoPageController.shiftPage), userInfo: nil, repeats: true)
        }else{
            self.timer.invalidate()
            self.timer = Timer()
        }
        
    }
    
    //MARK: - Actions
    @objc private func shiftPage(){
        if self.currentPageIndex == 1{
            self.setViewControllers([self.pages[0]], direction: .reverse, animated: true, completion: { (completion) in
                self.currentPageIndex = 0
            })
        }else{
            self.setViewControllers([self.pages[1]], direction: .forward, animated: true, completion: { (completion) in
                self.currentPageIndex = 1
            })
        }
    }
}

//MARK: - Extension
extension FacebookInfoPageController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewController.NavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        if let vw = viewControllers{
            self.pgFacebookInfo?.currentPage = pages.index(of: vw[0])!
        }
        
        super.setViewControllers(viewControllers, direction: direction, animated: animated, completion: completion)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.pgFacebookInfo?.currentPage = self.currentPageIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        
        //self.stopPageSpining()
        
        let previousIndex = viewControllerIndex - 1 < 0 ? pages.count - 1 : viewControllerIndex - 1
        self.currentPageIndex = previousIndex
      
        guard previousIndex >= 0 else {
            return pages.last
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return self.pages[self.currentPageIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        
        //self.stopPageSpining()
        
        let nextIndex = viewControllerIndex + 1 >= pages.count ? 0 : viewControllerIndex + 1
        let orderedViewControllersCount = pages.count
        
        self.currentPageIndex = nextIndex
     
        guard orderedViewControllersCount != nextIndex else {
            return pages.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
}
