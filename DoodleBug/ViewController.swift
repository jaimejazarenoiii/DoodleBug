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
    
    var lastPoint = CGPoint.zero
    var swiped = false

    var red :CGFloat = 0.0
    var green :CGFloat = 0.0
    var blue :CGFloat = 0.0
    var lineWidth :CGFloat = 5
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
    }
    
    func drawLine(_ fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setLineCap(CGLineCap.round)
        
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1)
        context?.setBlendMode(CGBlendMode.normal)
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
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
    @IBAction func reset(_ sender: Any) {
        imageView.image = nil
        
    }
    
    
    
    
    
    


}

