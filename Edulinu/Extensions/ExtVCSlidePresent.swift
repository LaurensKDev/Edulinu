//
//  ExtVCSlidePresent.swift
//  Edulinu
//
//  Created by Laurens on 21.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func presentWithSlide(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false)
    }
    
}
