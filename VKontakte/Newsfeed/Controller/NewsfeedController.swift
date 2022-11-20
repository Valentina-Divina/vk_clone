//
//  NewsfeedController.swift
//  VKontakte
//
//  Created by Valya on 03.07.2022.
//

import UIKit
import SnapKit

class NewsfeedController: UITableViewController {
    
    private var posts: [Post]?
    
    private let repository = NewsFeedRepository()
    private var cacheHandler: ImageCaсheHandler? = nil
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.register(UINib(nibName: String(describing: HeaderCell.self), bundle: nil), forCellReuseIdentifier: "HeaderCellID")
        tableView.register(UINib(nibName: String(describing: CaptionCell.self), bundle: nil), forCellReuseIdentifier: "CaptionllID")
        tableView.register(UINib(nibName: String(describing: ImagesCell.self), bundle: nil), forCellReuseIdentifier: "ImagesCellID")
        tableView.register(UINib(nibName: String(describing: FooterCell.self), bundle: nil), forCellReuseIdentifier: "FooterCellID")
        tableView.prefetchDataSource = self
        cacheHandler = ImageCaсheHandler(container: tableView)
        
        fetchPosts()
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .black
        refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        print("REFRESH")
        DispatchQueue.global().async {
            self.repository.getPosts { result in
                DispatchQueue.main.async {
                    self.posts = result
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    func fetchPosts() {
        
        DispatchQueue.global().async {
            self.repository.getPosts { result in
                DispatchQueue.main.async {
                    self.posts = result
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let posts = posts {
            return posts.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts[section].views.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCellID", for: indexPath) as! HeaderCell
        
        switch(posts?[indexPath.section].views[indexPath.row].self) {
        case (let cellData as Header):
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCellID", for: indexPath) as! HeaderCell
            cell.indexPath = indexPath
            cell.header = cellData
            cell.cacheHandler = self.cacheHandler
            
            return cell
        case (let cellData as Caption):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CaptionllID", for: indexPath) as! CaptionCell
            cell.caption = cellData
            cell.redrawCallback = {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            return cell
        case (let cellData as Images):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesCellID", for: indexPath) as! ImagesCell
            cell.indexPath = indexPath
            cell.images = cellData
            cell.cacheHandler = self.cacheHandler
            
            return cell
        case (let cellData as Footer):
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCellID", for: indexPath) as! FooterCell
            cell.footer = cellData
            return cell
        default:
            return cell
        }
    }
}

extension NewsfeedController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxRow = indexPaths.map({$0.section}).max() else {return}
        
        if let post = posts {
            print("maxRow", maxRow)
            if  maxRow > post.count-3, !isLoading {
                isLoading = true
                
                DispatchQueue.global().async {
                    self.repository.getPosts { result in
                        let newPosts = post + result
                        DispatchQueue.main.async {
                            self.posts = newPosts
                            self.tableView.reloadData()
                            self.isLoading = false
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    }
}
