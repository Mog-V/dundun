//
//  BingRecordViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class BindinggRecordViewController: BillBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "卡券绑定记录"
        tableView?.registerClass(BindingTableViewCell.classForCoder(), forCellReuseIdentifier:  NSStringFromClass(BindingTableViewCell))
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(BindingTableViewCell)) as! BillTableViewCell
        cell.titleLable?.text = "盾盾卡券"
        cell.timeLable?.text = "今天6:00"
        cell.detail?.text = "小丽丽的内衣店卡券"
        cell.billImageView?.image = UIImage(named: "bindingkaquan")
        return cell
    }

}
