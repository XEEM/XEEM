//
//  RepairServiceViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
let serviceDetailCell = "serviceDetailNameCell"
let quotesCell = "quotesCell"
let showmoreCell = "showmoreCell"
let reviewCell = "reviewCell"

class RepairServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowmoreCellDelegate {
    
    var shopModel: ShopModel?
    var quotesShopSome: [Quotes] = []
    var quotesShopAll: [Quotes] = []
    
    var reviewerAll: [ReviewModel] = []
    var reviewerSome: [ReviewModel] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnXeemMe: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()             // init View
        self.initData()             // init Data
        self.initTableView()        // init tableView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - PrivateMethod
    private func initTableView() {
        self.title = "Repair Service"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = false
        self.tableView.allowsSelection = false
        
        self.tableView.registerNib(UINib(nibName: "ServiceDetailNameCell", bundle: nil), forCellReuseIdentifier: serviceDetailCell)
        self.tableView.registerNib(UINib(nibName: "QuotesTableViewCell", bundle: nil), forCellReuseIdentifier: quotesCell)
        self.tableView.registerNib(UINib(nibName: "ShowmoreCell", bundle: nil), forCellReuseIdentifier: showmoreCell)
        self.tableView.registerNib(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: reviewCell)
    }
    

    
    private func initData() {
        if let quotesList = self.shopModel?.quotes {
            quotesShopAll = quotesList
            if quotesShopAll.count > 2 {
                quotesShopSome.append(quotesShopAll[0])
                quotesShopSome.append(quotesShopAll[1])
            }
        }
        
        if let reviewList = self.shopModel?.reviews {
            reviewerAll = reviewList
            if reviewerAll.count > 1 {
                reviewerSome.append(reviewerAll[0])
            }
        }
        
    }
    
    private func initView() {
        self.btnXeemMe.backgroundColor = UIColor.MKColor.Red
        self.btnXeemMe.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
    }
    
    
    
    // MARK: - UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // service Name
            let cell : ServiceDetailNameCell = tableView.dequeueReusableCellWithIdentifier(serviceDetailCell, forIndexPath: indexPath) as! ServiceDetailNameCell
            if let shopModel = shopModel {
                cell.configCell(shopModel)
            }
            return cell
            
        } else if indexPath.section == 1 {
            // Quotes
            if (quotesShopSome.count != quotesShopAll.count && quotesShopSome.count == indexPath.row) {
                // load more cell
                let cell : ShowmoreCell = tableView.dequeueReusableCellWithIdentifier(showmoreCell, forIndexPath: indexPath) as! ShowmoreCell
                cell.btnShowMore.setTitle("View More Services", forState: .Normal)
                cell.delegate = self
                cell.tag = 1
                return cell
            }
            // service Name
            let cell : QuotesTableViewCell = tableView.dequeueReusableCellWithIdentifier(quotesCell, forIndexPath: indexPath) as! QuotesTableViewCell
            cell.configCell(self.quotesShopSome[indexPath.row])
            return cell
        } else if indexPath.section == 2 {
            // Reviews
            if (reviewerSome.count != reviewerAll.count && reviewerSome.count == indexPath.row) {
                let cell : ShowmoreCell = tableView.dequeueReusableCellWithIdentifier(showmoreCell, forIndexPath: indexPath) as! ShowmoreCell
                cell.btnShowMore.setTitle("View More Reviews", forState: .Normal)
                cell.delegate = self
                cell.tag = 2
                return cell                
            }
                        
            // service Name
            let cell : ReviewCell = tableView.dequeueReusableCellWithIdentifier(reviewCell, forIndexPath: indexPath) as! ReviewCell
            cell.configCell(reviewerSome[indexPath.row])
            return cell
        }
        
        let cellNil = UITableViewCell()
        return cellNil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if (quotesShopSome.count == 0) {
                return 0
            } else if (quotesShopSome.count == quotesShopAll.count && quotesShopSome.count != 0) {
                return self.quotesShopSome.count
            }
            return (self.quotesShopSome.count + 1)
        } else if section == 2 {
            if (reviewerSome.count == 0) {
                return 0
            } else if (reviewerSome.count == reviewerAll.count && reviewerSome.count != 0) {
                return self.reviewerSome.count
            }
            return (self.reviewerSome.count + 1)
        }
        
        return 1
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let tempView = UIView.init(frame: CGRectMake(0, 200, 300, 244))
            tempView.backgroundColor = UIColor.clearColor()
            
            let tempLabel = UILabel.init(frame: CGRectMake(15, 0, 300, 20))
            tempLabel.backgroundColor = UIColor.clearColor()
            tempLabel.textColor = UIColor.MKColor.Red
            tempLabel.font = UIFont.boldSystemFontOfSize(18)
            
            // set title
            if section == 1 {
                tempLabel.text = "Services"
            } else if section == 2 {
                tempLabel.text = "Reviews (\(reviewerAll.count))"
            } else {
                tempLabel.text = ""
            }
            
            tempView.addSubview(tempLabel)
            return tempView
        }
        let tempView = UIView.init(frame: CGRectMake(0, 0, 0, 0))
        tempView.backgroundColor = UIColor.clearColor()
        return tempView
    
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60 
        } else if indexPath.section == 1 {
            // view more
            // view detail
            return 45
        } else if indexPath.section == 2 {
            if (reviewerSome.count != reviewerAll.count && reviewerSome.count == indexPath.row) {
                // view more
                return 45
            }
            return 90
        }
        return 0.1
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        
        return 20
    }
    
    // MARK: - ShowMoreDelegate
    func onTapShowmoreBtn(showmoreCell: ShowmoreCell) {
        if showmoreCell.tag == 1 {
            // load more quotes
            if (self.quotesShopSome.count != self.quotesShopAll.count) && self.quotesShopSome.count > 1 {
                // append more data
                for index in 2...self.quotesShopAll.count-1 {
                    self.quotesShopSome.append(self.quotesShopAll[index])
                }
            } 
            self.tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Bottom)
            
        } else if showmoreCell.tag == 2 {
            // load more reviewer
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let listReviewVC =  storyboard.instantiateViewControllerWithIdentifier("ListReviewViewController") as! ListReviewViewController
            listReviewVC.listReview = self.reviewerAll
            self.navigationController?.pushViewController(listReviewVC, animated: true)
        }
    }
    
    // MARK: - BackButton
    
    @IBAction func onBackButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
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
