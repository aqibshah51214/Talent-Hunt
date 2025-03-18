//
//  EventCreate.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 14/03/2025.
//

import Foundation
struct EventCreate: Codable,Hashable{
    let Id: Int
    let Title: String
    let RegStartDate: String
    let RegEndDate: String
    let EventDate: String
    let EventStartTime: String
    let EventEndTime: String
    let Details: String
    let Image: String?
}
