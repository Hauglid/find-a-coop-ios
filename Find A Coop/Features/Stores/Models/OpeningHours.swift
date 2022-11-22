//
//  OpeningHours.swift
//  Find A Coop
//
//  Created by Karl Thomas Hauglid on 22/11/2022.
//

import Foundation

struct OpeningHours: Codable {
  var date: String
  var openString: String
  var day: String
  var closed: Bool
  var specialOpeningHours: Bool
}
