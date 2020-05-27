//
//  String.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//


import Foundation
import AVFoundation;

extension String {
    
    func CleanUpJson(_ json: String){
        //Use the Json library to clean up the json string and to remove any double quotes if needed
    }
    
    func OutputDefaultText(_ message: String){
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        utterance.rate = 0.4;
        
        AVSpeechSynthesizer().speak(utterance);
    }
}
