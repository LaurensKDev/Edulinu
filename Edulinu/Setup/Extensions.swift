//
//  Extensions.swift
//  Edulinu
//
//  Created by Laurens on 22.07.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
}
