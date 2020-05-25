//
//  String+Capital.swift
//  Optus POC
//
//  Created by Rohit on 5/25/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

/// Use this extension to make first charactor of string uppercase
extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
