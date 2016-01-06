//
//  RequestLoadingViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/22/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class RequestLoadingViewController: UIViewController {

    var selectedShop : ShopModel!
    var quotationIndex : Int!
    var fromEmergency: Bool?
    var transportation: Transportation!
    var token: String!
    var latitude: Double!
    var longitude: Double!
    var text: String!
    var requestToken:String?
    
    @IBOutlet weak var shopDetailView: CompactShopDetailForRequestView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func onClickCancel(sender: UIButton) {
        stopTimer()
        goBackToMainPage()
        cancelRequest()
    }
    
    func showShopInfo(){
        
    }
    
    func cancelRequest() {
        XEEMService.sharedInstance.cancelRequest("0", requestToken: requestToken!) { (request, error) -> Void in
            if error != nil {
                print("\(error)")
                
                return
            }
            
            print("can request successfully. token: \(self.requestToken)")
            self.goBackToMainPage()
        }

    }
    
    func sendRequest(){
        transportation = User.currentUser?.defaultVehicles
        let temp = 0
        let trans_id = String(temp)
        let latitude = NSUserDefaults.standardUserDefaults().objectForKey("latitude") as! Double
        let longitude = NSUserDefaults.standardUserDefaults().objectForKey("longitude") as! Double
        
        XEEMService.sharedInstance.sendRequest("0", shopId: "0", transportationId: trans_id, latitude: latitude, longitude: longitude, description: text, completion: { (token, error) -> () in
            if error != nil {
                print("\(error)")
                
                return
            }
            
            self.requestToken = token
            self.progressView.status = "Waiting"
            print("send request successfully. token: \(token)")
            self.startProgressTimer()
            self.refreshRequest()

        })
    }
    
    func startProgressTimer(){
        self.startTime = NSDate()
        progressTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
    }
    
    
    func updateProgress(){
        let now = NSDate()
        progressView.elapsedTime = now.timeIntervalSinceDate(startTime)
    }
    
    var startTime: NSDate!
    var timer: NSTimer!
    func refreshRequest(){
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "getRequest", userInfo: nil, repeats: true)
    }
    
    func getRequest(){
        XEEMService.sharedInstance.getRequest("0", requestToken: requestToken) { (request, error) -> () in
            if request?.status == RequestStatus.Accepted {
                self.goToReceivedPage(request)
                self.stopTimer()
                return
            } else if request?.status == RequestStatus.Canceled {
                self.stopTimer()
                self.cancelRequest()
            }
        }
    }
    
    @IBOutlet weak var progressView: CircleProgressView!

    var progressTimer: NSTimer!
    
    func stopTimer(){
        autoreleasepool { () -> () in
            self.progressTimer.invalidate()
            self.timer.invalidate()
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        shopDetailView.model = self.selectedShop
        progressView.timeLimit = 2 * 60
        progressView.status = "Requesting"
        progressView.tintColor = UIColor.MKColor.Orange
        progressView.frame =  CGRectMake(0, self.view.bounds.size.width / 2, self.view.bounds.width, 200)
        progressView.elapsedTime = 0
        
        self.view.addSubview(progressView)
        
        sendRequest()
    }

    func goBackToMainPage(){
        self.stopTimer()

        UIUtils.goToMainPage()
    }
    
    func goToReceivedPage(request: Request!){
        //
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let receivedService =  storyboard.instantiateViewControllerWithIdentifier("ReceivedServiceViewController") as! ReceivedServiceViewController
        receivedService.selectedShop = request.shop
        receivedService.quotationIndex = self.quotationIndex
        
        self.navigationController?.pushViewController(receivedService, animated: true)

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
