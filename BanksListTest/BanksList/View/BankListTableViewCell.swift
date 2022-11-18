//
//  BankListTableViewCell.swift
//  BanksListTest
//
//  Created by Victor De la Torre on 17/11/22.
//

import UIKit
import CoreData

class BankListTableViewCell: UITableViewCell {

    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankDescriptionLabel: UILabel!
    @IBOutlet weak var bankAgeLabel: UILabel!
    @IBOutlet weak var bankLogoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCells(index: BankListStorage) {
        bankNameLabel.text = index.bankName
        bankDescriptionLabel.text = index.bankDescription
        bankAgeLabel.text = String(index.bankAge)
        bankLogoImage.imageFromUrl(urlString: index.bankUrl ?? "", placeHolderImage: UIImage(named: "errorImg")!)
    }
    
}
