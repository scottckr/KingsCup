//
//  EditingViewController.swift
//  KingsCup
//
//  Created by Scott Crocker on 2017-03-16.
//  Copyright © 2017 Scott Crocker. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {

    @IBOutlet weak var viewTitle: UINavigationItem!
    @IBOutlet weak var editText: UITextView!
    var editingValue = 0
    var editingText = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editText.text = playerRules["\(editingValue)"]
        editText.layer.borderWidth = 1.0
        editText.layer.borderColor = UIColor(colorLiteralRed: 69.0/255, green: 55.0/255, blue: 31.0/255, alpha: 1.0).cgColor
        viewTitle.title = "Redigerar: \(editingText)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveRule(_ sender: UIButton) {
        playerRules["\(editingValue)"] = editText.text
        UserDefaults.standard.set(playerRules, forKey: "rules")
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func goBackToSettings(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
}
