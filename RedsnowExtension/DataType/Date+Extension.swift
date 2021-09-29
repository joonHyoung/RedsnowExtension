//
//  Date+Extension.swift
//  RedsnowExtension
//
//  Created by redsnow on 2021/09/29.
//

import UIKit

extension Date {
    /**
     해당 월의 시작일
     - Returns: 시작일의 Date 객체
     */
    func startOfMonth() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return Calendar.current.date(from: components)!
    }
    
    /**
     해당 월의 마지막일
     - Returns: 마지막일의 Date 객체
     */
    func endOfMonth() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let components = calendar.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    /**
     Date 객체에서 시간 정보를 제거
     - Returns: 시간 정보가 제거된 Date 객체
     */
    func removeTime() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: components)!
    }
    
    /**
     Date 객체에서 시간 정보 반환
     - Returns: 해당 시간
     */
    func getHour() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let hour = calendar.component(.hour, from: self)
        return hour
    }
    
    /**
     Date 객체에서 월 정보 반환
     - Returns: 해당 월
     */
    func getMonth() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let month = calendar.component(.month, from: self)
        return month
    }
    
    /**
     Date 객체에서 요일 정보 반환
     - Returns: 해당 요일
     */
    func getWeekDay() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let day = calendar.component(.weekday, from: self)
        return day
    }
    
    /**
     일요일 여부 반환
     - Returns: 일요일 여부
     */
    func isSunday() -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let day = calendar.component(.weekday, from: self)
        return day == 1
    }
    
    /**
     Date 객체를 String 객체로 변환
     - Parameter format: DateFormat 형식 (예: yyyy.MM.dd hh:mm:ss)
     - Parameter am: 오전 표시 문자열
     - Parameter pm: 오후 표시 문자열
     - Returns: 변환된 문자열 객체
     */
    func toString(_ format:String, am:String? = nil, pm:String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.dateFormat = format
        
        if let amSymbol = am {
            dateFormatter.amSymbol = amSymbol
        }
        if let pmSymbol = pm {
            dateFormatter.pmSymbol = pmSymbol
        }
            
        return dateFormatter.string(from: self)
    }
    
    /**
     대한민국 시간으로 변경
     - Returns: 대한민국 시간으로 변경된 Date 객체
     */
    func toKST() -> Date {
        var today = Date()
        let format = "yyyyMMddHHmmssSSS"
        let date = self.toString(format)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: -9 * 60 * 60)
        if let value = formatter.date(from:date) {
            today = value
        }
        
        return today
    }
    
    /**
     UTC 시간으로 변경
     - Returns: UTC 시간으로 변경된 Date 객체
     */
    func toUTC() -> Date {
        var today = Date()
        let format = "yyyyMMddHHmmss"
        let date = self.toString(format)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: +9 * 60 * 60)
        if let value = formatter.date(from:date) {
            today = value
        }
        
        return today
    }
    
    /**
     해당 Date의 하루 전 날짜 조회
     - Returns: 하루 전 날짜 Date 객체
     */
    func prevDay() -> Date {
        return nextDay(-1)
    }

    /**
     해당 Date에서 전달받은 일수 전 날짜 조회
     - Parameter num: 조회하고싶은 전일 일자
     - Returns: 전달받은 일수 전 날짜 Date 객체
     */
    func prevDay(_ num:Int) -> Date {
        return nextDay(-num)
    }

    /**
     해당 Date의 하루 다음 날짜 조회
     - Returns: 하루 다음 날짜 Date 객체
     */
    func nextDay() -> Date {
        return nextDay(1)
    }

    /**
     해당 Date에서 전달받은 일수 다음 날짜 조회
     - Parameter num: 조회하고싶은 후일 일자
     - Returns: 전달받은 일수 다음 날짜 Date 객체
     */
    func nextDay(_ num:Int) -> Date {
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        let units: Set<Calendar.Component> = [.day, .month, .year, .hour, .minute, .second]
        var comps = calendar.dateComponents(units, from: self)
        comps.day = comps.day!+num
        
        return calendar.date(from: comps)!
    }
    
    func nextMonth(_ num: Int) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        let units: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        var comp = calendar.dateComponents(units, from: self)
        comp.month = comp.month! + num
        
        return calendar.date(from: comp)!
    }

    func nextYear(_ num: Int) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!

        let units: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        var comp = calendar.dateComponents(units, from: self)
        comp.year = comp.year! + num

        return calendar.date(from: comp)!
    }
    
    /**
     해당 Date객체가 비교 Date객체보다 과거인지 여부
     - Returns: 과거 여부
     */
    func isPast(from dateFrom: Date = Date()) -> Bool {
        let dateNow = dateFrom.toKST().removeTime()
        let dateTarget = self.removeTime()
        
        let interval = dateTarget.timeIntervalSince(dateNow) / (60 * 60 * 24)
        if interval > -1 {
            // 차이 -1일 이상이면 오늘 또는 미래
            return false
        }
        
        return true
    }
    
    func getDays(from dateFrom: Date = Date()) -> Int {
        let interval = self.removeTime().timeIntervalSince(dateFrom.removeTime()) / (60 * 60 * 24)
        return Int(interval)
    }
}
