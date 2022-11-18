//
//  BanksTableViewController.swift
//  BanksListTest
//
//  Created by Victor De la Torre on 17/11/22.
//

import UIKit

class BanksTableViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var banksListViewModel = BanksListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        banksListViewModel.delegate = self
        banksListViewModel.getBankList()
        registerTableView()
    }

    private func registerTableView() {
        let nib = UINib(nibName: "BankListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BankListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension BanksTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banksListViewModel.bankListStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BankListTableViewCell", for: indexPath) as? BankListTableViewCell else { return UITableViewCell() }
        cell.configCells(index: banksListViewModel.bankListStorage[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailBankViewController()
        vc.bankData = banksListViewModel.bankListStorage[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BanksTableViewController: BanksListViewModelDelegate {
    func refreshTableView() {
        self.tableView.reloadData()
    }
}
