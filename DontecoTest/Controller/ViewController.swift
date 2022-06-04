//
//  ViewController.swift
//  DontecoTest
//
//  Created by Александр on 05.04.2022.
//

import UIKit
import AVFoundation
import Cephalopod

class ViewController: UIViewController {
    
    
    @IBOutlet weak var fadeSlider: UISlider!
    @IBOutlet weak var curLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var player: [AVAudioPlayer?] = [AVAudioPlayer()]
    var currentTimer: [Timer] = [Timer()]
    var cephalopod: Cephalopod?
    
    var secondsPassed: [Int] = []
    var totalTime = 0.0
    var faderTime = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fadeSlider.minimumTrackTintColor = UIColor(named: "Light")
        fadeSlider.maximumTrackTintColor = UIColor(named: "Dark")
    }
    
    @IBAction func sliderAction(_ sender: Any) {
        let slider = sender as! UISlider
        curLabel.text = String(Int(slider.value))
        faderTime = Int(slider.value)
    }
    
    @IBAction func chooseTrack(_ sender: UIButton) {
        let detailVC = TracksViewController(nibName: "TracksViewController", bundle: .main)
        detailVC.playBtn = playButton
        detailVC.pressedBtn = sender
        present(detailVC, animated: true, completion: nil)
    }
    
    
    @IBAction func playOrStopTrack(_ sender: UIButton) {
        
        let stopTitle = NSAttributedString(string: "Stop",
                                           attributes: [NSAttributedString.Key.font : UIFont(name: "Tomatoes", size: 30)!])
        let playTitle = NSAttributedString(string: "Play",
                                           attributes: [NSAttributedString.Key.font : UIFont(name: "Tomatoes", size: 30)!])
        
        if sender.titleLabel?.text == "Play" {
            sender.setTitle("Stop", for: .normal)
            playButton.setAttributedTitle(stopTitle, for: .normal)
            fadeSlider.isEnabled = false
            playTrack(playTracks[0]!)
            
        } else {
            for i in 0...player.count - 1 {
                player[i]?.stop()
                currentTimer[i].invalidate()
                secondsPassed[i] = 0
            }
            fadeSlider.isEnabled = true
            playButton.setAttributedTitle(playTitle, for: .normal)
        }
    }
    
    @objc func updateTimer(timer: Timer) {
        
        let currentTrack = timer.userInfo as! Track
        let currentTimer = currentTimer[currentTrack.indx]
        let indxPlayer = currentTrack.indx
        
        if secondsPassed.isEmpty {
            secondsPassed.append(0)
        } else if secondsPassed.count < indxPlayer + 1 {
            secondsPassed.append(0)
        }
        
        if secondsPassed[indxPlayer] < Int(totalTime) {
            secondsPassed[indxPlayer] += 1
            
            if Int(player[indxPlayer]!.currentTime) == Int(player[indxPlayer]!.duration) - faderTime {
                cephalopod = Cephalopod(player: player[indxPlayer]!)
                cephalopod?.fadeOut(duration: Double(faderTime), velocity: 5)
                
                if currentTrack == playTracks[0] {
                    playTrack(playTracks[1]!)
                } else {
                    playTrack(playTracks[0]!)
                }
                
            }
            
        }  else {
            secondsPassed[indxPlayer] = 0
            currentTimer.invalidate()
        }
    }
    
    private func playTrack(_ track: Track) {
        
        let idx = track.indx
        
        let url = Bundle.main.url(forResource: track.name, withExtension: "mp3")!
        
        if currentTimer.count < idx + 1 {
            currentTimer.append(Timer())
        }
        
        currentTimer[idx] = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: track, repeats: true)
        
        do {
            
            if player.count < idx + 1 {
                player.append(AVAudioPlayer())
            }
            
            player[idx] = try AVAudioPlayer(contentsOf: url)
            if Int(player[idx]!.duration) < faderTime {
                faderTime = Int(player[idx]!.duration) - 1
            }
            
            player[idx]!.play()
            totalTime = player[idx]!.duration
            cephalopod?.fadeIn(duration: Double(faderTime), velocity: 5)
            currentTimer[idx].fire()
            
        } catch {
            print("couldn't load the player")
        }
        
    }
    
}





