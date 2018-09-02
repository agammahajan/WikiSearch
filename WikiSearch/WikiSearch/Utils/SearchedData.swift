//
//  SearchedData.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 02/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation
import CoreData

class SearchedData {
	static let sharedInstance: SearchedData = SearchedData()

	private func creatWikiPageEntityFrom(page: Page) -> NSManagedObject? {
		guard let pageId = page.pageId else {
			return nil
		}
		let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PageHistory")
		fetchRequest.predicate = NSPredicate(format: "pageId = %d", pageId)
		do {
			let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
			if let data = objects, data.count > 0 {
				return nil
			}
		} catch let error {
			print(error)
		}
		if let historyPage = NSEntityDescription.insertNewObject(forEntityName: "PageHistory", into: context) as? PageHistory {
			historyPage.title = page.title
			if let pageId64 = Int64(exactly: pageId) {
				historyPage.pageId = pageId64
			}
			return historyPage
		}
		return nil
	}

	func saveInCoreDataWith(page: Page) {
		let _ = self.creatWikiPageEntityFrom(page: page)
		do {
			try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
		} catch let error {
			print(error)
		}
	}
}
