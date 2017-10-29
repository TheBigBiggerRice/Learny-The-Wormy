//
//  String.swift
//  LearnyTheWormy
//
//  Created by Chenyang Zhang on 10/28/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit


extension String {
  func removingWhitespaces() -> String {
    return components(separatedBy: .whitespaces).joined()
  }
}
