//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Rex Jason Alobba on 22/11/16.
//  Copyright © 2016 Rex Jason Alobba. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideoDetailVC: UIViewController {

    var videos: Videos!
    
    var sec:Bool = false
    
    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vRights: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sec = UserDefaults.standard.bool(forKey: "SecSetting")
        
        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData! as Data)
        }
        else {
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
    }
    
    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        let url = URL(string: videos.vVideoUrl)!
        
        let player = AVPlayer(url: url as URL)
        
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
}
