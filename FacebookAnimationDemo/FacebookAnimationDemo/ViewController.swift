//
//  ViewController.swift
//  FacebookAnimationDemo
//
//  Created by Ankit Jaiswal on 23/01/19.
//  Copyright © 2019 Ankit Jaiswal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fbView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbView.layer.cornerRadius = 5.0
        fbView.layer.shadowColor = UIColor.black.cgColor
        fbView.layer.shadowOpacity = 1
        fbView.layer.shadowOffset = .zero
        
        fbView.alpha = 0
        let longGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(handleLongPress))
        view.addGestureRecognizer(longGesture)
    }

    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        
        let pressedLocation = gestureReconizer.location(in: view)

        switch gestureReconizer.state {
        case .ended:
            // clean up the animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let stackView = self.fbView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                self.fbView.alpha = 0
                
            }, completion: { (_) in
            })
        case .began:
            fbView.alpha = 0
            self.fbView.frame = CGRect.init(x: self.fbView.frame.origin.x, y: pressedLocation.y, width: self.fbView.frame.size.width, height: self.fbView.frame.size.height)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                self.fbView.alpha = 1
                self.fbView.frame = CGRect.init(x: self.fbView.frame.origin.x, y: pressedLocation.y - self.fbView.frame.size.height, width: self.fbView.frame.size.width, height: self.fbView.frame.size.height)
            }) { (_) in
                
            }
        case .changed:
            let pressedLocation = gestureReconizer.location(in: self.fbView)
            let fixedYLocation = CGPoint(x: pressedLocation.x, y: self.fbView.frame.height / 2)
            let hitTestView = fbView.hitTest(fixedYLocation, with: nil)

            if hitTestView is UIImageView {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    let stackView = self.fbView.subviews.first
                    stackView?.subviews.forEach({ (imageView) in
                        imageView.transform = .identity
                    })
                    
                    hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)

                }) { (_) in
                    
                }
            }
        default:
            break
        }
    }
}

