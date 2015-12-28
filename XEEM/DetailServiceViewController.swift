//
//  DetailServiceViewController.swift
//  XEEM
//
//  Created by Giao Tuan on 12/24/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import JBKenBurnsView
import Alamofire
import DateTools


class DetailServiceViewController: UIViewController,ConfrimViewControllerDelegate {

//    @IBOutlet weak var bannerView: JBKenBurnsView!
    @IBOutlet weak var tableView: UITableView!
    var currentService : ShopModel!
    var NAVBAR_CHANGE_POINT : Int!
    var isReviewExpanded = false
    var isQuotationExpanded = false
    var quotationCount : Int!
    var reviewCount : Int!
    var emergencyDialog = SCLAlertView()
    @IBOutlet weak var bannerView: JBKenBurnsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        quotationCount = (currentService.quotes?.count)!
        if quotationCount > 2 {
            quotationCount = 2
        }
        reviewCount =  (currentService.reviews?.count)!
        if reviewCount > 2 {
            reviewCount = 2
        }
        NAVBAR_CHANGE_POINT = 200
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let image = UIImage(named: "default_banner.jpg")
        var images = [UIImage]()
        images.append(image!)
        bannerView.animateWithImages(images, transitionDuration: 6 , initialDelay: 0, loop: true, isLandscape: true)
        
        Alamofire.request(.GET, currentService.avatarURL!).response { (request, response, data, error) in
            if let error = error {
                return
            } else {
                let image = UIImage(data: data!, scale:1)
                var images = [UIImage]()
                images.append(image!)
                self.bannerView.animateWithImages(images, transitionDuration: 6 , initialDelay: 0, loop: true, isLandscape: true)
            }
        }

        ///self.tableView.bounces = false
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.translucent = true
//        self.navigationController!.view.backgroundColor = UIColor.clearColor()
        self.scrollViewDidScroll(self.tableView)
        
        //setup emergency dialog
        
        emergencyDialog.addButton("Out of gas", target:self, selector:Selector("outOfGasButton"))
        emergencyDialog.addButton("Flat tire", target:self, selector:Selector("flatTireButton"))
        emergencyDialog.addButton("Other problem", target:self, selector:Selector("otherProblem"))
       
    }
    
    func outOfGasButton() -> () {
        emergencyDialog.hideView()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let listReviewVC =  storyboard.instantiateViewControllerWithIdentifier("RequestLoadingViewController") as! RequestLoadingViewController
            listReviewVC.selectedShop = self.currentService
            listReviewVC.quotationIndex = 0
            self.navigationController?.pushViewController(listReviewVC, animated: true)
        }
        
    }
    func flatTireButton() -> () {
        emergencyDialog.hideView()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let listReviewVC =  storyboard.instantiateViewControllerWithIdentifier("RequestLoadingViewController") as! RequestLoadingViewController
            listReviewVC.selectedShop = self.currentService
            listReviewVC.quotationIndex = 1
            self.navigationController?.pushViewController(listReviewVC, animated: true)
        }
        
    }
    func otherProblem() -> () {
        emergencyDialog.hideView()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let listReviewVC =  storyboard.instantiateViewControllerWithIdentifier("RequestLoadingViewController") as! RequestLoadingViewController
            listReviewVC.selectedShop = self.currentService
            listReviewVC.quotationIndex = 2
            self.navigationController?.pushViewController(listReviewVC, animated: true)
        }

    }
 
    override func viewWillDisappear(animated: Bool) {
        self.tableView.delegate = nil;
         self.navigationController!.navigationBar.lt_reset()
    }// Called when the view has been fully transitioned onto the screen. Default does nothing

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
    
    @IBAction func onBackClicked(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onXeemClicked(sender: UIButton) {
        //self.displayViewController(.Fade)
        emergencyDialog.showInfoWithAppColor("Tell us your problem" , subTitle: "With " + User.currentUser!.defaultVehicles!.name)
    }
    
    func displayViewController(animationType: SLpopupViewAnimationType) {
        let myPopupViewController:ConfrimViewController = ConfrimViewController(nibName:"ConfrimPopUp", bundle: nil)
        myPopupViewController.delegate = self
        self.presentpopupViewController(myPopupViewController, animationType: animationType, completion: { () -> Void in })
    }
    func onCancelTapped(confirmViewController: ConfrimViewController) {
        self.navigationController?.dismissPopupViewController(.Fade)
    }
    
    func onConfrimTapped(confirmViewController: ConfrimViewController) {
        confirmViewController.titleLabel.resignFirstResponder()
        self.navigationController?.dismissPopupViewController(.Fade)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let listReviewVC =  storyboard.instantiateViewControllerWithIdentifier("RequestLoadingViewController") as! RequestLoadingViewController
              self.navigationController?.pushViewController(listReviewVC, animated: true)
        }
    }


}
extension DetailServiceViewController: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate, SeeMoresCellDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //let color: UIColor = UIColor(red: 0 / 255.0, green: 175 / 255.0, blue: 240 / 255.0, alpha: 1)
        let offsetY: CGFloat = scrollView.contentOffset.y
        if offsetY > 150 {
            let alpha: CGFloat = min(1, 1 - ((150 + 64 - offsetY) / 64))
            self.navigationController!.navigationBar.lt_setBackgroundColor(UIColor.MKColor.AppMainColor.colorWithAlphaComponent(alpha))
            if (alpha == 1) {
                title = currentService.name
            }
        }
        else {
            self.navigationController!.navigationBar.lt_setBackgroundColor(UIColor.clearColor())
            navigationController?.navigationBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.whiteColor()];
            title = ""
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return quotationCount
        case 2:
            if (currentService.quotes?.count > 2 && !isQuotationExpanded) {
                print("show see more quotation")
                return 1
            } else {
                return 0
            }
        case 3:
            return reviewCount
        case 4:
            if (currentService.reviews?.count > 2 && !isReviewExpanded) {
                return 1
            } else {
                return 0
            }
        default:
            return 1
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("infoCell") as! InfoCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.titleLabel.text = currentService.name
            cell.ratingView.rating = currentService.rating!
            cell.distanceLabel.text = UIUtils.convertDistance(currentService.distance!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("quotationCell") as! QuotationCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.quotationLabel.text = currentService.quotes![indexPath.row].name
            cell.priceLabel.text = String(currentService.quotes![indexPath.row].price)
            if (indexPath.row == 1 && !isQuotationExpanded) {
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("seeMoresCell") as! SeeMoresCell
                cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("reviewsCell") as! ReviewsCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.ratingView.rating = currentService.reviews![indexPath.row].rating!
            cell.reviewTextView.text = currentService.reviews![indexPath.row].descriptions
            cell.userLabel.text = currentService.reviews![indexPath.row].reviewer?.fullName
            ///cell.timeLabel.text = currentService.reviews![indexPath.row].dateCreated
            let timeAgoDate = currentService.reviews![indexPath.row].dateCreated as NSDate?
            if let timeAgoDate = timeAgoDate {
                cell.timeLabel.text = timeAgoDate.timeAgoSinceNow()
            } else {
                cell.timeLabel.text = "--"
            }

            if (indexPath.row == 1 && !isReviewExpanded) {
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("seeMoresCell") as! SeeMoresCell
            cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func generateQuotationView(row : Int,cell : QuotationCell) {
     

    }

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell")
            headerCell?.textLabel!.text = "Quotations"
            headerCell?.detailTextLabel?.text = ""
            return headerCell
        case 3:
            let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell")
            headerCell?.textLabel!.text = "Reviews"
            headerCell!.detailTextLabel!.text = "\((currentService.reviews?.count)! as Int)"
            return headerCell
        default:
            return UIView()
            
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
           return 40
        case 3:
            return 40
        default:
            return 0
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 5
        
    }
  
    func seeMoresCell(filterCell : SeeMoresCell) {
        
        let indexPath = tableView.indexPathForCell(filterCell)!
        print("on delegate see more",String(indexPath.section))
        switch indexPath.section {
        case 2:
            self.isQuotationExpanded = true
            quotationCount = (currentService.quotes?.count)!
            tableView.reloadData()

            break;
        case 4:
            self.isReviewExpanded = true
            reviewCount = (currentService.reviews?.count)!
            tableView.reloadData()
            let offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
            tableView.contentOffset = offset
            //categoryState[indexPath.row] = value
            break;
        default:
            break;
        }
    }
}