//
//  Constants.swift
//  ForeTellSwiftUIAppKitAppDelegate
//
//  Created by charlie on 14/12/2024.
//

import Foundation

enum Constants
{
    static let width: CGFloat = 1000
    static let height: CGFloat = 2000
    
    static let margin: CGFloat = 20
    static let padding: CGFloat = 20
    
    static let textSize: CGFloat = 20
    
    static let desktopWindowLevel = -2147483623
    
    static let limit = 45
    
    static let testingUpdateIntervalInSeconds = 5.0
    static let updateIntervalInSeconds = 60.0
    
    static let newLine = "\n"
    
    static let mumPattern = "^Mum appointments$"
    static let appointmentsPattern = "appointments"
    static let everythingPattern = ".*"
    static let everythingExceptHolidaysPattern = "^((?!Holidays).)*$"
    
    static let calendarPattern = everythingExceptHolidaysPattern
}
