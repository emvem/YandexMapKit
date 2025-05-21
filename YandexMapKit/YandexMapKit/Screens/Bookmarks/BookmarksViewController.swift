//
//  BookmarksViewController.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import UIKit

class BookmarksViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        tableView.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.reuseId)
        view.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 0.5)
    }
}

extension BookmarksViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.reuseId, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

