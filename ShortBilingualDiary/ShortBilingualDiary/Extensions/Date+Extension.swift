//
//  Date+Extension.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import Foundation

extension Date {
    func formatDateForDiary() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    func formatDateForYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
    
    func formatDateForMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
    
    
    // プレビュー用
    func diff(numOfHours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: numOfHours, to: self)!
    }
    func diff(numOfDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numOfDays, to: self)!
    }
    func diff(numOfMonths: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: numOfMonths, to: self)!
    }
    func diff(numOfYears: Int) -> Date {
        Calendar.current.date(byAdding: .year, value: numOfYears, to: self)!
    }
}
