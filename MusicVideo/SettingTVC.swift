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
        title = "settings"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        touchId.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        }
    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
    }
    
    @IBAction func touchIdSecurity(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchId.on {
            defaults.setBool(touchId.on, forKey: "SecSetting")
        }
        else {
            defaults.setBool(false, forKey: "SecSetting")
        }
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
