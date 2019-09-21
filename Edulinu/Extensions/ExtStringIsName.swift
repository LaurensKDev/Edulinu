//
//  ExtStringIsName.swift
//  Edulinu
//
//  Created by Laurens on 21.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var isName: Bool {
        return !isEmpty && range(of: "[^a-zA-Z ]", options: .regularExpression) == nil
    }
}
