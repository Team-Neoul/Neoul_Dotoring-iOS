//
//  Signup2View.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/21.
//

import UIKit


class Signup2View: UIView {
    
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    
    // // 클로저 property 추가
    var certificateUploadButtonActionHandler: (() -> Void)?
    var nextButtonActionHandler: (() -> Void)?
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var stepBar: SignupStepBar = {
        if uiStyle == .mento {
            return SignupStepBar(stepCount: 6, currentStep: 2, style: .mento)
        } else {
            return SignupStepBar(stepCount: 6, currentStep: 2, style: .mentee)
        }
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 24)
        let text = "Q. 증빙서류를 업로드해 주세요."
        label.numberOfLines = 0
        label.text = text
        var attrStrColor = UIColor.label
        if uiStyle == .mento {
            attrStrColor = .BaseGreen!
        } else {
            attrStrColor = .BaseNavy!
        }
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: attrStrColor, range: (text as NSString).range(of: "증빙서류"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var content1Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        var text = "A. 재학증명서 업로드하기"
        var attrRangeText = "재학증명서"
        var attrStrColor = UIColor.label
        
        if uiStyle == .mento {
            attrStrColor = .BaseGreen!
        } else {
            attrStrColor = .BaseNavy!
        }
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 20), range: (text as NSString).range(of: attrRangeText))
        
        // 텍스트와 밑줄 사이에 간격 추가
        let spacing: CGFloat = 2
        attributedStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: attrRangeText))
        attributedStr.addAttribute(.baselineOffset, value: spacing, range: (text as NSString).range(of: attrRangeText))
        
        label.attributedText = attributedStr
        
        return label
    }()
    
    lazy var certificateUploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("PDF 또는 이미지", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "FileSelectBtnImg"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(certificateUploadButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var nextButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
//        updateUI()
        setupSubViews()
    }

}


private extension Signup2View {
    
    func setupSubViews() {
        [stepBar, titleLabel, nextButton].forEach {addSubview($0)}
        
        [content1Label, certificateUploadButton].forEach {addSubview($0)}
        
        stepBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(17)
            if screenHeight <= 568 {
                $0.top.equalToSuperview().inset(70)
            } else {
                $0.top.equalToSuperview().offset(147).priority(.low)
                $0.top.greaterThanOrEqualToSuperview().inset(30).priority(.required)
            }
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(stepBar.snp.leading)
            $0.top.equalTo(stepBar.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(17)
        }
        
        content1Label.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(65)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        certificateUploadButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(content1Label.snp.leading)
            $0.top.equalTo(content1Label.snp.bottom).offset(18)
            $0.height.equalTo(86)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(certificateUploadButton.snp.leading)
            $0.top.equalTo(certificateUploadButton.snp.bottom).offset(55)
            $0.height.equalTo(nextButton.snp.width).multipliedBy(0.14)
        }
        
        
    }
}

extension Signup2View {
    
    @objc func certificateUploadButtonTapped(sender: UIButton!) {
        certificateUploadButtonActionHandler?()
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        nextButtonActionHandler?()
    }
    
}
