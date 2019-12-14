//
//  Protocols.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import UIKit

protocol ControllerMainFunctions {
    func setUIElements(title: String?, viewDelegation: [UIView]?)
}

protocol CellMainFunctions: UITableViewCell {
    func populateCell(with: Any?)
}

protocol CollectionCellMainFunctions: UICollectionViewCell {
    func populateCell(with: Any?)
}
