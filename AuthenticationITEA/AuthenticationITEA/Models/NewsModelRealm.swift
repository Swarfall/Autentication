//
//  NewsModel.swift
//  AuthenticationITEA
//
//  Created by admin on 7/25/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import Foundation
import RealmSwift

class NewsModelRealm: Object {
    
   @objc dynamic var name: String?
   @objc dynamic var title: String?
   @objc dynamic var descriptionText: String?
   @objc dynamic var urlImage: String?
   @objc dynamic var urlSite: String?
}
