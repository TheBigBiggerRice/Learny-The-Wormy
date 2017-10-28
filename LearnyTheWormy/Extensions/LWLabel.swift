//
//  LWLabel.swift
//  LearnyTheWormy
//
//  Created by Chenyang Zhang on 10/28/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class LWLabel: UILabel {
  override func drawText(in rect: CGRect) {
    super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)))
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    font = UIFont(name: "Bubblegum", size: 20)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

