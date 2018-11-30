//
//  ViewController.swift
//  NewsApp
//
//  Created by Burak.Ceylan on 27.11.18.
//  Copyright © 2018 Burak.Ceylan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct ArticleStorage {
    static var articles: [NewsArticle] = []
    
    static func getBookmarkCount() -> Int{
        return articles.filter{$0.bookmarked == true}.count
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var bookmarkCountButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //  --------------Networking Stuff-----------------
    
    let urlSession = URLSession.shared
    
    let strUrl = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=c385e111c90a4101a4269c260141e7db"
    
    func fetchNewsArticles() {
        guard let url = URL(string: strUrl) else {return}
        urlSession.dataTask(with: url) { (data, response, error) in
            // Error Handling
            guard error == nil else {return}
            // Response Handling
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else { return }
            // Parsing
            guard let newsResponse = try? JSONDecoder().decode(NewsResponse.self, from: data) else { return }
            
            ArticleStorage.articles = newsResponse.articles
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }.resume()
    }
    
    // -------------------------------------------------
    
    @IBAction func openBookmarks(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookmarkViewController") as? BookmarkViewController else {
            return
        }
        vc.bookmarkedArticles = ArticleStorage.articles.filter{$0.bookmarked == true}
        present(vc, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchNewsArticles()
    }
}

//  --------------Data Source-----------------

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as? ArticleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.article = ArticleStorage.articles[indexPath.row]
        cell.buttonAction = { _ in
            ArticleStorage.articles[indexPath.row].bookmarked = true
            cell.addButton.isEnabled = false
            self.bookmarkCountButton.title = "\(ArticleStorage.getBookmarkCount())"
            
        }
        cell.addButton.isEnabled = ArticleStorage.articles[indexPath.row].bookmarked ? false : true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArticleStorage.articles.count
    }
}


// ------------------------------------------

extension ViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height: CGFloat = 300.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
}
