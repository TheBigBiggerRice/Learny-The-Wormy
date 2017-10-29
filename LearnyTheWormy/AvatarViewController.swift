//
//  AvatarViewController.swift
//  LearnyTheWormy
//
//  Created by Chenyang Zhang on 10/29/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  private var avatarTableView: UITableView = UITableView()
  
  fileprivate let okButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("ok", for: .normal)
    button.titleLabel?.font = UIFont(name: "Bubblegum", size: 24)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //let barHeight = UIApplication.shared.statusBarFrame.size.height
    let screenWidth = view.frame.width
    //let screenHeight = view.frame.height
    avatarTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 600)
    
    avatarTableView.register(AvatarCell.self, forCellReuseIdentifier: "AvatarCell")
    avatarTableView.dataSource = self
    avatarTableView.delegate = self
    view.addSubview(avatarTableView)
    initialize()


  }
  private func initialize() {
    view.addSubview(okButton)
    view.backgroundColor = .white

    okButton.addTarget(self, action: #selector(AvatarViewController.okButtonTapped), for: .touchUpInside)
    
    
    view.addConstraint(NSLayoutConstraint(item: okButton, attribute: .top, relatedBy: .equal, toItem: avatarTableView, attribute: .bottom, multiplier: 1.0, constant: 20))
    view.addConstraint(NSLayoutConstraint(item: okButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: okButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
    view.addConstraint(NSLayoutConstraint(item: okButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
  }
  
  @objc func okButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("avatar \(indexPath.row)")
  }
  
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarCell", for: indexPath)
    if indexPath.row == 0{
      (cell as? AvatarCell)?.avatarImageView.image = UIImage(named: "worm")
      (cell as? AvatarCell)?.pointsLabel.text = "0"
    }
    if indexPath.row == 1{
      (cell as? AvatarCell)?.avatarImageView.image = UIImage(named: "learny_yellow_smile")
      (cell as? AvatarCell)?.pointsLabel.text = "100"

    }
    if indexPath.row == 2{
      (cell as? AvatarCell)?.avatarImageView.image = UIImage(named: "learny_red_smile")
      (cell as? AvatarCell)?.pointsLabel.text = "200"

    }
    
    return cell
  }
}
