//
//  ViewController.swift
//  Homework01
//
//  Created by Jane on 1/27/19.
//  Copyright © 2019 Kseniia Andreeva. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
    }
    @IBOutlet weak var billNoTipLbl: UILabel!
    @IBOutlet weak var tipPercLbl: UILabel!
    @IBOutlet weak var customSliderLbl: UILabel!
    @IBOutlet weak var tipTotalLbl: UILabel!
    @IBOutlet weak var billTotalLbl: UILabel!
    
    @IBOutlet weak var billValueField: UITextField!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipSegments: UISegmentedControl!
    
    @IBOutlet weak var tipSliderLbl: UILabel!
    @IBOutlet weak var tipTotal: UILabel!
    @IBOutlet weak var billTotal: UILabel!
    
    @IBAction func billChanged(_ sender: UITextField) {
        let tip = getTipValue()
        calcBillTotal(tip: tip)
    }
    
    @IBAction func tipSegmentChanged(_ sender: UISegmentedControl) {
        let tip = getTipValue()
        calcBillTotal(tip: tip)
    }
    
    @IBAction func tipSliderChanged(_ sender: UISlider) {
        var customTip = Double(tipSlider.value)
        customTip = round(customTip*100)/100
        let tipSegm = tipSegments.titleForSegment(at: tipSegments.selectedSegmentIndex)!
        if tipSegm == "Custom" {
            calcBillTotal(tip: customTip)
        }
        tipSliderLbl.text = "\(customTip)%"
    }
    
    func getTipValue() -> Double {
        let tip = tipSegments.titleForSegment(at: tipSegments.selectedSegmentIndex)!
        var percValue: Double
        if tip == "Custom" {
            percValue = Double(tipSlider.value)
        }
        else {
            let upperBound = String.Index(encodedOffset: 2)
            percValue = Double(tip[..<upperBound])!
        }
        return percValue
    }
    
    func calcBillTotal(tip: Double) {
        var bill: Double
        let billInput = billValueField.text
        
        // if the bill total is empty, set tip and total to 0.00
        if billInput!.count == 0 {
            tipTotal.text = "0.00"
            billTotal.text = "0.00"
        }
        else {
            let tmp = Double(billInput!)
            if tmp == nil || tmp! < 0 {
                alert()
                bill = 0
            }
            else {
                bill = tmp!
            }
            var tipCalculated = bill * tip / 100
            tipCalculated = round(tipCalculated*100)/100
            var total = bill + tipCalculated
            total = round(total*100)/100
            tipTotal.text = String(tipCalculated)
            billTotal.text = String(total)            
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        billValueField.text = ""
        tipSegments.selectedSegmentIndex = 0
        tipSlider.setValue(25, animated: true)
        tipSliderLbl.text = "25%"
        tipTotal.text = "0.00"
        billTotal.text = "0.00"
    }
    
    func alert() {
        let alert = UIAlertController(title: "Error", message: "Enter a positive bill value", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
