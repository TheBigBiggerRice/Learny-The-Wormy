//
//  WormSpeech.swift
//  LearnyTheWormy
//
//  Created by Chenyang Zhang on 10/28/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation
import AVFoundation
class WormSpeech {
  func speech(result: String) {
    var utterance: AVSpeechUtterance
    if result == "Emoji_100" {
      utterance = AVSpeechUtterance(string: "full points")
    }
    else if result == "Emoji_Poop" {
      utterance = AVSpeechUtterance(string: "try again")

    }
    else {
      utterance = AVSpeechUtterance(string: result)
    }
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
    
  }
}
