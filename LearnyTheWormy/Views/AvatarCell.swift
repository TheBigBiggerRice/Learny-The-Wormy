//
//  File.swift
//  LearnyTheWormy
//
//  Created by Chenyang Zhang on 10/29/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

class AvatarCell: UITableViewCell {
  
  let avatarImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    return view
  }()
  
  let pointsLabel: LWLabel = {
    let label = LWLabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Bubblegum", size: 24)
    //label.text = "100"
    return label
  }()
  

  // MARK: - Lifetime
  
  init(frame: CGRect) {
    super.init(style: .default, reuseIdentifier: nil)
    initialize()
  }
  
  required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initialize()
  }
  
  init() {
    super.init(style: .default, reuseIdentifier: nil)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  private func initialize() {
    contentView.addSubview(avatarImageView)
    contentView.addSubview(pointsLabel)
    
    contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0))
    contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 0))
    contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
    contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))

    contentView.addConstraint(NSLayoutConstraint(item: pointsLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0))
    contentView.addConstraint(NSLayoutConstraint(item: pointsLabel, attribute: .left, relatedBy: .equal, toItem: avatarImageView, attribute: .right, multiplier: 1.0, constant: 200))
    contentView.addConstraint(NSLayoutConstraint(item: pointsLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
    contentView.addConstraint(NSLayoutConstraint(item: pointsLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))

    
  }
  
  
  
}
