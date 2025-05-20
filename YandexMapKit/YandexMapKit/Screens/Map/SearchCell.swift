//
//  SearchCell.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    
    static let reuseId = String(describing: SearchCell.self)
        
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
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        return label
    }()

    lazy var icon: UIButton = {
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
        distanceLabel.text = "36 м"
        addressLabel.text = "ул. Узбекистон Овози, 2"

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
                
        contentView.addSubview(icon)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(distanceLabel)

        icon.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(16)
            $0.bottom.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(distanceLabel.snp.leading).offset(-8)
        }
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(16)
            $0.top.equalTo(contentView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
    }
}
