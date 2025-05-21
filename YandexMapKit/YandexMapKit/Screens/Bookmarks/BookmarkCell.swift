//
//  BookmarkCell.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import UIKit
import SnapKit

class BookmarkCell: UITableViewCell {
    
    static let reuseId = String(describing: BookmarkCell.self)
    
    let backgroundContentView = UIView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(red: 176/255, green: 171/255, blue: 171/255, alpha: 1)
        return label
    }()

    lazy var bookmarkIcon: UIButton = {
        let action: UIAction = UIAction { _ in
            print("tap")
        }
        var configuration = UIButton.Configuration.plain()
        let button = UIButton(configuration: configuration, primaryAction: action)
        button.setImage(UIImage(named: "favorite_pin"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configureUI() {
        nameLabel.text = "Le Grande Plaza Hotel"
        addressLabel.text = "ул. Узбекистон Овози, 2"

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        backgroundContentView.layer.cornerRadius = 12
        backgroundContentView.backgroundColor = .white
        
        contentView.addSubview(backgroundContentView)
        backgroundContentView.addSubview(nameLabel)
        backgroundContentView.addSubview(addressLabel)
        backgroundContentView.addSubview(bookmarkIcon)
        
        backgroundContentView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(backgroundContentView.snp.centerY)
            $0.trailing.equalTo(bookmarkIcon).offset(-8)
        }
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(backgroundContentView.snp.centerY)
            $0.trailing.equalTo(bookmarkIcon).offset(-8)
        }
        
        bookmarkIcon.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        
    }
}
