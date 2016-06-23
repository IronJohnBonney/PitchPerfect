//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Stephen Looney on 1/29/16.
//  Copyright © 2016 SpaceBoat Development. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer = AVAudioPlayer()
    var movieQuote:NSURL!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        //movieQuote = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl)
            print("proceeding to initialize audio player")
            audioPlayer.stop()
            audioPlayer.prepareToPlay()
            audioPlayer.enableRate = true
        } catch {
            print ("Error getting the audio file")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        
        /*
        print("\(movieQuote)")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL:movieQuote)
            print("proceeding to initialize audio player")
            audioPlayer.stop()
            audioPlayer.prepareToPlay()
            audioPlayer.enableRate = true
            audioPlayer.rate = 0.5
            audioPlayer.play()
        } catch {
            print ("Error getting the audio file")
        }

        */
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
        
    }
    
    @IBAction func playFast(sender: UIButton) {
        /*
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL:movieQuote)
            print("proceeding to initialize audio player")
            audioPlayer.stop()
            audioPlayer.prepareToPlay()
            audioPlayer.enableRate = true
            audioPlayer.rate = 2.0
            audioPlayer.play()
        } catch {
            print ("Error getting the audio file")
        }
*/
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    @IBAction func stopPlayback(sender: UIButton) {
        audioPlayer.stop()
        print("stopped audio playback")
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
