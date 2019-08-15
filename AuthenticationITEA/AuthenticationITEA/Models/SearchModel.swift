//
//  SearchModel.swift
//  AuthenticationITEA
//
//  Created by admin on 7/28/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import Foundation

class SearchModel {
    
    var apiKey: String = "c91bb84d6c1b4726a0329ec4cf5ad161"
    var pageNumber: Int = 1
    var pageSize: Int = 10
    var maxPageSize: Int = 100
    var searchKey: String = "Ukraine"
    var dataFrom: Date = setFromDate()
    var dataTo: Date = setToDate()
    
    private static func setFromDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "2019-07-21") ?? Date()
    }
    
    private static func setToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "2019-08-11 ") ?? Date()
    }
    
    func returnDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
