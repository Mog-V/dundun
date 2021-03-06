//
//  IndentViewController.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit


class IndentViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate,totalProtocol {
    
    var label2: UILabel?
    var FooterLabel2: UILabel?
    
    override func initView() {
        title = "确认订单"
        // 订单流程第一步  高度给的是70
        let colors = [blue, gray, gray, gray, gray, gray, gray]
        self.createIndentFlow(view, colors: colors, tag: 1001)
        
        self.createTableView()
        
        let AffimView = self.createAffimView(view,tag: 1001)
        let rightView = createRightView(AffimView, rightTitle: "确认")
        
        rightView.withAction(self, selector: #selector(IndentViewController.show))
        
        label2 = creatLeftView(AffimView, leftTitle: "合计:", isCount: true, isBtn: false).labelView
    }
    
    // 确认订单的操作
    func show() {
        postWithLogin("http://dundun.mog.name/order/create", params: ["gid" : 18, "aid" : 1, "num" : count!, "money" : 180 * count!])
    }
    // 请求成功
    override func netSuccess(result: String, identifier: String?) {
       
        let pay = PayViewController()
        pay.numberss = MJson.json(result)["orderid"].stringValue
        pay.times = MJson.json(result)["time"].stringValue

        showViewController(pay, sender: nil)
   
    }
    // 请求失败
    override func netError(errorType: AlamofireResultType, errorInfo: String, identifier: String?) {
        print("error")
    }
    
    
    
    func createTableView()  {
        let tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = bgColor
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(75)
            make.width.equalTo(view)
            make.height.equalTo(view)
        }
        tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if indexPath.row == 0 {
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text = "添加收货地址"
            cell.selectionStyle = .None
            return cell
        }
        
        let cell = ShoppingListCell(style: .Value1, reuseIdentifier: "cell")
        let storeName = cell.createStoreName()
        let detail = cell.createDetail(storeName, bgforeColor: bgColor)
        cell.count(detail, isHiddenAddSub: false, totalCount: count!)
        cell.delegate = self;
        // 添加cell之间的间距
        cell.addMargin()
        
        cell.selectionStyle = .None
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        }
        return 220
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.whiteColor()
       
        let leftView = UIView()
        leftView.backgroundColor = white
        footerView.addSubview(leftView)
        leftView.snp_makeConstraints { (make) in
            make.right.equalTo(footerView)
            make.left.equalTo(footerView.snp_centerX).offset(-50)
            make.bottom.equalTo(footerView)
            make.top.equalTo(footerView)
        }
        let label1 = UILabel()
        label1.text = "合计:"
        label1.textAlignment = .Right
        leftView.addSubview(label1)
        label1.snp_makeConstraints { (make) in
            make.top.equalTo(leftView).offset(15)
            make.left.equalTo(leftView.snp_centerX)
        }
        let label2 = UILabel()
        self.FooterLabel2 = label2
        leftView.addSubview(label2)
        label2.textAlignment = .Left
        label2.textColor = red
        label2.text = "¥290.00"
        label2.snp_makeConstraints { (make) in
            make.top.equalTo(leftView).offset(15)
            make.left.equalTo(label1.snp_right).offset(5)
        }
        
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
 
    func changeTotal(total: String?, ints: Int) {
        self.label2?.text = total
        self.FooterLabel2?.text = total
        amount = total!
        count = ints
    }
   
}


// 对IndentViewController的扩展
 var amount = String()
 var count = Int.init("0")

extension UIViewController{

}