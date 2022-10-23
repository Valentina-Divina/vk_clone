//
//  NewsfeedController.swift
//  VKontakte
//
//  Created by Valya on 03.07.2022.
//

import UIKit
import SnapKit

class NewsfeedController: UITableViewController {
    
    var posts: [Post]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.register(UINib(nibName: String(describing: HeaderCell.self), bundle: nil), forCellReuseIdentifier: "HeaderCellID")
        tableView.register(UINib(nibName: String(describing: CaptionCell.self), bundle: nil), forCellReuseIdentifier: "CaptionllID")
        tableView.register(UINib(nibName: String(describing: ImagesCell.self), bundle: nil), forCellReuseIdentifier: "ImagesCellID")
        tableView.register(UINib(nibName: String(describing: FooterCell.self), bundle: nil), forCellReuseIdentifier: "FooterCellID")

    }
    
    func fetchPosts() {
        posts = Post.fetchPosts()
        tableView.reloadData()
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
            cell.header = cellData
           // print("хуй \(cellData)")
            return cell
        case (let cellData as Caption):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CaptionllID", for: indexPath) as! CaptionCell
            cell.caption = cellData
            return cell
            
        case (let cellData as Images):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesCellID", for: indexPath) as! ImagesCell
            cell.images = cellData
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

