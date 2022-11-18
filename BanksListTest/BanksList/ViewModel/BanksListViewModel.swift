//
//  BanksListViewModel.swift
//  BanksListTest
//
//  Created by Victor De la Torre on 17/11/22.
//

import Foundation
import SVProgressHUD
import CoreData

protocol BanksListViewModelDelegate: AnyObject {
    func refreshTableView()
}

class BanksListViewModel {
    var bankListService: BankListService
    var bankList: [BankListResponse] = [BankListResponse]()
    weak var delegate: BanksListViewModelDelegate?
    var bankListStorage = [BankListStorage]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        self.bankListService = BankListService()
    }
    
    func saveBanksData(_ response: [BankListResponse]) {
        for item in response {
            let newItem = BankListStorage(context: self.context)
            newItem.bankAge = Int16(item.age)
            newItem.bankName = item.bankName
            newItem.bankUrl = item.url
            newItem.bankDescription = item.description
            self.bankListStorage.append(newItem)
        }
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func getBankList () {
        SVProgressHUD.show()
        do {
            let counter = try context.count(for: NSFetchRequest(entityName: "BankListStorage"))
            if counter == 0 {
                bankListService.getPreCashOut { [weak self] responseList, _ in
                    SVProgressHUD.dismiss()
                    guard let welf = self,
                    let responseList = responseList else { return }
                    welf.bankList = responseList
                    welf.saveBanksData(responseList)
                    welf.delegate?.refreshTableView()
                }
            } else {
                SVProgressHUD.dismiss()
                let storage: NSFetchRequest<BankListStorage> = BankListStorage.fetchRequest()
                do {
                    bankListStorage = try context.fetch(storage)
                } catch {
                    print(error.localizedDescription)
                }
                delegate?.refreshTableView()
            }
        } catch {
            SVProgressHUD.dismiss()
            print(error.localizedDescription)
        }
    }
}

