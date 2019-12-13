//
//  StringExtension.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation

extension String {
    func convertToDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = formatter.date(from: self)
        return date
    }
}

extension Date {
    func convertToString(format: String, checkTimeZone: Bool = true) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if checkTimeZone {
            formatter.timeZone = TimeZone(abbreviation: "GMT")
        }
        let dateString = formatter.string(from: self)
        return dateString
    }
}
