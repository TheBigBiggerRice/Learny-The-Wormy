//
//  ViewController.swift
//  LearnyTheWormy
//
//  Created by Chenyang Zhang on 10/27/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
  let userDefaults = UserDefaults.standard
  let wormSize = UIScreen.main.bounds.width
  var labelHeightConstraint: NSLayoutConstraint?
  var labelWidthConstraint: NSLayoutConstraint?
  var prevInput = ""
  var count = 0

  fileprivate let inputTextField: LWTextField = {
    let textField = LWTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Enter a mathematical statement, eg 3+2=5"
    textField.layer.borderColor = UIColor.gray.cgColor
    textField.layer.borderWidth = 1
    textField.layer.cornerRadius = 25
    return textField
  }()
  
  fileprivate let resultLabel: LWLabel = {
    let label = LWLabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.alpha = 0
    label.lineBreakMode = .byWordWrapping
    label.layer.backgroundColor = UIColor.white.cgColor
    return label
  }()
  
  fileprivate let wormImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.image = UIImage(named: "worm")
    return view
  }()
  
  fileprivate let wormButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  fileprivate let pictureImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0
    return view
  }()
  
  fileprivate let backgroundImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.image = UIImage(named: "background")
    view.contentMode = .scaleAspectFill
    return view
  }()
  
  fileprivate let pointLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Bubblegum", size: 80)
    //label.textColor = .white
    //label.text = "\(count)"
    return label
  }()
  
  fileprivate let avatarButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Change Avatar", for: .normal)
    button.titleLabel?.font = UIFont(name: "Bubblegum", size: 24)
    button.setTitleColor(.black, for: .normal)
    
    return button
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    count = userDefaults.integer(forKey: "points")
    userDefaults.synchronize()
    pointLabel.text = "\(count)"
    initialize()
    inputTextField.delegate = self
    hideKeyboardWhenTappedAround()
  }
  
  deinit {
    wormButton.removeTarget(self, action: nil, for: .allEvents)
  }
  

  private func initialize() {
    view.addSubview(backgroundImageView)
    view.addSubview(inputTextField)
    view.addSubview(wormImageView)
    view.addSubview(wormButton)
    view.addSubview(pictureImageView)
    view.addSubview(resultLabel)
    view.addSubview(pointLabel)
    view.addSubview(avatarButton)
    
    wormButton.addTarget(self, action: #selector(ViewController.wormTapped), for: .touchUpInside)
    avatarButton.addTarget(self, action: #selector(ViewController.avatarButtonTapped), for: .touchUpInside)
    
    //input text field on the very top
    view.addConstraint(NSLayoutConstraint(item: inputTextField, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20))
    view.addConstraint(NSLayoutConstraint(item: inputTextField, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: inputTextField, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    view.addConstraint(NSLayoutConstraint(item: inputTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))

    //worm image view
    view.addConstraint(NSLayoutConstraint(item: wormImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -100))
    view.addConstraint(NSLayoutConstraint(item: wormImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: wormImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: wormSize))
    view.addConstraint(NSLayoutConstraint(item: wormImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: wormSize))
    
    view.addConstraint(NSLayoutConstraint(item: wormButton, attribute: .top, relatedBy: .equal, toItem: wormImageView, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: wormButton, attribute: .left, relatedBy: .equal, toItem: wormImageView, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: wormButton, attribute: .right, relatedBy: .equal, toItem: wormImageView, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: wormButton, attribute: .bottom, relatedBy: .equal, toItem: wormImageView, attribute: .bottom, multiplier: 1.0, constant: 0))
    
    //picture image view
    view.addConstraint(NSLayoutConstraint(item: pictureImageView, attribute: .top, relatedBy: .equal, toItem: inputTextField, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: pictureImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: pictureImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: wormSize/2))
    view.addConstraint(NSLayoutConstraint(item: pictureImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: wormSize/2))
    
    //background for the app
    view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
    
    //what does the worm say?
    view.addConstraint(NSLayoutConstraint(item: resultLabel, attribute: .bottom, relatedBy: .equal, toItem: wormImageView, attribute: .top, multiplier: 1.0, constant: 20))
    view.addConstraint(NSLayoutConstraint(item: resultLabel, attribute: .centerX, relatedBy: .equal, toItem: inputTextField, attribute: .centerX, multiplier: 1.0, constant: 0))
    
    //points
    view.addConstraint(NSLayoutConstraint(item: pointLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -70))
    view.addConstraint(NSLayoutConstraint(item: pointLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    
    //avatar button
    view.addConstraint(NSLayoutConstraint(item: avatarButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -10))
    view.addConstraint(NSLayoutConstraint(item: avatarButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: avatarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    view.addConstraint(NSLayoutConstraint(item: avatarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300))


  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    self.resultLabel.alpha = 0
    self.pictureImageView.alpha = 0
    self.labelWidthConstraint?.isActive = false
    self.labelHeightConstraint?.isActive = false
    
    NetworkRequest().apiCall(statement: textField.text!) { (result, url) -> Void in
      if let result = result {
        DispatchQueue.main.async {
          print(result)
          if (result == "Yes!" || result == "That's Correct!" || result == "You're right!" || result == "Emoji_100") && (textField.text!.removingWhitespaces() != self.prevInput) {
            self.count += 1
            self.prevInput = textField.text!.removingWhitespaces()
            self.pointLabel.text = "\(self.count)"
            self.userDefaults.set(self.count, forKey: "points")
          }
          if result == "Emoji_100" {
            self.resultLabel.text = "💯"
          }
          else if result == "Emoji_Poop" {
            self.resultLabel.text = "💩"
          }
          else {
            self.resultLabel.text = result
          }
          self.labelWidthConstraint = NSLayoutConstraint(item: self.resultLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.resultLabel.intrinsicContentSize.width + 40)
          self.labelHeightConstraint = NSLayoutConstraint(item: self.resultLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.resultLabel.intrinsicContentSize.height + 40)
          
          self.labelWidthConstraint?.isActive = true
          self.labelHeightConstraint?.isActive  = true
          
          self.resultLabel.layer.cornerRadius = (self.resultLabel.intrinsicContentSize.height + 40)/2
          
          UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.resultLabel.alpha = 1
          }, completion: nil)
          
          WormSpeech().speech(result: result)
          
          if url != "" {
            UIView.animate(withDuration: 0.5, delay: 3.0, options: .curveEaseOut, animations: {
              self.resultLabel.alpha = 0
            }, completion: { finished in
              if finished {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                  self.imageFromURL(url: url!)
                  self.pictureImageView.alpha = 1
                }, completion: nil)
              }
            })
          }
        }
      }
    }
    textField.resignFirstResponder()
    return true
  }
  
  @objc func wormTapped() {
    
    playSound()
    
    UIView.animate(
      withDuration: 0.15,
      delay: 0.0,
      options: .curveEaseOut,
      animations: {
        self.wormImageView.image = UIImage(named: "smile_worm")
        self.wormImageView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0)
    },
      completion: { finish in
        UIView.animate(
          withDuration: 0.15,
          delay: 0.0,
          options: .curveEaseOut,
          animations: {
            self.wormImageView.image = UIImage(named: "worm")
            self.wormImageView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        },
          completion: nil)})
  }
  
  @objc func avatarButtonTapped() {
    
    let avatarViewController = AvatarViewController()
    present(avatarViewController, animated: true, completion: nil)
  }
  
  
  
  
  
  func imageFromURL(url: String) {
    let url = URL(string: url)
    pictureImageView.kf.setImage(with: url)
    pictureImageView.alpha = 1
  }
  
  //tap on worm to make a sound
  var player: AVAudioPlayer?
  func playSound() {
    guard let url = Bundle.main.url(forResource: "bubblePop", withExtension: "wav") else { return }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      try AVAudioSession.sharedInstance().setActive(true)
      
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      
      guard let player = player else { return }
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
}

