//
//  SpeechHelper.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 26/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import AVFoundation;

internal class SpeechHelper {
    public static func OutputFrenchText(_ message: String) -> Void {
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "fr")
        utterance.rate = 0.4;
        
        AVSpeechSynthesizer().speak(utterance);
    }
    
    public static func OutputDefaultText(_ message: String){
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        utterance.rate = 0.4;
        
        AVSpeechSynthesizer().speak(utterance);
    }
}
