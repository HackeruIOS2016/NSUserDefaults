//
//  RegistrationViewController.swift
//  NSUserDefaultsDemo
//
//  Created by HackerU on 19/05/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        let pickerVc = UIImagePickerController()
        pickerVc.sourceType = .PhotoLibrary
        pickerVc.delegate = self
        presentViewController(pickerVc, animated: true, completion: nil)
    }
    
    @IBAction func btnSaveTapped(sender: UIButton) {
        if let userName = firstNameTextField.text where firstNameTextField.text?.characters.count > 2,
            let lastName = lastNameTextField.text,
            let image = imageView.image,
            let pngData = UIImagePNGRepresentation(image){
                
                let mood:String?
                switch moodSegmentedControl.selectedSegmentIndex{
                case 0:
                    mood = "Happy"
                case 1:
                    mood = "Sad"
                case 2:
                    mood = "Meh"
                default:
                    mood = nil
                }
                
                defaults.setObject(userName, forKey: "userName")
                defaults.setObject(lastName, forKey: "lastName")
                defaults.setObject(pngData, forKey: "imageData")
                defaults.setObject(mood, forKey: "Mood")
                
                firstNameTextField.text = ""
                lastNameTextField.text = ""
                imageView.image = nil
        }
    }
    
    @IBAction func btnReloadTapped(sender: UIButton) {
        let userName = defaults.stringForKey("userName")
        let lastName = defaults.stringForKey("lastName")
        guard let imageData = defaults.dataForKey("imageData") else{return}
        let mood = defaults.stringForKey( "Mood")
        
        firstNameTextField.text = userName
        lastNameTextField.text = lastName
        imageView.image = UIImage(data: imageData)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Show Login \(defaults.boolForKey("showLogin"))")
         print("Mood \(defaults.integerForKey("mood"))")
        
        // Do any additional setup after loading the view.
    }
    
 
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}


extension RegistrationViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
}