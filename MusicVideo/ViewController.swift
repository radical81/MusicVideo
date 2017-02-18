//
//  ViewController.swift
//  MusicVideo
//
//  Created by Rex Jason Alobba on 13/5/16.
//  Copyright © 2016 Rex Jason Alobba. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var videos = [Videos]()
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        reachabilityStatusChanged()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/genre=1622/json",
            completion: didLoadData)

    }

    func didLoadData(_ videos: [Videos]) {
        print(reachabilityStatus)
        self.videos = videos
        for item in videos {
            print("name = \(item.vName)")
        }
        myTest()
        tableView.reloadData()
    }
    
    func myTest() {
        for item in videos {
            print("Mytest - name = \(item.vName)")
        }

        for (index, item) in videos.enumerated() {
            print("\(index) name = \(item.vName)")
        }
//        for i in 0..<videos.count {
//            let video = videos[i]
//            print("\(i) name = \(video.vName)")
//        }
    }
    
    func reachabilityStatusChanged()
    {
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.red
            displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.green
            displayLabel.text = "Reachable with WIFI"
        case WWAN: view.backgroundColor = UIColor.yellow
            displayLabel.text = "Reachable with Cellular"
        default: return
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        return cell
    }
}

