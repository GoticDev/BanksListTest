//
//  DetailBankViewController.swift
//  BanksListTest
//
//  Created by Victor De la Torre on 17/11/22.
//

import UIKit
import CoreData

class DetailBankViewController: UIViewController {

    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var bankImage: UIImageView!
    var bankData: BankListStorage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let bankData = bankData else { return }
        setInitialDetail(bankData: bankData)
    }
    
    private func setInitialDetail(bankData: BankListStorage) {
        bankName.text = bankData.bankName
        descriptionLabel.text = bankData.bankDescription
        ageLabel.text = String(bankData.bankAge)
        bankImage.imageFromUrl(urlString: bankData.bankUrl ?? "", placeHolderImage: UIImage(named: "errorImg")!)
    }

}
