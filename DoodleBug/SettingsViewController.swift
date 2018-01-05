//
//  SettingsViewController.swift
//  DoodleBug
//
//  Created by Jaime Jazareno III on 05/01/2018.
//  Copyright © 2018 Jaime Jazareno III. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingViewControllerFinished(_ settingsViewController: SettingsViewController)
}

class SettingsViewController: UIViewController {
    
    var delegate :SettingsViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var brushSlider: UISlider!
    @IBOutlet weak var brushLabel: UILabel!
    
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var opacityLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    var brushWidth :CGFloat = 5.0
    
    var opacity :CGFloat = 1.0
    
    var red :CGFloat = 0.0
    var green :CGFloat = 0.0
    var blue :CGFloat = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        brushLabel.text = String(format: "Brush Size: %.0f", Float(brushWidth))
        brushSlider.value = Float(brushWidth)

        redSlider.value = Float(red * 255)
        redLabel.text = String(format: "%.0f", Float(redSlider.value))
        
        greenSlider.value = Float(green * 255)
        greenLabel.text = String(format: "%.0f", Float(greenSlider.value))
        
        blueSlider.value = Float(blue * 255)
        blueLabel.text = String(format: "%.0f", Float(blueSlider.value))
        
        opacitySlider.value = Float(opacity)
        opacityLabel.text = String(format: "Opacity: %.1f", Float(opacitySlider.value))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.updatePreview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.settingViewControllerFinished(self)
    }
    
    @IBAction func brushSize(_ sender: Any) {
        brushWidth = CGFloat(round(brushSlider.value))
        brushLabel.text = String(format: "Brush Size: %.0f", Float(brushWidth))
        self.updatePreview()
    }
    
    
    @IBAction func opacityChange(_ sender: Any) {
        opacity = CGFloat(opacitySlider.value)
        opacityLabel.text = String(format: "Opacity: %.1f", Float(opacity))
        self.updatePreview()
    }
    
    @IBAction func redColour(_ sender: Any) {
        red = CGFloat(redSlider.value / 255)
        redLabel.text = String(format: "%.0f", redSlider.value)
        self.updatePreview()
    }
    
    @IBAction func greenColour(_ sender: Any) {
        green = CGFloat(greenSlider.value / 255)
        greenLabel.text = String(format: "%.0f", greenSlider.value)
        self.updatePreview()
    }
    
    @IBAction func blueColour(_ sender: Any) {
        blue = CGFloat(blueSlider.value / 255)
        blueLabel.text = String(format: "%.0f", blueSlider.value)
        self.updatePreview()
    }
    
    
    func updatePreview() {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
     
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity)
        
        context?.move(to: CGPoint(x: 110.0, y: 110.0))
        context?.addLine(to: CGPoint(x: 110.0, y: 110.0))
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
}
