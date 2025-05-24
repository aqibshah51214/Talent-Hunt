//
//  Task.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 20/05/2025.
//


import Foundation
struct  Task: Codable,Hashable {
  
    let EventID:Int
    let Description:String?
    let TaskStartTime:String?
    let TaskEndTime:String?
    let image:String?
}
