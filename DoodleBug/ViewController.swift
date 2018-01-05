//
//  ViewController.swift
//  DoodleBug
//
//  Created by Jaime Jazareno III on 04/01/2018.
//  Copyright © 2018 Jaime Jazareno III. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var smallButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var preSetStack: UIStackView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var lastPoint = CGPoint.zero
    var swiped = false

    var red :CGFloat = 0.0
    var green :CGFloat = 0.0
    var blue :CGFloat = 0.0
    var lineWidth :CGFloat = 5
    var alpha :CGFloat = 1
    var hideState = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        
        if let touch = touches.first as UITouch! {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first as UITouch! {
            let currentPoint = touch.location(in: view)
            
            drawLine(lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            drawLine(lastPoint, toPoint: lastPoint)
        }
        UIGraphicsBeginImageContext(secondImage.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        secondImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: alpha)
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        secondImage.image = nil
        
    }
    
    func drawLine(_ fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        secondImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setLineCap(CGLineCap.round)
        
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
        context?.setBlendMode(CGBlendMode.normal)
        context?.strokePath()
        
        secondImage.image = UIGraphicsGetImageFromCurrentImageContext()
        secondImage.alpha = alpha
        UIGraphicsEndImageContext()
    }
    
    @IBAction func red(_ sender: Any) {
        (red, green, blue) = (255.0, 0.0, 0.0)
        
    }
    @IBAction func green(_ sender: Any) {
        (red, green, blue) = (0.0, 255.0, 0.0)
        
    }
    @IBAction func blue(_ sender: Any) {
        (red, green, blue) = (0.0, 0.0, 255.0)
        
    }
    @IBAction func black(_ sender: Any) {
        (red, green, blue) = (0.0, 0.0, 0.0)
        
    }
    @IBAction func white(_ sender: Any) {
        (red, green, blue) = (255.0, 255.0, 255.0)
        
    }
    @IBAction func large(_ sender: Any) {
        smallButton.isEnabled = true
        smallButton.alpha = 1
        if lineWidth < 100 {
            lineWidth += 1
            label.text = String(format: "%.0f", lineWidth)
            largeButton.isEnabled = true
            largeButton.alpha = 1
        }
        else {
            largeButton.isEnabled = false
            largeButton.alpha = 0.25
        }
        
        
    }
    @IBAction func small(_ sender: Any) {
        largeButton.isEnabled = true
        largeButton.alpha = 1
        if lineWidth > 0 {
            lineWidth -= 1
            label.text = String(format: "%.0f", lineWidth)
            smallButton.isEnabled = true
            smallButton.alpha = 1
        }
        else{
            smallButton.isEnabled = false
            smallButton.alpha = 0.25
        }
    }
    @IBAction func save(_ sender: Any) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        present(activity, animated: true, completion: nil)
    }
    
    func brushSize() {
        label.text = String(format: "%.0f", lineWidth)
        
        if lineWidth == 100 {
            largeButton.isEnabled = false
            largeButton.alpha = 0.25
            
        } else if lineWidth == 1 {
            smallButton.isEnabled = false
            smallButton.alpha = 0.25
        }
        else{
            smallButton.isEnabled = true
            smallButton.alpha = 1
            largeButton.isEnabled = true
            largeButton.alpha = 1
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        imageView.image = nil
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.delegate = self
        settingsViewController.brushWidth = lineWidth
        settingsViewController.red = red
        settingsViewController.green = green
        settingsViewController.blue = blue
        settingsViewController.opacity = alpha
    }
    
    
    @IBAction func hide(_ sender: Any) {
        if hideState == false {
            preSetStack.isHidden = true
            resetButton.isHidden = true
            settingsButton.isHidden = true
            saveButton.isHidden = true
            hideButton.setTitle("Show", for: UIControlState.normal)
            hideButton.alpha = 0.2
        }
        else{
            preSetStack.isHidden = false
            resetButton.isHidden = false
            settingsButton.isHidden = false
            saveButton.isHidden = false
            hideButton.alpha = 1
            hideButton.setTitle("Hide", for: UIControlState.normal)
        }
        
        hideState = !hideState
    }
    
}

extension ViewController: SettingsViewControllerDelegate {
    func settingViewControllerFinished(_ settingsViewController: SettingsViewController) {
        self.lineWidth = settingsViewController.brushWidth
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
        self.alpha = settingsViewController.opacity

        self.brushSize()
    }
}

