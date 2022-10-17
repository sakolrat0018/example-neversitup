//
//  HistoryViewController.swift
//  MobileDev
//
//  Created by Sakolrat on 10/1/22.
//

import UIKit
import RealmSwift
import RxSwift

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: HistoryViewModel = {
        let viewModel = HistoryViewModel()
        return viewModel
    }()
    
    var data : Results<Currency>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regisTableView()
        
        viewModel.publicHistoryData.asObserver().subscribe(onNext: { (value) in
            print("Data View : " ,value)
            self.data = value
            self.initTableView()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getHistoryCurrency()
    }
    
    
    //MARK: - register table view
    func regisTableView() {
        tableView.register(UINib(nibName:"SecTableViewCell", bundle: nil), forCellReuseIdentifier: "SecCell")
        tableView.register(UINib(nibName:"HisDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "HisDetailCell")
    }
    
    func initTableView() {
        if tableView.delegate == nil {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
        }else{
            tableView.reloadData()
        }
    }

}


//MARK: - table view delegate
extension HistoryViewController : UITableViewDelegate , UITableViewDataSource {
    //MARK: - section
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecCell") as! SecTableViewCell
        
        let sec : Currency = data[section]
        cell.lbSecTitle.text = sec.timestamp
        
        return cell
    }
    
    //MARK: - row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let obj : Currency = data[section]
        return obj.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HisDetailCell") as! HisDetailTableViewCell
        let sec : Currency = data[indexPath.section]
        let data : Detail_Currency = sec.data[indexPath.row]
        cell.lbSymbol.text = data.code
        cell.lbRate.text   = data.rate
        return cell
    }
    
  
    
}
