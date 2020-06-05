//
//  FAQVC.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 5/21/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class FAQVC: UIViewController
{

    @IBOutlet var tblView: UITableView!
    var cellID = "CellClass_FAQ"
    
    var viewModel:FAQViewModel?
    var apiData : [FAQResult]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.viewModel = FAQViewModel.init(Delegate: self, view: self)
        self.viewModel?.getFAQList()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func moveBAck(_ sender: Any)
    {
        self.moveBACK(controller: self)
    }
    

}

extension FAQVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return apiData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CellClass_FAQ
        
        
        if let obj = apiData?[indexPath.row]
        {
            let qsn = "Q. \(indexPath.row+1)  "
            cell.lblTitle.text = "\(qsn)\(obj.question ?? "")"
            cell.lblDesc.text = obj.answer
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        100.0
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
}

extension FAQVC : FAQVCDelegate
{
    func getData(model: [FAQResult])
    {
        if(model.count > 0)
        {
            self.apiData = model
            self.tblView.reloadData()
            self.tblView.restore()
        }
        else
        {
            self.nothingFound()
        }
    }
    
    func nothingFound()
    {
        self.apiData = nil
        self.tblView.setEmptyMessage(kDataNothingTOSHOW)
    }
}
