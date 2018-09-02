//
//  HistoryViewModel.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 02/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation
import CoreData

protocol HistoryViewModelDelegate: class {
	func deleteRows(index: IndexPath)
	func insertRows(index: IndexPath)
	func beginUpdates()
	func endUpdates()
}

class HistoryViewModel: NSObject {

	weak var delegate: HistoryViewModelDelegate!

	static func initViewModel() -> HistoryViewModel {
		let viewModel = HistoryViewModel()

		do {
			try viewModel.fetchedhResultController.performFetch()
			print("COUNT FETCHED FIRST: \(String(describing: viewModel.fetchedhResultController.sections?[0].numberOfObjects))")
		} catch let error  {
			print("ERROR: \(error)")
		}

		return viewModel
	}

	lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PageHistory")
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "pageId", ascending: true)]
		fetchRequest.fetchBatchSize = 25
		let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
		return frc
	}()

	private func clearData() {
		do {
			let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
			let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PageHistory")
			do {
				let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
				_ = objects.map{$0.map{context.delete($0)}}
				CoreDataStack.sharedInstance.saveContext()
			} catch let error {
				print("ERROR DELETING : \(error)")
			}
		}
	}
}

extension HistoryViewModel: NSFetchedResultsControllerDelegate {

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		switch type {
		case .insert:
			delegate.insertRows(index: newIndexPath!)

		case .delete:
			delegate.insertRows(index: indexPath!)

		default:
			break
		}
	}
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		delegate.endUpdates()
	}

	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		delegate.beginUpdates()
	}
}
