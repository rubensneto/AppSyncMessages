//
//  ApiMessage.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 26/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class ApiMessage: NSObject {
    var id: Int!
    var text: String?
    var image: UIImage?
    var timestamp: Date!
    var sender: ApiProfile!
}
