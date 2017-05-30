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
    var patientWeight: Double?
    var kGOrLb: Bool = true
    var doseOfDrugGrams: Double?
    var doseOfDrugML: Double?
    var rateOfMLHr: Double?
    var mgKgMin: Double?
}
