//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Rex Jason Alobba on 27/12/16.
//  Copyright © 2016 Rex Jason Alobba. All rights reserved.
//

import UIKit
import MessageUI
import LocalAuthentication

class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    @IBOutlet weak var APICnt: UILabel!
    @IBOutlet weak var imageQuality: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var touchId: UISwitch!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var numberOfVideosDisplay: UILabel!
    @IBOutlet weak var dragTheSliderDisplay: UILabel!
    @IBOutlet var securityError: UILabel!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = false
        title = "settings"
        NotificationCenter.default.addObserver(self, selector: #selector(SettingTVC.preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        setTouchIdOnOff()
        imageQuality.isOn = UserDefaults.standard.bool(forKey: "ImageQualitySetting")
        if(UserDefaults.standard.object(forKey: "APICNT") != nil) {
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
        }
    }
    
    func setTouchIdOnOff() {
        let context = LAContext()
        var touchIDError: NSError?
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
            touchId.isOn = UserDefaults.standard.bool(forKey: "SecSetting")
        }
        else {
            touchId.isEnabled = false
            //Unable to access local device authentication
            //Set the error  message with more information
            switch ((touchIDError! as! LAError).code) {
            case .touchIDNotEnrolled:
                securityError.text = "Touch ID is not enrolled"
                
            case .touchIDNotAvailable:
                securityError.text = "Touch ID is not available on the device"
            case .passcodeNotSet:
                securityError.text = "Passcode has not been set"
            case .invalidContext:
                securityError.text = "The context is invalid"
            default:
                securityError.text = "Local Authentication not available"
            }
        }
    }
    
    @IBAction func valueChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
    }
    
    @IBAction func imageQuality(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if imageQuality.isOn {
            defaults.set(imageQuality.isOn, forKey: "ImageQualitySetting")
        }
        else {
            defaults.set(false, forKey: "ImageQualitySetting")
        }
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
        numberOfVideosDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        dragTheSliderDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
        APICnt.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            }
            else {
                //No email account Setup on Phone
                mailAlert()
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func configureMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["ralobba@gmail.com"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi RJ,\n\n I would like to share the following feedback...\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailAlert() {
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No e-Mail Account setup for Phone", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) {action -> Void in
            //do something 
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Mail saved")
        case MFMailComposeResult.sent.rawValue:
            print("Mail sent")
        case MFMailComposeResult.failed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown Issue")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
}
