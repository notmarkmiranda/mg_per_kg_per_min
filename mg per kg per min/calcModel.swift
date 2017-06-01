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
    return updateVars(&patientWeight, numerator: numerator, denominator: denominator)
  }
  
  var solveForDoseInGrams: String {
    formatter.numberStyle = .decimal
    let numerator = ((mgKgMinAsDecimal as Decimal) * (patientWeightAsDecimal as Decimal) * (doseofDrugMLAsDecimal as Decimal) * 60)
    let denominator = (1000 * (rateOfMLHrAsDecimal as Decimal))
    return updateVars(&doseOfDrugGrams, numerator: numerator, denominator: denominator)
  }
  
  var solveForDoseinML: String {
    formatter.numberStyle = .decimal
    let numerator = ((doseOfDrugGramsAsDecimal as Decimal) * 1000 * (rateOfMLHrAsDecimal as Decimal))
    let denominator = ((mgKgMinAsDecimal as Decimal) * (patientWeightAsDecimal as Decimal) * 60)
    return updateVars(&doseOfDrugML, numerator: numerator, denominator: denominator)
  }
  
  var solveForRateOfMLHr: String {
    formatter.numberStyle = .decimal
    let numerator = ((mgKgMinAsDecimal as Decimal) * (patientWeightAsDecimal as Decimal) * (doseofDrugMLAsDecimal as Decimal) * 60)
    let denominator = ((doseOfDrugGramsAsDecimal as Decimal) * 1000)
    return updateVars(&rateOfMLHr, numerator: numerator, denominator: denominator)
  }
  
  var solveFormGKgMin: String {
    formatter.numberStyle = .decimal
    let numerator = ((doseOfDrugGramsAsDecimal as Decimal) * 1000 * (rateOfMLHrAsDecimal as Decimal))
    let denominator = ((patientWeightAsDecimal as Decimal) * (doseofDrugMLAsDecimal as Decimal) * 60)
    return updateVars(&mgKgMin, numerator: numerator, denominator: denominator)
  }

  func updateVars(_ variable: inout String , numerator: Decimal, denominator: Decimal) -> String {
    let answer = formatter.string(from: numerator / denominator as NSNumber)!
    variable = answer
    return answer
  }
  
  var mgPerKg: String {
    formatter.numberStyle = .decimal
    return formatter.string(from: (doseOfDrugGramsAsDecimal as Decimal) * 1000 / (patientWeightAsDecimal as Decimal) as NSNumber)!
  }
  
  var infusionLength: String {
    let timeAsDecimal = (doseofDrugMLAsDecimal as Double) / (rateOfMLHrAsDecimal as Double)
    return convertDecimalToTime(timeAsDecimal)
  }
  
  func convertDecimalToTime(_ decimal: Double) -> String {
    let hours = Int(decimal)
    let minutes = Int((decimal - Double(hours)) * 60)
    let hourString = hours == 1 ? "\(hours) hour" : "\(hours) hours"
    let minuteString = minutes == 1 ? "\(minutes) minute" : "\(minutes) minutes"
    return "\(hourString), \(minuteString)"
  }
  
}
