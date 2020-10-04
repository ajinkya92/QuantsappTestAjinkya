//
//  CommonFunctions.swift
//  QuantsappTestAjinkya
//
//  Created by apple on 04/10/20.
//

import Foundation

//Get time difference for entered date to current date
func getRelativeTimeDifferenceFor(date: Date) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    let relativeDate = formatter.localizedString(for: date, relativeTo: Date())
    return relativeDate
    
}
