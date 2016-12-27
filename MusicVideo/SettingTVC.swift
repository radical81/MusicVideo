//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Rex Jason Alobba on 27/12/16.
//  Copyright © 2016 Rex Jason Alobba. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {

    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    @IBOutlet weak var APICnt: UILabel!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var touchId: UISwitch!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)

    }
    
    func preferredFontChanged() {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
}
