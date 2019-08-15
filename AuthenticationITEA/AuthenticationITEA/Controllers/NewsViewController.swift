//
//  NewsViewController.swift
//  AuthenticationITEA
//
//  Created by admin on 7/25/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import ObjectMapper

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var newsModel: [NewsModel] = []
    var newsListMappable: [NewsModelArticleMappable] = []
    var searchModel = SearchModel()
    var newsListRealm: [NewsModelRealm] = []

    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newsCell = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(newsCell, forCellReuseIdentifier: "NewsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isConnectedToNetwork()
    }
    
    func getData() {
        var parameters: [String: Any] = [:]
        parameters["q"] = searchModel.searchKey
        parameters["apiKey"] = searchModel.apiKey
        parameters["from"] = searchModel.dataFrom
        parameters["to"] = searchModel.dataTo
        parameters["pageSize"] = searchModel.pageSize
        parameters["page"] = searchModel.pageNumber
        
        Alamofire.request("https://newsapi.org/v2/everything", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            let news = Mapper<NewsModelMappable>().map(JSONObject: response.result.value)
            if let articles = news?.articles {
                
                self.newsListMappable = articles
                for news in self.newsListMappable {
                    let newsData = NewsModel()
                    newsData.name = news.sourseName
                    newsData.title = news.title
                    newsData.descriptionText = news.descriptionText
                    newsData.urlToImage = news.urlToImage
                    newsData.urlSite = news.urlSite
                    self.newsModel.append(newsData)
                }
                
                self.searchModel.pageNumber += 1
                self.tableView.reloadData()
                self.saveDataToRealmModel()
            }
        }
    }
    
    @IBAction func didTapGoToPopVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func isConnectedToNetwork() {
        if Reachability.isConnectedToNetwork() == true {
            debugPrint("connecting to internet")
            getData()
        } else {
            debugPrint("disconnection")
            convertDataWithRealmToNewsModel()
        }
    }
    
    func saveDataToRealmModel() {
        newsListRealm.removeAll()
        for news in newsModel {
            let realmModel = NewsModelRealm()
            realmModel.name = news.name
            realmModel.title = news.title
            realmModel.descriptionText = news.descriptionText
            realmModel.urlImage = news.urlToImage
            realmModel.urlSite = news.urlSite
            newsListRealm.append(realmModel)
        }
        try! self.realm.write {
        self.realm.add(newsListRealm)
        }
    }
    
    func convertDataWithRealmToNewsModel() {
        let newsRealm = self.realm.objects(NewsModelRealm.self)
        for realm in newsRealm {
            let news = NewsModel()
            news.name = realm.name
            news.title = realm.title
            news.descriptionText = realm.descriptionText
            news.urlToImage = realm.urlImage
            news.urlSite = realm.urlSite
            newsModel.append(news)
        }
        tableView.reloadData()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.update(news: newsModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 >= newsModel.count && newsModel.count < searchModel.maxPageSize {
            getData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let lvlCourseVC = storyboard?.instantiateViewController(withIdentifier: "DetailNewsViewController") as! DetailNewsViewController
        lvlCourseVC.newsModel = newsModel[indexPath.row]
        self.navigationController?.pushViewController(lvlCourseVC, animated: true)
    }
}
