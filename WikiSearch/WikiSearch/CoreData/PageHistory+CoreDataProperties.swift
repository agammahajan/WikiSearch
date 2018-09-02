//
//  PageHistory+CoreDataProperties.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 02/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//
//

import Foundation
import CoreData


extension PageHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PageHistory> {
        return NSFetchRequest<PageHistory>(entityName: "PageHistory")
    }

    @NSManaged public var pageId: Int64
    @NSManaged public var title: String?

}
