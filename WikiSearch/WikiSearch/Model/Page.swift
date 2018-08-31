//
//  Page.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 01/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation

class Page {
	var pageId: Int?
	var title: String?
	var imageUrl: String?
	var descriptionText: String?

	init(dict: [AnyHashable:Any]) {
		if let pageId = dict["pageid"] as? Int {
			self.pageId = pageId
		}
		if let title = dict["title"] as? String {
			self.title = title
		}
		if let imageData = dict["thumbnail"] as? [String:Any], let imageUrl = imageData["source"] as? String {
			self.imageUrl = imageUrl
		}
		if let terms = dict["terms"] as? [String:Any],
			let descriptionArray = terms["description"] as? [String], !descriptionArray.isEmpty {
			self.descriptionText = descriptionArray.first
		}
	}
}
