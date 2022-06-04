//
//  TracksViewController.swift
//  DontecoTest
//
//  Created by Александр on 07.04.2022.
//

import UIKit

class TracksViewController: UITableViewController {
        
    var pressedBtn: UIButton?
    var playBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: .main), forCellReuseIdentifier: "Cell")
        let view = UIImageView(image: UIImage(named: "note"))
        tableView.backgroundView? = view
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.labelName.text = tracks[indexPath.row].name
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let title = tracks[indexPath.row].name
        
        let tag = pressedBtn?.tag
        
        if tag == 0 {
            
            let track = Track(name: title, indx: 0)
            
            if playTracks.count != 0 {
                playTracks.remove(at: 0)
                playTracks.insert(track, at: 0)
                
            } else {
                playTracks.insert(track, at: 0)
            }
            
        } else {
            
            let track = Track(name: title, indx: 1)
            
            if playTracks.count != 0 {
                if playTracks.count < 2 {
                    playTracks.insert(track, at: 1)
                } else {
                    playTracks.remove(at: 1)
                    playTracks.insert(track, at: 1)
                }
                
            } else {
                playTracks.insert(nil, at: 0)
                playTracks.insert(track, at: 1)
            }
        }
        
        pressedBtn!.setTitle(title, for: .normal)
        tracks[indexPath.row].indx = pressedBtn!.tag
        dismiss(animated: true, completion: nil)
        
        if playTracks.count == 2 && playTracks[0] != nil {
            playBtn!.isEnabled = true
        }
        
    }
    
}


