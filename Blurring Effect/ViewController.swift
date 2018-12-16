//
//  ViewController.swift
//  Blurring Effect
//
//  Created by Charles Martin Reed on 12/15/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Instance properties
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Baby_Hedgehog"))
    let visualEffectView = UIVisualEffectView(effect: nil)
    
    //UIViewPropertyAnimator instance
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCenteredImageView()
        
        setupVisualBlurEffectView()
        
        setupSlider()
        
        animator.addAnimations {
            //our animation has two stages, scaling the image and increasing the blur
            //1
            self.imageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            //2
            self.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
        
        //tap on the screen
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    //MARK:- Handler methods
    @objc func handleTap() {
        //why property animator? Because it's hard to gt at the middle values with UIView.animate, 0.5, 0.25, etc.
        UIView.animate(withDuration: 1) {
            print("tapped view")
            //self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)  //default value is 1, this will double size
        }
    }
    
    @objc fileprivate func handleSliderChanged(_ slider: UISlider) {
        //modify the animator with the slider value - 0 is the original state, 1.0 means the animation is in its fully completed state. See animator.addAnimations() for details.
        print("Slider value: \(slider.value)")
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    //MARK:- View setup methods
    
    fileprivate func setupCenteredImageView() {
        //during refactor, use autolayout to place this properly
        //Brian actually created an extension to UIView that handles anchoring. This might be a good idea!
        //https://youtu.be/iqpAP7s3b-8 -video on making Extensions for Auto Layout
        
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.center = view.center
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
    }
    
    fileprivate func setupSlider() {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        //slider.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        //when you refactor this one, anchor to the image view instead of the
        let sliderConstraints = [slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16), slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16), slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)]
        NSLayoutConstraint.activate(sliderConstraints)
        
        //get the value from the passed slider
        slider.addTarget(self, action: #selector(handleSliderChanged), for: .valueChanged)
    }
    
    fileprivate func setupVisualBlurEffectView() {
        //let blurEffect = UIBlurEffect(style: .regular)
        
        view.addSubview(visualEffectView)
        
        //define the visual effect frame - this will not affect the slider itself because we setup the visual effect view before the slider in viewDidLoad
        visualEffectView.frame = view.frame
    }


}

