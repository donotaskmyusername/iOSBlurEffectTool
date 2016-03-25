//
//  ViewController.swift
//  BlurEffect
//
//  Created by bear on 16/3/24.
//  Copyright © 2016年 bear. All rights reserved.
//

import UIKit

enum BlurType {
    case Light
    case ExtraLight
    case Dark
    case Custom
}

class ViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var saturationSlider: UISlider!
    @IBOutlet var saturationLabel: UILabel!
    @IBOutlet var boxSizeSlider: UISlider!
    @IBOutlet var boxSizeLabel: UILabel!
    @IBOutlet var whiteSlider: UISlider!
    @IBOutlet var whiteLabel: UILabel!
    @IBOutlet var alphaSlider: UISlider!
    @IBOutlet var alphaLabel: UILabel!
    
    @IBOutlet var colorSwitch: UISwitch!
    
    private var originialImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originialImage = backgroundImageView.image
        saturationLabel.text = "Saturation \(saturationSlider.value)"
        boxSizeLabel.text = "BoxSize \(boxSizeSlider.value)"
        whiteLabel.text = "White \(whiteSlider.value)"
        alphaLabel.text = "\(alphaSlider.value)"
    }
    
    private func applyBlurOfType(type:BlurType) {
        guard let image = originialImage else { return }
        
        var blurred: UIImage
        switch type {
        case .Light:
            blurred = image.lightImage()
        case .ExtraLight:
            blurred = image.extraLightImage()
        case .Dark:
            blurred = image.darkImage()
        case .Custom:
            let size = CGFloat(boxSizeSlider.value)
            let white = CGFloat(whiteSlider.value)
            let alpha = CGFloat(alphaSlider.value)
            let saturation = CGFloat(saturationSlider.value)
            var color:UIColor? = nil
            if colorSwitch.on {
                color = UIColor(white: white, alpha: alpha)
            }
            blurred = image.blurredImageWithSize(CGSizeMake(size, size), tintColor: color, saturationDeltaFactor: saturation, maskImage: nil)
        }
        backgroundImageView.image = blurred
    }
    
    @IBAction func onSegmentControlValueChanged() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            applyBlurOfType(.Light)
        case 1:
            applyBlurOfType(.ExtraLight)
        case 2:
            applyBlurOfType(.Dark)
        default:
            applyBlurOfType(.Custom)
        }
    }
    
    private func onCustomValueChanged() {
        guard segmentControl.selectedSegmentIndex == 3 else { return }
        applyBlurOfType(.Custom)
    }
    
    @IBAction func onSaturationSliderChanged() {
        onCustomValueChanged()
        saturationLabel.text = "Saturation \(saturationSlider.value)"
    }
    
    @IBAction func onBoxSizeSliderChanged() {
        onCustomValueChanged()
        boxSizeLabel.text = "BoxSize \(boxSizeSlider.value)"
    }
    
    @IBAction func onWhiteSliderChanged() {
        onCustomValueChanged()
        whiteLabel.text = "White \(whiteSlider.value)"
    }
    
    @IBAction func onAlphaSliderChanged() {
        onCustomValueChanged()
        alphaLabel.text = "\(alphaSlider.value)"
    }
    
    @IBAction func onSwitchChanged() {
        onCustomValueChanged()
    }
    
    @IBAction func onRestoreButtonPressed() {
        segmentControl.selectedSegmentIndex = -1
        backgroundImageView.image = originialImage
    }
}

