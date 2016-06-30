//
//  PlaygroundViewController.swift
//  XcodeDemo
//
//  Created by Brian Hu on 5/24/16.
//  Copyright © 2016 AlphaCamp. All rights reserved.
//

import UIKit

class PlaygroundViewController: UIViewController {

    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var bigImageView: UIImageView!
    
//    let imageNames = ["coffee", "airplane"]
    var timer: NSTimer!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    @IBAction func stepperChanged(sender: AnyObject) {
        let stepper = sender as! UIStepper
        self.imageView.alpha = CGFloat(stepper.value/10)
        self.label.text = String(format: "alpha: %.02f", stepper.value)
        print(String(format: "alpha: %.20f", stepper.value/10))
    }
    @IBAction func changeName(sender: AnyObject) {
        let alert = UIAlertController(title: "Change Image", message: "please select an image", preferredStyle: .ActionSheet)
        for image in Image.images {
            let action = UIAlertAction(title: image.name, style: .Default, handler: { (UIAlertAction) in
                self.setImage(image.name)
            })
            alert.addAction(action)
        }
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressView.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func simulateLoading() {
        if self.progressView.progress == 1.0 {
            self.progressView.hidden = true
            
            self.imageView.image = UIImage(named: timer.userInfo as! String)
            self.bigImageView.image = UIImage(named: timer.userInfo as! String)
            
            timer.invalidate()
        } else {
            progressView.progress += 0.1
        }
    }
    
    func setImage(name: String) {
//        self.imageView.image = UIImage(named: name)
        self.progressView.hidden = false
        self.progressView.progress = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(PlaygroundViewController.simulateLoading), userInfo: name, repeats: true)
    }
}
