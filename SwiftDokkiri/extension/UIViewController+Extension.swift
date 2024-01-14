//
//  UIViewController+Extension.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2023/12/08.
//  Copyright © 2023 藤田優作. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func pushViewControllerOverNavigation<T: UIViewController>(_ storyboard: String, _ additionalOperation: ((T) -> ())? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController()
        if let nextVC = nextVC as? T {
            additionalOperation?(nextVC)
        }
        navigationController?.pushViewController(nextVC!, animated: true)
    }
}
