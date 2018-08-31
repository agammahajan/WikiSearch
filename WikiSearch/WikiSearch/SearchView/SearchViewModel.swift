//
//  SearchViewModel.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 01/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate: class {
	func dataFetched()
}

class SearchViewModel {

	var dataSource: [Page] = []
	weak var delegate: SearchViewModelDelegate!

	static func initViewModel() -> SearchViewModel {
		let viewModel = SearchViewModel()
		return viewModel
	}

	func search(text: String) {
		let url = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpslimit=10&gpssearch=" + text
		let manager: NetworkManager = NetworkManager()
		manager.get(urlString: url, params: nil, headers: nil, body: nil, success: { [weak self] (response, responsData) in
			guard let data = responsData,let query = data["query"] as? [AnyHashable: Any], let pages = query["pages"] as? [[AnyHashable: Any]] else {return}
			self?.parseData(data: pages)

		}) { (response, responseData, error) in

		}
	}

	private func parseData(data: [[AnyHashable: Any]]) {
		dataSource = data.compactMap({ Page.init(dict: $0) })
		delegate.dataFetched()
	}

}
