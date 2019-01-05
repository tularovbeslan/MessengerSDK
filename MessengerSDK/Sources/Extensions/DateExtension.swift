//
//  DateExtension.swift
//  MessengerSDK
//
//  Created by workmachine on 05/01/2019.
//  Copyright © 2019 Beslan Tularov Ramazanovich. All rights reserved.
//

import Foundation

extension Date {
	
	static func random()-> Date {
		
		let day = arc4random_uniform(UInt32(Int.random(in: 0 ..< 100))) + 1
		let hour = arc4random_uniform(23)
		let minute = arc4random_uniform(59)
		
		let today = Date(timeIntervalSinceNow: 0)
		let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
		var offsetComponents = DateComponents()
		offsetComponents.day = Int(day - 1)
		offsetComponents.hour = Int(hour)
		offsetComponents.minute = Int(minute)
		
		let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) ) ?? Date()
		return randomDate
	}
	
	static func day(date: Date) -> String {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM dd"
		
		return dateFormatter.string(from: date)
	}
	
	static func time(date: Date) -> String {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mm a"
		
		return dateFormatter.string(from: date)
	}
}
