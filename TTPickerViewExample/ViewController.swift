//
//  ViewController.swift
//  TTPickerViewExample
//
//  Created by Matías Spinelli on 8/8/17.
//  Copyright © 2017 Matías Spinelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TTPickerViewDelegate {

    let picker = TTPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.set(pickerViewDelegate: self)
        picker.set(pickerArrayElements: ["elemento uno", "elemento dos", "elemento tres", "elemento cuatro", "elemento cinco"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func openPicker(_ sender: Any) {
        picker.openPicker()
    }

    //MARK: - <TTPickerViewDelegate>
    
    func canceled() {
        print("canceled")
    }
    
    func selected(string: String) {
        print("selected \(string)")
    }
        
}

