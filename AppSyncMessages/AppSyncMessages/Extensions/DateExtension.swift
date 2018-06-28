//
//  DateExtension.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 28/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import Foundation

extension Date {
    func getHourFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: self)
    }
}
