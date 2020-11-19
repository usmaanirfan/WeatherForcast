//
//  SplitViewController.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {

    override func viewDidLoad() {
        delegate = self
        preferredDisplayMode = .allVisible
    }
    
}

extension SplitViewController: UISplitViewControllerDelegate {
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
