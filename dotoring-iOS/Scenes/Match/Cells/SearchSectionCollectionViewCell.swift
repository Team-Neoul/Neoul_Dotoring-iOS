//
//  SearchSectionCollectionViewCell.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/3/24.
//

import Foundation
import UIKit

final class SearchSectionCollectionViewCell: UICollectionViewCell {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()

    lazy var businessNameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 20)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "지원사업명"

        return label
    }()
    
    lazy var nicknameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.text = "닉네임"
        if uiStyle == .mento {
            label.textColor = .BaseGreen
        } else {
            label.textColor = .BaseNavy
        }
        
        return label
    }()

    lazy var dateLabel: NanumLabel = {
        let label = NanumLabel(weightType: .L, size: 13)
        label.textColor = .BaseGray600
        label.text = "00월 00일"

        return label
    }()
    
    private lazy var participantsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ParticipantsImg")
        
        return imageView
    }()
    
    lazy var participantsCountLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 13)
        label.text = "0"
        label.textColor = .BaseGray600
        
        return label
    }()
    
    lazy var shutterView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 0.5)
        view.isHidden = true
        view.layer.cornerRadius = 10
        
        let label = NanumLabel(weightType: .B, size: 20)
        label.text = "마감"
        label.textColor = .white
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        return view
    }()

    func setup() {
        setupLayout()

//        titleLabel.text = rankingFeature.title
//        descriptionLabel.text = rankingFeature.description
//        inAppPurchaseInfoLabel.isHidden = !rankingFeature.isInPurchaseApp
        
        // 셀에 둥근 코너와 그림자 적용
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4.0
    }

}

// MARK: Private
private extension SearchSectionCollectionViewCell {
    func setupLayout() {
        [
           businessNameLabel,
           dateLabel,
           nicknameLabel,
           participantsImageView,
           participantsCountLabel,
           shutterView
        ].forEach { contentView.addSubview($0) }

        businessNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.top.equalToSuperview().inset(12)
        }

        dateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.trailing.equalTo(dateLabel.snp.trailing)
            $0.bottom.equalTo(dateLabel.snp.top).offset(-5)
        }
        
        participantsImageView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(14)
            $0.width.equalTo(12)
        }
        
        participantsCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(participantsImageView)
            $0.leading.equalTo(participantsImageView.snp.trailing).offset(2)
        }
        
        shutterView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

