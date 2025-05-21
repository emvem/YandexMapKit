//
//  BookmarksViewController.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import UIKit
import YandexMapsMobile

class BookmarksViewController: UITableViewController {
    
    var repository: BookmarkRepository
    var bookmarks: [Bookmark] = []
    
    weak var appRouter: AppRouter?
    
    init(
        repository: BookmarkRepository,
        appRouter: AppRouter?
    ) {
        self.repository = repository
        self.appRouter = appRouter
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        tableView.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.reuseId)
        view.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 0.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bookmarks = repository.getBookmarks()
        tableView.reloadData()
    }
}

extension BookmarksViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.reuseId, for: indexPath) as! BookmarkCell
        let bookmark = bookmarks[indexPath.row]
        cell.configure(with: bookmark, completion: { [weak self] in
            let obj = YMKGeoObject(name: bookmark.title, descriptionText: bookmark.subtitle, geometry: [.init(point: .init(latitude: bookmark.latitude ?? 0, longitude: bookmark.longitude ?? 0))], boundingBox: nil, attributionMap: .init(), metadataContainer: .init(), aref: [])
            self?.appRouter?.openMapObject(mapObject: obj)
        })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

