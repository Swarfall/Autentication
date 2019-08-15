//
//  NewsModel.swift
//  AuthenticationITEA
//
//  Created by admin on 8/9/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import Foundation
import ObjectMapper


class NewsModelMappable: Mappable {
    
    var status: String?
    var totalResults: Int?
    var articles: [NewsModelArticleMappable] = []
    
    required init?(map: Map) {
        do {
            self.status = try map.value("status")
        } catch {
            print("No status present")
        }
    }
    
    func mapping(map: Map) {
        totalResults    <- map["totalResults"]
        articles        <- map["articles"]
    }
}

class NewsModelArticleMappable: Mappable {
    
    var title: String?
    var descriptionText: String?
    var urlToImage: String?
    var sourseName: String?
    var urlSite: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title                 <- map["title"]
        descriptionText       <- map["description"]
        urlToImage            <- map["urlToImage"]
        sourseName            <- map["sourse.name"]
        urlSite               <- map["url"]
    }
}

