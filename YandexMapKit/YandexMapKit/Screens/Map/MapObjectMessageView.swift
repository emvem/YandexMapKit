//
//  MapObjectMessageView.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import UIKit
import SnapKit
import SwiftMessages
import YandexMapsMobile

class MapObjectMessageView: MessageView {
    private lazy var closeButton: UIButton = {
        let action: UIAction = UIAction { [weak self] _ in
            guard let id = self?.id else {
                return
            }
            SwiftMessages.hide(id: id)
        }
        var configuration = UIButton.Configuration.plain()
        let button = UIButton(configuration: configuration, primaryAction: action)
        button.setImage(UIImage(named: "close_big"), for: .normal)
        return button
    }()
    
    private let indicatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 208/255, green: 207/255, blue: 207/255, alpha: 1)
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let messageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
            
    private let messageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 176/255, green: 171/255, blue: 171/255, alpha: 1)
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        for i in 0..<5 {
            let image = UIImage(named: i == 4 ? "star" : "star_fill")
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(imageView)
        }
        let label = UILabel()
        label.text = "517 оценок"
        label.textColor = UIColor(red: 176/255, green: 171/255, blue: 171/255, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        stackView.addArrangedSubview(label)
        return stackView
    }()

    private lazy var continueButton: UIButton = {
        let action: UIAction = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.completion?(self.mapObject)
        }
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .white
        let button = UIButton(configuration: configuration, primaryAction: action)
        button.backgroundColor = UIColor(red: 91/255, green: 194/255, blue: 80/255, alpha: 1)
        button.setTitle("Добавить в избранное", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 21
        return button
    }()

    
    let cornerBackgroundView = CornerRoundingView(frame: .zero)
    
    private var completion: ((YMKGeoObject) -> Void)?
    private let mapObject: YMKGeoObject
    
    init(mapObject: YMKGeoObject,
         completion: ((YMKGeoObject) -> Void)?) {
        self.mapObject = mapObject
        self.completion = completion
        super.init(frame: .zero)
        messageTitleLabel.text = mapObject.name
        messageDescriptionLabel.text = mapObject.descriptionText
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundView = cornerBackgroundView
        cornerBackgroundView.backgroundColor = UIColor.white

        addSubview(cornerBackgroundView)
        cornerBackgroundView.addSubview(indicatorLine)
        cornerBackgroundView.addSubview(messageTitleLabel)
        cornerBackgroundView.addSubview(closeButton)
        cornerBackgroundView.addSubview(messageDescriptionLabel)
        cornerBackgroundView.addSubview(ratingStackView)
        cornerBackgroundView.addSubview(continueButton)

        cornerBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        indicatorLine.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.width.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
        }
        
        messageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(indicatorLine.snp.bottom).offset(32)
            $0.height.equalTo(20)
            $0.left.equalToSuperview().offset(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(messageTitleLabel)
            $0.right.equalToSuperview().offset(-16)
        }
        
        messageDescriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(20)
            $0.top.equalTo(messageTitleLabel.snp.bottom).offset(8)
            $0.right.equalToSuperview().offset(-16)
        }
        
        ratingStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(20)
            $0.top.equalTo(messageDescriptionLabel.snp.bottom).offset(16)
        }

        continueButton.snp.makeConstraints {
            $0.top.equalTo(ratingStackView.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(220)
            $0.height.equalTo(42)
            $0.bottom.equalToSuperview().offset(-40)
        }
        
    }
}
