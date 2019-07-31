//
//  TTPickerView.swift
//  TTPickerView
//
//  Created by Matías Spinelli on 8/8/17.
//  Copyright © 2017 Matías Spinelli. All rights reserved.
//

import UIKit

protocol TTPickerViewDelegate {
    func canceled()
    func selected(string: String)
}

final class TTPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var pickerViewDelegate : TTPickerViewDelegate?
    
    private var pickerArrayElements : [String] = []
    private var elementSelected : String?
    
    @IBOutlet weak var view : UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("TTPickerView", owner: self, options: nil)
        self.addSubview(self.view)
        self.view.frame = frame
        
        self.pickerView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setters
    func set(pickerViewDelegate delegate : TTPickerViewDelegate) {
        self.pickerViewDelegate = delegate
    }
    
    func set(pickerArrayElements arrayElements : [String]) {
        self.pickerArrayElements = arrayElements
    }
    
    // MARK: - Public
    func openPicker() {
//        guard !self.pickerArrayElements.isEmpty else {
//            fatalError("array cannot be empty. please call the method : func set(pickerArrayElements arrayElements : [String])")
//        }
        
        if self.elementSelected == nil {
            self.elementSelected = self.pickerArrayElements[0]
        }
        self.showPickerView()
    }
    
    // MARK: - Showing Methods
    
    private func showPickerView() {

        backgroundView.layer.cornerRadius = 10.0
        
        let keyWindow : UIWindow = UIApplication.shared.keyWindow!
        let view : UIView = (keyWindow.rootViewController?.view)!
        self.frame = view.frame
        
        self.transparentView.alpha = 0.0
        let backgroundViewOriginY = self.backgroundView.frame.origin.y
        backgroundView.frame = CGRect(x: self.backgroundView.frame.origin.x, y: self.frame.size.height, width: self.backgroundView.frame.size.width, height: backgroundView.frame.size.height)
        UIView.animate(withDuration: 0.5) {
            self.transparentView.alpha = 0.4
            self.backgroundView.frame = CGRect(x: self.backgroundView.frame.origin.x, y: backgroundViewOriginY, width: self.backgroundView.frame.size.width, height: self.backgroundView.frame.size.height)
        }
        
        view.addSubview(self)
    }
    
    // MARK: - Hide Methods
    private func hideView() {
        UIView.animate(withDuration: 0.5) {
            self.transparentView.alpha = 0.0
            self.backgroundView.frame = CGRect(x: self.backgroundView.frame.origin.x, y: self.frame.size.height, width: self.backgroundView.frame.size.width, height: self.backgroundView.frame.size.height)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.removeFromSuperview()
        }
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.hideView()
        self.pickerViewDelegate?.canceled()
    }
    
    @IBAction func selectedButtonPressed(_ sender: Any) {
        self.hideView()
        if self.elementSelected != nil {
            self.pickerViewDelegate?.selected(string: self.elementSelected!)
        }
    }

    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerArrayElements.count
    }

    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerArrayElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.elementSelected = self.pickerArrayElements[row]
    }
}
