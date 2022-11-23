//
//  StoreInfoViewController.swift
//  Find A Coop
//
//  Created by Karl Thomas Hauglid on 23/11/2022.
//

import Foundation
import UIKit

class StoreInfoViewController: UIViewController{
    var store: Store?
    
    @IBOutlet weak var openNowLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openingHoursStack: UIStackView!
    @IBOutlet weak var openingHoursTodayLabel: UILabel!
    override func viewDidLoad() {
        
        guard let store = self.store else { return  }
        self.title = store.name
        emailLabel.text = store.email
        phoneLabel.text = store.phone
        addressLabel.text = store.address
        openingHoursTodayLabel.text = store.openingHoursToday
        
        if store.openNow{
            openNowLabel.text = "Åpent"
        }else{
            openNowLabel.text = "Stengt"
        }
        
        storeNameLabel.text = "\(store.chain) \(store.name)"
        
        // Add openings hours to stack
        addOpeningHours(openingHours: store.openingHours)
    }
    
    func addOpeningHours(openingHours: [OpeningHours]) {
        for openingHour in openingHours {
            let label = UILabel()
            label.text = "\(openingHour.day) \(openingHour.openString)"
            self.openingHoursStack.addArrangedSubview(label)
        }
    }
    
}
