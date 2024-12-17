//
//  ExternalModel.swift
//  ForeTellSwiftUIAppKitAppDelegate
//
//  Created by charlie on 14/12/2024.
//

import Foundation
import Cocoa
import EventKit

class ExternalModel: ObservableObject
{
    @Published var column1: String = ""
    @Published var column2: String = ""
    @Published var column3: String = ""
    
    @Published var doctorInfo: String = ""
    
    @Published var errors: String = ""
    
    var app: AppDelegate!
    
    init( runUpdate: Bool = false )
    {
        if runUpdate
        {
            self.update()
        }
    }
    
    func update()
    {
        var col1 = ""
        var col2 = ""
        var col3 = ""
        
        var errors = ""
        
        let store = EKEventStore()
        
        store.requestAccess(to: EKEntityType.event, completion:
        {
            granted, error in
            
            if granted
            {
                let events: [EKEvent]? = self.getEvents(store: store)
                
                let formatter = DateFormatter()
                
                formatter.dateFormat = "dd/MM/yyyy (EE) (H:mm)"
                
                var lastEventTitle = ""
                var counter = 1
                
                for (_, event) in events!.enumerated()
                {
                    if counter > Constants.limit
                    {
                        break
                    }
                    
                    if event.title != lastEventTitle
                    {
                        let date : String = formatter.string(from: event.startDate)
                        
                        let dateBits = date.components(separatedBy: " ")
                        
                        col1 = col1 + dateBits[0]
                        col2 = col2 + dateBits[1]
                        col3 = col3 + event.title
                        
                        if Calendar.current.isDateInToday(event.startDate) && !event.isAllDay
                        {
                            col3 = col3 + " " + dateBits[2]
                        }

                        col1 = col1 + Constants.newLine
                        col2 = col2 + Constants.newLine
                        col3 = col3 + Constants.newLine

                        lastEventTitle = event.title
                        
                        counter = counter + 1
                    }
                }
                
                col1 = col1.trimmingCharacters(in: .whitespacesAndNewlines)
                col2 = col2.trimmingCharacters(in: .whitespacesAndNewlines)
                col3 = col3.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            else
            {
                let desc: String! = error?.localizedDescription ?? ""
                
                errors = errors + desc
            }
            
            DispatchQueue.main.async
            {
                if col1 == ""
                {
                    col1 = "No appointments found"
                }
                
                self.column1 = col1
                self.column2 = col2
                self.column3 = col3
                
                self.doctorInfo = self.getExtraData()
                
                self.errors = errors
                
                if self.app != nil
                {
                    self.app.update()
                }
            }
        })
    }
    
    func getExtraData() -> String
    {
        var s = "Timetable for "
        
        var timetableTextFile: String
        
        if weekIsEven()
        {
            timetableTextFile = "opening-times-even-weeks"
            
            s = s + "even"
        }
        else
        {
            timetableTextFile = "opening-times-odd-weeks"
            
            s = s + "odd"
        }
        
        s = s + " week:" + Constants.newLine + Constants.newLine
        
        if let filepath = Bundle.main.path(forResource: timetableTextFile, ofType: "txt")
        {
            do
            {
                let contents = try String(contentsOfFile: filepath)
                
                s = s + contents
            }
            catch
            {
                s = s + timetableTextFile + ".txt could not be loaded" + Constants.newLine
            }
        }
        else
        {
            s = s + timetableTextFile + ".txt not found"
        }
        
        s = s.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        return s
    }

    func weekIsEven() -> Bool
    {
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: Date(timeIntervalSinceNow: 0))
        
        return weekOfYear % 2 == 0
    }

    func getCals(store: EKEventStore) -> [EKCalendar]
    {
        var cals:[EKCalendar]? = []
        
        guard let regex = try? NSRegularExpression(pattern: Constants.calendarPattern) else { return [] }
        
        for item in store.calendars(for: .event)
        {
            if regex.matches(item.title)
            {
                cals?.append(item)
            }
        }
            
        return cals ?? []
    }

    func getPredicate(store: EKEventStore, cals: [EKCalendar]) -> NSPredicate
    {
        let calendar = Calendar.current
        
        var startComponents = DateComponents()
        startComponents.day = 0
        
        let today = calendar.date(byAdding: startComponents, to: Date(), wrappingComponents: false)
        
        var endComponents = DateComponents()
        endComponents.year = 1
        
        let oneYearFromNow = calendar.date(byAdding: endComponents, to: Date(), wrappingComponents: false)
        
        var predicate: NSPredicate? = nil
        
        if let startToday = today, let inOneYearFromNow = oneYearFromNow
        {
            predicate = store.predicateForEvents(withStart: startToday, end: inOneYearFromNow, calendars: cals)
        }
        
        return predicate!
    }

    func getEvents(store: EKEventStore) -> [EKEvent]
    {
        let cals: [EKCalendar]? = self.getCals(store: store)
        
        if cals?.count == 0
        {
            return []
        }
        
        let predicate: NSPredicate? = self.getPredicate(store: store, cals: cals ?? [])
        
        var events: [EKEvent]?
        
        if let aPredicate = predicate
        {
            events = store.events(matching: aPredicate)
        }
        
        return events ?? []
    }
}
