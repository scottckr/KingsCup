//
//  SettingsViewController.swift
//  KingsCup
//
//  Created by Scott Crocker on 2017-03-13.
//  Copyright © 2017 Scott Crocker. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var valuePicker: UIPickerView!
    
    let pickerData = ["Ess", "Två", "Tre", "Fyra", "Fem", "Sex", "Sju", "Åtta", "Nio", "Tio", "Knekt", "Dam", "Kung"]
    var pickedText : String = "Ess"
    var pickedRow : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        valuePicker.dataSource = self
        valuePicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedRow = row
        pickedText = pickerData[row]
    }

    @IBAction func goBackToMenu(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func resetToDefaultValues(_ sender: UIButton) {
        playerRules = defaultRules
        UserDefaults.standard.set(playerRules, forKey: "rules")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editVC = segue.destination as! EditingViewController
        editVC.editingValue = pickedRow + 1
        editVC.editingText = pickedText
    }
}
