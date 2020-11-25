//
//  ViewController.swift
//  Bears-Nation
//
//  Created by Nao Yanase on 11/24/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let dummyArticleNames = ["Title One", "Title Two", "Title Three", "Title Four"]
    
    struct APIResults:Decodable {
        let _id: String
        let title: String
        let content: String
    }
    
    var articles: APIResults? = APIResults(_id: "", title: "", content: "")
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyArticleNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        
        let titleView = UIView(frame: CGRect(x: 0, y: cell.bounds.size.height*3/4, width: cell.bounds.size.width, height: cell.bounds.size.height/4))
        titleView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let articleTitle = UILabel(frame: CGRect(x: 0, y: 0, width: titleView.bounds.size.width, height: titleView.bounds.size.height))
        articleTitle.text = dummyArticleNames[indexPath.row]
        articleTitle.textAlignment = .center
        articleTitle.textColor = .black
        
        titleView.addSubview(articleTitle)
        
        cell.contentView.addSubview(titleView)
        cell.backgroundColor = UIColor(named: "WashUGreen")
    
        return cell
    }
    
    func fetchMovies() {
        guard let url = URL(string: "https://bears-nation-api.herokuapp.com/articles") else {return}
        
        DispatchQueue.global().async {
            do {
                guard let data = try? Data(contentsOf: url) else {return}
                print(data)
                self.articles = try? JSONDecoder().decode(APIResults.self, from: data)
                print(self.articles)
            }
        }
    }
    
    func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        fetchMovies()
        
    }


}

