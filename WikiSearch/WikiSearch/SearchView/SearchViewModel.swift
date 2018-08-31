//
//  SearchViewModel.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 01/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation

class SearchViewModel {

	let dataSource: [Page] = []

	static func initViewModel() -> SearchViewModel {
		let viewModel = SearchViewModel()
		return viewModel
	}

	func search(text: String) {
		let url = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpslimit=10&gpssearch=" + text
		let manager: NetworkManager = NetworkManager()
		manager.get(urlString: url, params: nil, headers: nil, body: nil, success: { (response, responsData) in
			print(responsData)
		}) { (response, responseData, error) in
			print(response)
		}
	}

}
