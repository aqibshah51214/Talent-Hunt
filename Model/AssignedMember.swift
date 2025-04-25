//
//  AssignedMember.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 23/03/2025.
//
 

import Foundation
struct Committee: Codable {
  
    let Id: Int
    let Name: String
    var selectvalue:Bool
}

struct AssignedMember: Codable, Hashable {
    let Id: Int
    let EventId: Int
    let MemberIdList: [Int]? // Corrected property name
    var Status: String?
   // Added type annotation and default value
}
    // Custom initializer

