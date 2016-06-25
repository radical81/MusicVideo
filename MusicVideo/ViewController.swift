//
//  ViewController.swift
//  MusicVideo
//
//  Created by Rex Jason Alobba on 13/5/16.
//  Copyright © 2016 Rex Jason Alobba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/genre=1622/json") {
            (result: String) in
            let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default) {
                action -> Void in
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }

//    func didLoadData(result: String) {
//        print(result)
//    }


}

