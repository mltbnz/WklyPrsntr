//
//  PresentationViewController.swift
//  WklyPrsntr
//
//  Created by Malte Bünz on 09.12.17.
//  Copyright © 2017 mbnz. All rights reserved.
//

import UIKit

class PresentationViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var slides: [SlideViewController] = [SlideViewController]()
    var topics: [Topic]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        topics.enumerated().forEach() { (offset, topic) in
            let slideController = viewController(offset: offset, topic: topic)
            slides.append(slideController)
        }
        if let start = slides.first {
            setViewControllers([start], direction: .forward, animated: false, completion: nil)
        }
    }
    
    fileprivate func viewController(offset: Int, topic: Topic) -> SlideViewController {
        let id = String(describing: SlideViewController.self)
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id) as! SlideViewController
        controller.pageIndex = offset
        controller.topic = topic
        controller.colorMode = offset % 2 == 0 ? .bright : .dark
        return controller
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: SlideViewController = viewController as! SlideViewController
        var index = pageContent.pageIndex
        index! -= 1
        guard index! >= 0 else {
            return slides.last
        }
        return slides[index!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: SlideViewController = viewController as! SlideViewController
        var index = pageContent.pageIndex
        index! += 1
        guard index! < slides.count else {
            return slides.first
        }
        return slides[index!]
    }
}
