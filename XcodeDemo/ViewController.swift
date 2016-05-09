//
//  ViewController.swift
//  XcodeDemo
//
//  Created by Brian Hu on 4/25/16.
//  Copyright © 2016 Alphacmap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: NSTimer!
    let imageNames = ["rabbit", "desert", "airplane"]
    
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var label: UILabel!

    @IBAction func stepperChanged(sender: AnyObject) {
        let stepper = sender as! UIStepper
        self.imageView.alpha = CGFloat(stepper.value / 10)
        self.label.text = String(format: "alpha: %.02f", stepper.value / 10)
    }
    
    @IBAction func sliderChangged(sender: AnyObject) {
        let slider = sender as! UISlider
        self.imageView.alpha = CGFloat(slider.value)
        self.label.text = String(format: "alpha: %.02f", slider.value)
    }
    
    @IBAction func changeImage(sender: AnyObject) {
        let alert = UIAlertController(title: "Change Image", message: "plase select an image", preferredStyle: .ActionSheet)
        for name: String in imageNames {
            let action = UIAlertAction(title: name, style: .Default, handler: { (UIAlertAction) in
                self.setImage(name)
            })
            alert.addAction(action)
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func simulateLoading() {
        if progressView.progress == 1.0 {
            progressView.hidden = true
            self.imageView.image = UIImage(named: timer.userInfo as! String)
            self.bigImageView.image = UIImage(named: timer.userInfo as! String)
            timer.invalidate()
        } else {
            progressView.progress += 0.1
        }
    }
    
    func setImage(name: String) {
        progressView.hidden = false
        progressView.progress = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.simulateLoading), userInfo: name, repeats: true)
    }
}

