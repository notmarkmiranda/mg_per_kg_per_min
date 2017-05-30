//
//  ViewController.swift
//  mg per kg per min
//
//  Created by Mark Miranda on 5/27/17.
//  Copyright © 2017 Mark Miranda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setNextAndPrevious(patientWeightField)
    }
    
    // MARK: - Properties
    var activeTextField: UITextField?
    
    // MARK: - Functions
    func setNextAndPrevious(_ currentField: UITextField) {
        patientWeightField.prevField = mgKgMinField
        patientWeightField.nextField = doseOfDrugGramsField
        doseOfDrugGramsField.prevField = patientWeightField
        doseOfDrugGramsField.nextField = doseOfDrugMLField
        doseOfDrugMLField.prevField = doseOfDrugGramsField
        doseOfDrugMLField.nextField = rateOfMLHrField
        rateOfMLHrField.prevField = doseOfDrugMLField
        rateOfMLHrField.nextField = mgKgMinField
        mgKgMinField.prevField = rateOfMLHrField
        mgKgMinField.nextField = patientWeightField
        addAccessoryView(currentField)
    }
    
    func addAccessoryView(_ currentField: UITextField) -> Void {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.nativeBounds.width, height: 44))
        
        let prevButton = UIBarButtonItem(title: "PREV", style: .plain, target: self, action: #selector(previousField))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        space.width = 20
        let nextButton = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(nextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let calcButton = UIBarButtonItem(title: "CALC", style: .plain, target: self, action: #selector(calculate))
        
        toolbar.items = [prevButton, space, nextButton, flexibleSpace, calcButton]
        
        activeTextField = currentField
        currentField.inputAccessoryView = toolbar
        currentField.becomeFirstResponder()
    }
    
    func previousField() {
        addAccessoryView((activeTextField?.prevField)!)
    }
    
    func nextField() {
        addAccessoryView((activeTextField?.nextField)!)
    }
    
    func calculate() {
        if let weight = patientWeightField.text {
            calcModel.patientWeight = Double(weight)
        }
        print(calcModel.patientWeight!)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var patientWeightField: UITextField!
    @IBOutlet weak var kgLbSwitch: UISwitch!
    @IBOutlet weak var doseOfDrugGramsField: UITextField!
    @IBOutlet weak var doseOfDrugMLField: UITextField!
    @IBOutlet weak var rateOfMLHrField: UITextField!
    @IBOutlet weak var mgKgMinField: UITextField!
    
    
}

private var kAssociationKeyNextField: UInt8 = 0
private var kAssociationKeyPrevField: UInt8 = 0

extension UITextField {
    var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var prevField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyPrevField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyPrevField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }

}
