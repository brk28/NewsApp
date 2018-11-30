//
//  ArticleCollectionViewCell.swift
//  NewsApp
//
//  Created by Burak.Ceylan on 27.11.18.
//  Copyright © 2018 Burak.Ceylan. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    var article: NewsArticle? {
        didSet {
            titleLabel.text = article?.title
            contentLabel.text = article?.content
        }
    }
    
    var buttonAction: ((Any) -> Void)?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addClicked(_ sender: Any) {
        self.buttonAction?(sender)
    }
    
}

