//
//  calcModel.swift
//  mg per kg per min
//
//  Created by Mark Miranda on 5/27/17.
//  Copyright © 2017 Mark Miranda. All rights reserved.
//

import Foundation
let calcModel = CalcModel()

class CalcModel {
  var patientWeight = "0"
  var kgOrLb: Bool = true
  var doseOfDrugGrams = "0"
  var doseOfDrugML = "0"
  var rateOfMLHr = "0"
  var mgKgMin = "0"
  
  var patientWeightAsDecimal: NSDecimalNumber {
    return NSDecimalNumber(string: patientWeight)
  }
  
  var doseOfDrugGramsAsDecimal: NSDecimalNumber {
    return NSDecimalNumber(string: doseOfDrugGrams)
  }
  
  var doseofDrugMLAsDecimal: NSDecimalNumber {
    return NSDecimalNumber(string: doseOfDrugML)
  }
  
  var rateOfMLHrAsDecimal: NSDecimalNumber {
    return NSDecimalNumber(string: rateOfMLHr)
  }
  
  var mgKgMinAsDecimal: NSDecimalNumber {
    return NSDecimalNumber(string: mgKgMin)
  }
  
  let formatter = NumberFormatter()
  
  var solveForPatientWeight: String {
    formatter.numberStyle = .decimal
    let numerator = ((doseOfDrugGramsAsDecimal as Decimal) * 1000 * (rateOfMLHrAsDecimal as Decimal))
    let denominator = ((mgKgMinAsDecimal as Decimal) * (doseofDrugMLAsDecimal as Decimal) * 60)
    return formatter.string(from: numerator / denominator as NSNumber)!
  }
  
  var solveForDoseInGrams: String {
    formatter.numberStyle = .decimal
    let numerator = ((mgKgMinAsDecimal as Decimal) * (patientWeightAsDecimal as Decimal) * (doseofDrugMLAsDecimal as Decimal) * 60)
    let denominator = (1000 * (rateOfMLHrAsDecimal as Decimal))
    return formatter.string(from: numerator / denominator as NSNumber)!
  }
  
  var solveForDoseinML: String {
    formatter.numberStyle = .decimal
    let numerator = ((doseOfDrugGramsAsDecimal as Decimal) * 1000 * (rateOfMLHrAsDecimal as Decimal))
    let denominator = ((mgKgMinAsDecimal as Decimal) * (patientWeightAsDecimal as Decimal) * 60)
    return formatter.string(from: numerator / denominator as NSNumber)!
  }
  
  var solveForRateOfMLHr: String {
    formatter.numberStyle = .decimal
    let numerator = ((mgKgMinAsDecimal as Decimal) * (patientWeightAsDecimal as Decimal) * (doseofDrugMLAsDecimal as Decimal) * 60)
    let denominator = ((doseOfDrugGramsAsDecimal as Decimal) * 1000)
    return formatter.string(from: numerator / denominator as NSNumber)!
  }
  
  var solveFormGKgMin: String {
    formatter.numberStyle = .decimal
    let numerator = ((doseOfDrugGramsAsDecimal as Decimal) * 1000 * (rateOfMLHrAsDecimal as Decimal))
    let denominator = ((patientWeightAsDecimal as Decimal) * (doseofDrugMLAsDecimal as Decimal) * 60)
    return formatter.string(from: numerator / denominator as NSNumber)!
  }
  
}
