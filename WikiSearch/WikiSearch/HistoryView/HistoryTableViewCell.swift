//
//  HistoryTableViewCell.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 02/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableViewCell: UITableViewCell {

	@IBOutlet weak var title: UILabel!

	func populateData(data: Page) {
		self.title.text = data.title
	}

}
