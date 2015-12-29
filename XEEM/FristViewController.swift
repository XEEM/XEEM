//
//  FristViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/28/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import JBKenBurnsView

class FristViewController: UIViewController {


    @IBOutlet weak var backgroundView: JBKenBurnsView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.btnLogIn.backgroundColor = UIColor.MKColor.Red
        self.btnLogIn.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
        
        self.btnRegister.backgroundColor = UIColor.MKColor.Blue
        self.btnRegister.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
        
        autoreleasepool { () -> () in
            // set background
            var images = [UIImage]()
            images.append(UIImage(named: "xeem1")!)
            images.append(UIImage(named: "xeem2")!)
            images.append(UIImage(named: "xeem3")!)
            backgroundView.animateWithImages(images, transitionDuration: 15 , initialDelay: 0.1, loop: true, isLandscape: true)            
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
