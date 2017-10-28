//
//  LWTextField.swift
//  LearnyTheWormy
//
//  Created by Chenyang Zhang on 10/28/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class LWTextField: UITextField {
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 10, dy: 0)
  }
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 10, dy: 0)
  }
  
}
