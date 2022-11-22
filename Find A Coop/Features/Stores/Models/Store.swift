//
//  Store.swift
//  Find A Coop
//
//  Created by Karl Thomas Hauglid on 22/11/2022.
//

import Foundation

struct Store: Codable {
  var isEcommerce: Bool
  var openNow: Bool
  var lat: Double
  var lng: Double
  var distance: Double
  var openingHours: [OpeningHours]
  var specialOpeningHours: [OpeningHours]
  var inStoreServices: [String]
  var address: String
  var chain: String
  var chainClassName: String
  var chainId: String
  var chainImage: String
  var city: String
  var email: String?
  var name: String
  var newspaperUrl: String
  var openingHoursToday: String
  var organizationNumber: String
  var phone: String
  var sLag: String?
  var storeId: String
}
