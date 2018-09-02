//
//  HistoryViewModel.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 02/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation

class HistoryViewModel {
	var dataSource: [Page] = []

	static func initViewModel() -> HistoryViewModel {
		let viewModel = HistoryViewModel()
		viewModel.dataSource = SearchedData.sharedInstance.getSavedData()
		return viewModel
	}

}
