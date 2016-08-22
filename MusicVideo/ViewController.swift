//
//  ViewController.swift
//  MusicVideo
//
//  Created by Rex Jason Alobba on 13/5/16.
//  Copyright © 2016 Rex Jason Alobba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/genre=1622/json",
            completion: didLoadData)

    }

    func didLoadData(videos: [Videos]) {
        print(reachabilityStatus)
        self.videos = videos
        for item in videos {
            print("name = \(item.vName)")
        }
        myTest()
    }
    
    func myTest() {
        for item in videos {
            print("Mytest - name = \(item.vName)")
        }

        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
//        for i in 0..<videos.count {
//            let video = videos[i]
//            print("\(i) name = \(video.vName)")
//        }
    }


}

