//
//  ViewController.swift
//  NSUserDefaultsDemo
//
//  Created by HackerU on 19/05/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func btnSaveTapped(sender: UIButton) {
        let text = textView.text
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(text, forKey: "Note")
        saveImage()
    }
    @IBOutlet weak var textView: UITextView!{
        didSet{
            //textView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        let text = defaults.stringForKey("Note")
        textView.text = text
        
        guard let imageData = defaults.dataForKey("bg_image") else {return}
        
        let image = UIImage(data: imageData)
        imageView.image = image
        
    }
    
    func saveImage(){
        let pumpkin = UIImage(named: "pumpkin")!
        let imageData = UIImagePNGRepresentation(pumpkin)
        //let data = UIImageJPEGRepresentation(pumpkin, 100)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(imageData, forKey: "bg_image")
    }
    
}

