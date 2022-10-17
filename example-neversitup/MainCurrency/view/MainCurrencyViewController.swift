//
//  MainCurrencyViewController.swift
//  MobileDev
//
//  Created by Sakolrat on 9/30/22.
//

import UIKit
import DropDown

class MainCurrencyViewController: UIViewController {
    
    @IBOutlet weak var lbPriceUSD: UILabel!
    @IBOutlet weak var lbPriceGBP: UILabel!
    @IBOutlet weak var lbPriceEUR: UILabel!
    @IBOutlet weak var btnSelectCoin: UIButton!
    @IBOutlet weak var lbConvert: UILabel!
    @IBOutlet weak var txt1: UITextField!
    
    var dataCurrency : CurrencyPrice!
    var priceSelect : Float!
    var typeSelect : String!
    
    lazy var viewModel: MainCurrencyViewModel = {
        let viewModel = MainCurrencyViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
        
        viewModel.publicSubject.asObserver().subscribe(onNext: { (value) in
            self.updateUI(data:value)
            self.dataCurrency = value
        })
        
        viewModel.publicResult.asObserver().subscribe({ (value) in
            self.lbConvert.text = value.element
        })
        
        Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(intervalData), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getCurrentPrice()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - UI
    func setView() {
        txt1.delegate = self
        txt1.keyboardType = .numberPad
    }
    
    func updateUI(data : CurrencyPrice) {
        lbPriceUSD.text = data.bpi.USD.rate
        lbPriceGBP.text = data.bpi.GBP.rate
        lbPriceEUR.text = data.bpi.EUR.rate
    }
    
    //MARK: - data
    @objc func intervalData() {
        viewModel.getCurrentPrice()
    }
    
    func createDropDown(data : CurrencyPrice) {
        let dropDown = DropDown()
        dropDown.dataSource = viewModel.model.optionList
        dropDown.accessibilityElements = [data.bpi.USD.rate_float,data.bpi.GBP.rate_float,data.bpi.EUR.rate_float]
        dropDown.anchorView = btnSelectCoin
        dropDown.bottomOffset = CGPoint(x: 0, y: btnSelectCoin.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item:String) in guard let _ = self else { return }
            self!.btnSelectCoin.setTitle(item, for: .normal)
            self!.priceSelect = (dropDown.accessibilityElements![index] as! Float)
            self!.typeSelect = item
        }
    }
    
    //MARK: - action
    @IBAction func actionSelectCoin(_ sender: UIButton) {
        createDropDown(data: self.dataCurrency)
    }
    
    @IBAction func actionHistory(_ sender: Any) {
        let history = HistoryViewController()
        present(history, animated: true)
    }
}

//MARK: - delegate text field
extension MainCurrencyViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,with: string)
            viewModel.convertCurrency(quantity: Int(updatedText) ?? 0, typeSelect: typeSelect,priceSelect:priceSelect)
        }
        return true
    }
}
