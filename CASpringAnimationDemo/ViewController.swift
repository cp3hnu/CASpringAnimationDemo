//
//  ViewController.swift
//  CASpringAnimationDemo
//
//  Created by CP3 on 15/10/17.
//  Copyright © 2015年 CP3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var redView: UIView!
    var startButton :UIButton!
    var massLabel: UILabel!
    var stiffnessLabel: UILabel!
    var dampingLabel: UILabel!
    var velocityLabel: UILabel!
    var massSlider: UISlider!
    var stiffnessSlider: UISlider!
    var dampingSlider: UISlider!
    var velocitySlider: UISlider!
    var animation :CASpringAnimation!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let width = self.view.bounds.size.width
        
        let grayView = UIView(frame: CGRectMake(220, 50, 100, 100))
        grayView.backgroundColor = UIColor.lightGrayColor()
        grayView.alpha = 0.5
        self.view.addSubview(grayView)
        
        redView = UIView(frame: CGRectMake(20, 50, 100, 100))
        redView.backgroundColor = UIColor.redColor()
        self.view.addSubview(redView)
        
        var offset: CGFloat = 200.0
        startButton = UIButton(type: .Custom)
        startButton.frame = CGRectMake(20, offset, width - 40, 30)
        startButton.setTitle("Start animation", forState:.Normal)
        startButton.setTitleColor(self.view.tintColor, forState: .Normal)
        startButton.setTitleColor(UIColor.grayColor(), forState: .Disabled)
        startButton.addTarget(self, action: "startAnimation", forControlEvents: .TouchUpInside)
        self.view.addSubview(startButton)
        
        offset += 50
        let resetButton = UIButton(type: .Custom)
        resetButton.frame = CGRectMake(20, offset, width - 40, 30)
        resetButton.setTitle("Reset property", forState:.Normal)
        resetButton.setTitleColor(self.view.tintColor, forState: .Normal)
        resetButton.addTarget(self, action: "reset", forControlEvents: .TouchUpInside)
        self.view.addSubview(resetButton)
        
        offset += CGFloat(50.0)
        massLabel = UILabel(frame: CGRectMake(20, offset, width - 40, 20))
        massLabel.textColor = UIColor.blackColor()
        massLabel.textAlignment = .Center
        massLabel.text = "mass:1"
        self.view.addSubview(massLabel)
        
        offset += CGFloat(30.0)
        massSlider = UISlider(frame: CGRectMake(50, offset, width - 100, 20))
        massSlider.minimumValue = 0
        massSlider.maximumValue = 10
        massSlider.value = 1
        massSlider.addTarget(self, action: "mass:", forControlEvents: .ValueChanged)
        self.view.addSubview(massSlider)
        
        offset += CGFloat(50.0)
        stiffnessLabel = UILabel(frame: CGRectMake(20, offset, width - 40, 20))
        stiffnessLabel.textColor = UIColor.blackColor()
        stiffnessLabel.textAlignment = .Center
        stiffnessLabel.text = "stiffness:100"
        self.view.addSubview(stiffnessLabel)
        
        offset += CGFloat(30.0)
        stiffnessSlider = UISlider(frame: CGRectMake(50, offset, width - 100, 20))
        stiffnessSlider.minimumValue = 50
        stiffnessSlider.maximumValue = 150
        stiffnessSlider.value = 100
        stiffnessSlider.addTarget(self, action: "stiffness:", forControlEvents: .ValueChanged)
        self.view.addSubview(stiffnessSlider)
        
        offset += CGFloat(50.0)
        dampingLabel = UILabel(frame: CGRectMake(20, offset, width - 40, 20))
        dampingLabel.textColor = UIColor.blackColor()
        dampingLabel.textAlignment = .Center
        dampingLabel.text = "damping:10"
        self.view.addSubview(dampingLabel)
        
        offset += CGFloat(30.0)
        dampingSlider = UISlider(frame: CGRectMake(50, offset, width - 100, 20))
        dampingSlider.minimumValue = 0
        dampingSlider.maximumValue = 100
        dampingSlider.value = 10
        dampingSlider.addTarget(self, action: "damping:", forControlEvents: .ValueChanged)
        self.view.addSubview(dampingSlider)
        
        offset += CGFloat(50.0)
        velocityLabel = UILabel(frame: CGRectMake(20, offset, width - 40, 20))
        velocityLabel.textColor = UIColor.blackColor()
        velocityLabel.textAlignment = .Center
        velocityLabel.text = "initialVelocity:0"
        self.view.addSubview(velocityLabel)
        
        offset += CGFloat(30.0)
        velocitySlider = UISlider(frame: CGRectMake(50, offset, width - 100, 20))
        velocitySlider.minimumValue = -10
        velocitySlider.maximumValue = 10
        velocitySlider.value = 0
        velocitySlider.addTarget(self, action: "velocity:", forControlEvents: .ValueChanged)
        self.view.addSubview(velocitySlider)
        
        animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = 70.0
        animation.toValue = 270
        animation.delegate = self
    }
    
    func startAnimation() {
        
        animation.duration = max(1.0, animation.settlingDuration)
        
        print("animation:\(animation.settlingDuration)")
        
        redView.layer.addAnimation(animation, forKey: "positionKey")
    }
    
    func reset() {
        massSlider.value = 1.0
        stiffnessSlider.value = 100
        dampingSlider.value = 10.0
        velocitySlider.value = 0.0
        
        massLabel.text = "mass:1"
        stiffnessLabel.text = "stiffness:100"
        dampingLabel.text = "damping:10"
        velocityLabel.text = "initialVelocity:0"
        
        animation.mass = 1.0
        animation.stiffness = 100.0
        animation.damping = 10.0
        animation.initialVelocity = 0.0
    }
    
    override func animationDidStart(anim: CAAnimation) {
        startButton.enabled = false
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        startButton.enabled = true
    }
    
    func mass(slider: UISlider) {
        animation.mass = CGFloat(slider.value)
        massLabel.text = "mass:\(slider.value)"
        if slider.value == 0 {
           massLabel.text = "mass:\(slider.value)(Note:Must be greater than 0)"
        }
    }
    
    func stiffness(slider: UISlider) {
        animation.stiffness = CGFloat(slider.value)
        stiffnessLabel.text = "stiffness:\(slider.value)"
    }
    
    func damping(slider: UISlider) {
        animation.damping = CGFloat(slider.value)
        dampingLabel.text = "damping:\(slider.value)"
    }
    
    func velocity(slider: UISlider) {
        animation.initialVelocity = CGFloat(slider.value)
        velocityLabel.text = "initialVelocity:\(slider.value)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

