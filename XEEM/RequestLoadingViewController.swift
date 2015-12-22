//
//  RequestLoadingViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/22/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import XHAmazingLoadingView

class RequestLoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loading: XHAmazingLoadingView = XHAmazingLoadingView(XHAmazingLoadingAnimationTypeMusic)
        loading.loadingTintColor = UIColor.MKColor.Red
        loading.frame = self.view.bounds
        self.view.addSubview(loading)
        
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
