//
//  ViewController.swift
//  VocalTextEdit
//
//  Created by Hans Yelek on 1/28/16.
//  Copyright © 2016 Hans Yelek. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSSpeechSynthesizerDelegate {
    
    let speechSynthesizer = NSSpeechSynthesizer()
    

    @IBOutlet var textView: NSTextView!
    
    // Add properties for "speak" and "stop" buttons
    // Link to views in Interface Builder
    @IBOutlet var speakButton: NSButton!
    @IBOutlet var stopButton: NSButton!
    
    var contents: String? {
        get {
            return textView.string
        }
        set {
            textView.string = newValue
        }
    }
    
    @IBAction func speakButtonClicked(sender: NSButton) {
        if let contents = textView.string where !contents.isEmpty {
            speechSynthesizer.startSpeakingString(contents)
        } else {
            speechSynthesizer.startSpeakingString("The document is empty.")
        }
        
        speakButton.enabled = false
        stopButton.enabled = true
        
        // Assign delegate for speechSynthesizer if it is not already
        guard speechSynthesizer.delegate != nil else {
            speechSynthesizer.delegate = self
            return
        }
    }
    
    @IBAction func stopButtonClicked(sender: NSButton) {
        speechSynthesizer.stopSpeaking()
        
        stopButton.enabled = false
        speakButton.enabled = true
    }
    
    
    // PROTOCOL: NSSpeechSynthesizerDelegate
    
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        stopButton.enabled = false
        speakButton.enabled = true
    }
}

