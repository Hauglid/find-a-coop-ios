//
//  StoreInfoViewController.swift
//  Find A Coop
//
//  Created by Karl Thomas Hauglid on 23/11/2022.
//

import Foundation
import UIKit
import SafariServices

class StoreInfoViewController: UIViewController{
    var store: Store?
    
    @IBOutlet weak var openNowLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var openingHoursTodayLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openingHoursStack: UIStackView!
    
    
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
    
    
    @IBAction func phoneTap(_ sender: Any) {
        guard let phoneNumber = store?.phone else { return  }
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func emailTap(_ sender: Any) {
        guard let email = store?.email else { return  }
        guard let url = URL(string: "mailto:\(email)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func addressTap(_ sender: Any) {
        guard let store = store else { return  }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "google.com"
        components.path = "/maps/search/"

        components.queryItems = [
            URLQueryItem(name: "api", value: "1"),
            URLQueryItem(name: "query", value: "\(store.chain) \(store.name) \(store.address)"),
            
        ]
        guard let url = components.url,
              UIApplication.shared.canOpenURL(url) else {
            print("Cannot open map")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @IBAction func offerTap(_ sender: Any) {
        guard let store = store else { return  }
        
        
        guard let url = URL(string: store.newspaperUrl),
              UIApplication.shared.canOpenURL(url) else {
            print("Cannot open offer")
            return
        }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
}
