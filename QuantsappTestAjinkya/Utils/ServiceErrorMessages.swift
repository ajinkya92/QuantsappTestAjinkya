//
//  ServiceErrors.swift
//  QuantsappTestAjinkya
//
//  Created by apple on 04/10/20.
//

import Foundation

enum ServiceErrorMessages: String, Error {
    case no_internet_available = "There is no internet connection available."
    case unable_to_retrive_data = "Sorry we are unable to retrive data, please try after some time."
}
