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
  let systemSoundID: SystemSoundID = 1305

  let wormSize = UIScreen.main.bounds.width
  var labelHeightConstraint: NSLayoutConstraint?
  var labelWidthConstraint: NSLayoutConstraint?
  var player: AVAudioPlayer?

  fileprivate let inputTextField: LWTextField = {
    let textField = LWTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "What is your question?"
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    inputTextField.delegate = self
    
    hideKeyboardWhenTappedAround()



    
  }

  private func initialize() {
    view.addSubview(backgroundImageView)
    view.addSubview(inputTextField)
    view.addSubview(wormImageView)
    view.addSubview(wormButton)
    view.addSubview(pictureImageView)
    view.addSubview(resultLabel)
    
    wormButton.addTarget(self, action: #selector(ViewController.wormTapped), for: .touchUpInside)
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

    
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    self.resultLabel.alpha = 0
    self.pictureImageView.alpha = 0
    self.labelWidthConstraint?.isActive = false
    self.labelHeightConstraint?.isActive = false
    
    apiCall(statement: textField.text!) { (result, url) -> Void in
      if let result = result {
        DispatchQueue.main.async {
          self.resultLabel.text = result
          self.labelWidthConstraint = NSLayoutConstraint(item: self.resultLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.resultLabel.intrinsicContentSize.width + 40)
          self.labelHeightConstraint = NSLayoutConstraint(item: self.resultLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.resultLabel.intrinsicContentSize.height + 40)
          
          self.labelWidthConstraint?.isActive = true
          self.labelHeightConstraint?.isActive  = true
          
          self.resultLabel.layer.cornerRadius = (self.resultLabel.intrinsicContentSize.height + 40)/2
          
          UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.resultLabel.alpha = 1
          }, completion: nil)
          
          let utterance = AVSpeechUtterance(string: result)
          var voiceToUse: AVSpeechSynthesisVoice?
          for voice in AVSpeechSynthesisVoice.speechVoices() {
            if #available(iOS 9.0, *) {
              if voice.name == "Samantha" {
                voiceToUse = voice
              }
            }
          }
          utterance.voice = voiceToUse
          utterance.pitchMultiplier = 1.3
          let synth = AVSpeechSynthesizer()
          synth.speak(utterance)
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
    //AudioServicesPlaySystemSound (systemSoundID)
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
  
  func apiCall(statement: String, completionHandler: @escaping (_ result: String?, _ url: String?) -> Void) {
    let json: [String: String] = ["statement": statement]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    let url = URL(string: "http://elbertw.pythonanywhere.com/learny/api/v1.0/eval")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = jsonData
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }
      
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      
      if let responseJSON = responseJSON as? [String: String] {
        if let url = responseJSON["url"] {
          completionHandler(responseJSON["result"], url)
          
        } else {
        completionHandler(responseJSON["result"], "")
        }
      }
    }
    task.resume()

  }
  
  func imageFromURL(url: String) {
    let url = URL(string: url)
    pictureImageView.kf.setImage(with: url)
    pictureImageView.alpha = 1
  }
  
  func playSound() {
    guard let url = Bundle.main.url(forResource: "bubblePop", withExtension: "wav") else { return }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      try AVAudioSession.sharedInstance().setActive(true)
      
      
      
      /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      
      //iOS 10 and earlier require the following line:
      //player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3.rawValue)
      
      guard let player = player else { return }
      
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
}

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}


