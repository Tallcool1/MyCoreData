//
//  MyCoreData.swift
//  MyCoreData
//
//  Created by webstudent on 3/16/15.
//  Copyright (c) 2015 rock Valley College. All rights reserved.
//

import Foundation
import CoreData

class MyCoreData: NSManagedObject {

    @NSManaged var album: String
    @NSManaged var artist: String
    @NSManaged var genere: String
    @NSManaged var songtitle: String

}
