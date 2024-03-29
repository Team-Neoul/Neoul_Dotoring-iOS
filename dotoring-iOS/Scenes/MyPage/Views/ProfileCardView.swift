//
//  ProfileCardView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/30.
//

import UIKit

/**
 * 마이페이지 상단에 위치한 사용자의 프로필 카드 View입니다.
 * 닉네임과 프로필 이미지를 포함하고 있습니다.
 */
class ProfileCardView: UIView {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var profileImageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
       
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        if uiStyle == .mento {
            imageView.image = UIImage(named: "MenteeProfileBaseImg")
        } else {
            imageView.image = UIImage(named: "MentoProfileBaseImg")
        }

        return imageView
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 13)
        label.textColor = .white
        if uiStyle == .mento {
            label.text = "도토링 멘토"
        } else {
            label.text = "도토링 멘티"
        }
        
        return label
    }()
    
    lazy var nickNameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 26)
        label.textColor = .white
        label.text = "닉네임"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageBackgroundView.snp.makeConstraints {
            $0.width.equalTo(profileImageBackgroundView.snp.height).multipliedBy(0.9)
        }
    }
    
    func setup() {
        setupSubViews()
    }
    
}

private extension ProfileCardView {
    
    func setupSubViews() {
        [profileImageBackgroundView, titleLabel, nickNameLabel]
            .forEach { addSubview($0) }
        
        profileImageBackgroundView.addSubview(profileImageView)
 
        profileImageBackgroundView.snp.makeConstraints {            $0.top.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(13)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(33)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().offset(28)
            $0.trailing.equalTo(profileImageBackgroundView.snp.leading)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
    }
}
