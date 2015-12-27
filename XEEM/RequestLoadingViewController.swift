//
//  RequestLoadingViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/22/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class RequestLoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let loading: XHAmazingLoadingView = XHAmazingLoadingView(type: XHAmazingLoadingAnimationType.Skype)
        loading.loadingTintColor = UIColor.MKColor.Red
        loading.frame = CGRectMake(0, self.view.bounds.size.width / 2, self.view.bounds.width, 200)
        self.view.addSubview(loading)
        
        // create label
        let label : UILabel = UILabel(frame: CGRectMake(0,
                                                        self.view.bounds.size.width / 2 + loading.frame.size.height,
                                                        self.view.bounds.width,
                                                        100))
        label.textAlignment = NSTextAlignment.Center
        label.text = "Requesting help"
        label.font = UIFont.boldSystemFontOfSize(20)
        
        label.textColor = UIColor.MKColor.Red
        self.view.addSubview(label)
        loading.startAnimating()

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            loading.stopAnimating()
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let receivedService =  storyboard.instantiateViewControllerWithIdentifier("ReceivedServiceViewController") as! ReceivedServiceViewController
            self.navigationController?.pushViewController(receivedService, animated: true)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
