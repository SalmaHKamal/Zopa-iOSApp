//
//  Interval+Date.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/17/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import Foundation
extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Double {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return Double(end - start)
    }
}
