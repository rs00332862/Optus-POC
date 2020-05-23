//
//  UIImageView+URLImage.swift
//  Optus POC
//
//  Created by Rohit on 5/22/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImageFromURL(_ URLString: String, placeHolder: UIImage?) {
        
        if URLString .isEmpty{
            self.image = placeHolder
            return
        }
        
        let imageCache = NSCache<NSString, UIImage>()
        
        self.image = #imageLiteral(resourceName: "weatherPlaceHolder")
        let imageUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        //check if image is presnt in cache or not
        if let cachedImage = imageCache.object(forKey: NSString(string: imageUrl)) {
            self.image = cachedImage
            return
        }
        
        //download imaghe from provided URL
        if let urlImage = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: urlImage, completionHandler: { (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
