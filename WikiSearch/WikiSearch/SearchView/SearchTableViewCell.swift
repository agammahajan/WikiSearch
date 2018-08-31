//
//  SearchTableViewCell.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 01/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {

	@IBOutlet weak var thumbnail: UIImageView!
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var descriptionText: UILabel!

	func populateData(data: Page) {
		if let imageurl = data.imageUrl {
			self.thumbnail.setImageWithUrl(urlString: imageurl as NSString, placeholderImage: nil)
		}
		self.title.text = data.title
		self.descriptionText.text = data.descriptionText
	}
	
}
