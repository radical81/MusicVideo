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
        NotificationCenter.default.addObserver(self, selector: #selector(SettingTVC.preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        touchId.isOn = UserDefaults.standard.bool(forKey: "SecSetting")
        
        if(UserDefaults.standard.object(forKey: "APICNT") != nil) {
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        }
    }
    
    @IBAction func valueChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
    }
    
    @IBAction func touchIdSecurity(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if touchId.isOn {
            defaults.set(touchId.isOn, forKey: "SecSetting")
        }
        else {
            defaults.set(false, forKey: "SecSetting")
        }
    }
    
    func preferredFontChanged() {
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        feedbackDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        securityDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        APICnt.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
}
