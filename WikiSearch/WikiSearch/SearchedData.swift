//
//  SearchedData.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 02/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation

class SearchedData {
	static let sharedInstance: SearchedData = SearchedData()
	private var searchedData: [Page] = []

	func saveData(newPage: Page) {
		if !searchedData.contains(where: {$0.pageId == newPage.pageId}) {
			SearchedData.sharedInstance.searchedData.append(newPage)
		}
	}

	func getSavedData() -> [Page] {
		return searchedData
	}
}
