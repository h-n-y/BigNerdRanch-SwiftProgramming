/*
    CHAPTER 26 - GOLD CHALLENGE

    My solution uses the speechSynthesizer(_:willSpeakWord:ofString:)
    method from the NSSpeechSynthesizerDelegate protocol to keep a rough
    estimate of how much speaking has been completed. 
*/

import Cocoa

class ViewController: NSViewController, NSSpeechSynthesizerDelegate {
    
    let speechSynthesizer = NSSpeechSynthesizer()
    

    @IBOutlet var textView: NSTextView!
    
    // Add properties for "speak" and "stop" buttons
    // Link to views in Interface Builder
    @IBOutlet var speakButton: NSButton!
    @IBOutlet var stopButton: NSButton!
    
    @IBOutlet var progressIndicator: NSProgressIndicator!
    
    var contents: String? {
        get {
            return textView.string
        }
        set {
            textView.string = newValue
        }
    }
    
    func showProgressIndicator() {
        progressIndicator.doubleValue = 0.0
        progressIndicator.hidden = false
    }
    
    func hideProgressIndicator() {
        progressIndicator.hidden = true
    }
    
    @IBAction func speakButtonClicked(sender: NSButton) {
        
        // Assign delegate for speechSynthesizer if it is not already
        if speechSynthesizer.delegate == nil {
            speechSynthesizer.delegate = self
        }
        
        if let contents = textView.string where !contents.isEmpty {
            speechSynthesizer.startSpeakingString(contents)
        } else {
            speechSynthesizer.startSpeakingString("The document is empty.")
        }
        
        // Buttons
        speakButton.enabled = false
        stopButton.enabled = true
        
        // Progress Indicator
        //
        // Calling hideProgressIndicator() here somehow resolves a bug where
        // the *progressIndicator* view is not visible after the first time
        // the *speakButton* is clicked, but is visible on subsequent clicks...
        hideProgressIndicator()
        showProgressIndicator()
    }
    
    @IBAction func stopButtonClicked(sender: NSButton) {
        speechSynthesizer.stopSpeaking()
        
        // Buttons
        stopButton.enabled = false
        speakButton.enabled = true
        
        // Progress Indicator
        hideProgressIndicator()
    }
    
    
    // PROTOCOL: NSSpeechSynthesizerDelegate
    
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        
        // Buttons
        stopButton.enabled = false
        speakButton.enabled = true
        
        // Progress Indicator
        hideProgressIndicator()
    }
    
    func speechSynthesizer(sender: NSSpeechSynthesizer, willSpeakWord characterRange: NSRange, ofString string: String) {
        
        let progress: Double = 100 * ( Double(characterRange.location) / Double(string.characters.count) )
        progressIndicator.doubleValue = progress
    }
}

