//
//  UITableViewController+Acitivity.swift
//  Optus POC
//
//  Created by Rohit on 5/24/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

var activityLoaderView: UIView?

extension UITableViewController {
    
    open override func viewDidLoad() {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")
            displayErrorMessageWith(messageString: "Please connect to internet")
        }
    }
    
    //MARK: - Method Activity Indicator
    
    ///function to add activity indicator on view controller
    func addActivityIndicator() {
        activityLoaderView = UIView(frame: self.view.bounds)
        activityLoaderView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = activityLoaderView!.center
        activityIndicator.startAnimating()
        activityLoaderView?.addSubview(activityIndicator)
       
        self.view.addSubview(activityLoaderView!)
        self.view.bringSubviewToFront(activityLoaderView!)
    }
    
    func stopActivityIndicator() {
        activityLoaderView?.removeFromSuperview()
        activityLoaderView = nil
    }
    
    /// Method to dsiplay error messages on veiwcontroller
    ///
    /// - Parameter messageString: String to be used while displaying error message
    func displayErrorMessageWith(messageString:String) {
        let alert = UIAlertController(title: NSLocalizedString("ErrorHeader", comment: ""), message: messageString , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OkButton", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
