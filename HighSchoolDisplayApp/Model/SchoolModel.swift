//
//  SchoolModel.swift
//  HighSchoolDisplayApp
//
//  Created by Zak Mills on 1/25/24.
//

import Foundation

struct SchoolModel: Codable, Hashable {
    let dbn: String
    let school_name: String
    let school_sports: String?
    let overview_paragraph: String?
    let school_email: String?
    let phone_number: String?
    let city: String
}
