//
//  BookmarksViewController.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import UIKit
import SnapKit
import YandexMapsMobile
import RxSwift
import RxCocoa

class BookmarksViewController: UIViewController {
    
    var repository: BookmarkRepository
    var bookmarks: BehaviorRelay<[Bookmark]> = BehaviorRelay<[Bookmark]>(value: [])
    
    let disposeBag = DisposeBag()
    
    weak var appRouter: AppRouter?
    
    private let tableView = UITableView()
    
    init(
        repository: BookmarkRepository,
        appRouter: AppRouter?
    ) {
        self.repository = repository
        self.appRouter = appRouter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        
        tableView.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.reuseId)
        view.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 0.5)
        
        bindTableView()
    }
    
    func bindTableView() {
        bookmarks
            .bind(to: tableView.rx.items(cellIdentifier: BookmarkCell.reuseId)) { row, element, cell in
                (cell as! BookmarkCell).configure(with: element, completion: { [weak self] in
                    let obj = YMKGeoObject(name: element.title, descriptionText: element.subtitle, geometry: [.init(point: .init(latitude: element.latitude ?? 0, longitude: element.longitude ?? 0))], boundingBox: nil, attributionMap: .init(), metadataContainer: .init(), aref: [])
                    self?.appRouter?.openMapObject(mapObject: obj)
                })
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bookmarks = repository.getBookmarks()
        self.bookmarks.accept(bookmarks)
    }
}

