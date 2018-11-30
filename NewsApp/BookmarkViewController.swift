//
//  BookmarkViewController.swift
//  NewsApp
//
//  Created by Burak.Ceylan on 30.11.18.
//  Copyright © 2018 Burak.Ceylan. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController {

    
    var bookmarkedArticles: [NewsArticle] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension BookmarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath) as? BookmarkTableViewCell else {
            return UITableViewCell()
        }
        let article = bookmarkedArticles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.contentLabel.text = article.content
        return cell
    }
    
    
}


extension BookmarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
