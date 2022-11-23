//
//  StoreTableViewCell.swift
//  Find A Coop
//
//  Created by Karl Thomas Hauglid on 22/11/2022.
//

import UIKit

final class StoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var openingHoursLabel: UILabel!
 
    
    override func prepareForReuse() {
        super.prepareForReuse()
        storeNameLabel.text = ""
        openingHoursLabel.text = ""
    }
    
    
    func configure(model: Store) {
        self.storeNameLabel.text = model.name
        self.openingHoursLabel.text = model.openingHoursToday
    }
}
