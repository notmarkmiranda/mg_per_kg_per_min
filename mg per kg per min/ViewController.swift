//
//  ViewController.swift
//  mg per kg per min
//
//  Created by Mark Miranda on 5/27/17.
//  Copyright © 2017 Mark Miranda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - View Did Load
  override func viewDidLoad() {
    super.viewDidLoad()
    hideErrors()
    hideStats()
    setDelegates()
    setNextAndPrevious()
    addAccessoryView(patientWeightField)
  }
  
  
  // MARK: - Properties
  var activeTextField: UITextField?
  enum BlanksError : Error {
    case tooMany
    case none
  }
  var solveForField: UITextField?
  
  
  // MARK: - Functions
  
  func hideErrors() {
    errorLabel.isHidden = true
  }
  
  func hideStats() {
    statStack.isHidden = true
  }
  
  func showErrors(message: String) {
    errorLabel.text = message
    errorLabel.isHidden = false
  }
  
  func setNextAndPrevious() {
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
  }
  
  func setDelegates() {
    self.patientWeightField.delegate = self
    self.doseOfDrugGramsField.delegate = self
    self.doseOfDrugMLField.delegate = self
    self.rateOfMLHrField.delegate = self
    self.mgKgMinField.delegate = self
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
    do {
      try findBlanks()
      updateModel()
    } catch BlanksError.none {
      showErrors(message: "You have to leave at least 1 field blank.")
    } catch BlanksError.tooMany {
      showErrors(message: "You can only leave 1 field blank.")
    } catch {
      showErrors(message: "I'm not even sure how you got here.")
    }
  }
  
  func updateModel() {
    calcModel.patientWeight = patientWeightField.text!
    calcModel.doseOfDrugGrams = doseOfDrugGramsField.text!
    calcModel.doseOfDrugML = doseOfDrugMLField.text!
    calcModel.rateOfMLHr = rateOfMLHrField.text!
    calcModel.mgKgMin = mgKgMinField.text!
    
    calc()
  }
  
  func calc() {
    switch solveForField! {
    case mgKgMinField:
      mgKgMinField.text = calcModel.solveFormGKgMin
    case patientWeightField:
      patientWeightField.text = calcModel.solveForPatientWeight
    case doseOfDrugGramsField:
      doseOfDrugGramsField.text = calcModel.solveForDoseInGrams
    case doseOfDrugMLField:
      doseOfDrugMLField.text = calcModel.solveForDoseinML
    case rateOfMLHrField:
      rateOfMLHrField.text = calcModel.solveForRateOfMLHr
    default: break
    }
    updateStats()
    activeTextField?.resignFirstResponder()
  }
  
  func updateStats() -> Void {
    statStack.isHidden = false
    mgPerKgLabel.text = calcModel.mgPerKg
    infusionLengthLabel.text = calcModel.infusionLength
  }
  
  func findBlanks() throws {
    var blanks = 0
    for field in [patientWeightField, doseOfDrugGramsField, doseOfDrugMLField, rateOfMLHrField, mgKgMinField] {
      if field!.text!.characters.count == 0 {
        solveForField = field
        blanks += 1
      }
    }
    guard blanks == 1 else {
      if blanks == 0 {
        throw BlanksError.none
      } else {
        throw BlanksError.tooMany
      }
      
    }
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    hideErrors()
    addAccessoryView(textField)
    activeTextField = textField
  }
  
  // MARK: - Outlets
  @IBOutlet weak var patientWeightField: UITextField!
  @IBOutlet weak var doseOfDrugGramsField: UITextField!
  @IBOutlet weak var doseOfDrugMLField: UITextField!
  @IBOutlet weak var rateOfMLHrField: UITextField!
  @IBOutlet weak var mgKgMinField: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  @IBOutlet weak var statStack: UIStackView!
  @IBOutlet weak var mgPerKgLabel: UILabel!
  @IBOutlet weak var infusionLengthLabel: UILabel!
}


private var kAssociationKeyNextField: UInt8 = 0
private var kAssociationKeyPrevField: UInt8 = 0

extension UITextField {
  // MARK: - UITextField extensions
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
