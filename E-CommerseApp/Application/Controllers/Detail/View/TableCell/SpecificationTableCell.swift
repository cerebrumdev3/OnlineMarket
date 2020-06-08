//
//  SpecificationTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class SpecificationTableCell: UITableViewCell {
//MARK:- outlet and variables 
    @IBOutlet weak var lblDis: UILabel!
    @IBOutlet weak var lblStyleDetail: UILabel!
    @IBOutlet weak var lblStyle: UILabel!
    @IBOutlet weak var lblShown: UILabel!
    @IBOutlet weak var lblShownDetail: UILabel!
    @IBOutlet weak var lblSpecifications: UILabel!
    @IBOutlet weak var viewPinCode: UIView!
    @IBOutlet weak var txtPinCode: UITextField!
    @IBOutlet weak var btnApply: CustomButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- other functions
    func setView(allData:Body12?){
        lblDis.textColor = Appcolor.ktextGrayColor
        lblStyleDetail.textColor = Appcolor.ktextGrayColor
        lblShownDetail.textColor = Appcolor.ktextGrayColor
        btnApply.backgroundColor = Appcolor.kTheme_Color
        btnApply.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
        
      //  let data  = allData?.description ?? ""
        let data = allData?.company?.document?.aboutus ?? ""
        lblDis.attributedText = data.htmlToAttributedString
        
    }
    
    @IBAction func applyPinCodeAction(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
