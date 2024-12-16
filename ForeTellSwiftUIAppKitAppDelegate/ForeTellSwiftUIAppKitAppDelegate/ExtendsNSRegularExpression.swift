//
//  ExtendsNSRegularExpression.swift
//  ForeTellSwiftUIAppKitAppDelegate
//
//  Created by charlie on 16/12/2024.
//

import Foundation

extension NSRegularExpression
{
    func matches(_ string: String) -> Bool
    {
        let range = NSRange(location: 0, length: string.utf16.count)
        
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

