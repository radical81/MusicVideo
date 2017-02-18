//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Rex Jason Alobba on 10/10/16.
//  Copyright © 2016 Rex Jason Alobba. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: UIImageView!

    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell() {
        musicTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        rank.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
//        musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil {
            print("Get data from array...")
            musicImage.image = UIImage(data: video!.vImageData! as Data)
        }
        else {
            GetVideoImage(video!, imageView: musicImage)
            print("Get images in background thread")
        }
    }
    
    func GetVideoImage(_ video: Videos, imageView: UIImageView) {
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            let data = try? Data(contentsOf: URL(string: video.vImageUrl)!)
            
            var image: UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            //move back to Main Queue
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}
