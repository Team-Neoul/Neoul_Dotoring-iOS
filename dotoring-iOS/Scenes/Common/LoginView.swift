//
//  LoginView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/27.
//

import UIKit

final class LoginView: UIView {
    
    private lazy var smallLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "SmallGrayDotoriLogoImg")

        return imageView
    }()
    
    private lazy var navTitle: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 20)
        label.textColor = .BaseSecondaryEmhasisGray
        label.text = "도토링"
        
        return label
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "LoginBackgroundImg")

        return imageView
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 24)
        label.textColor = .label
        label.text = "<전남대학교> 선배와 후배를 한 공간에서 만나 보세요."
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var subTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .L, size: 13)
        label.textColor = .label
        label.text = "회원서비스 이용을 위해 로그인해 주세요."
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var idTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.placeholder = "아이디"
        
        return lineTextField
    }()
    
    private lazy var pwTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.placeholder = "비밀번호"
        lineTextField.textField.isSecureTextEntry = true
        
        return lineTextField
    }()
    
    private lazy var loginButton: ClearButton = {
        let button = ClearButton()
        button.setTitle("로그인", for: .normal)
        
        return button
    }()
    
    private lazy var autoLoginCheckBox: CheckBox = {
        let checkBout = CheckBox()
        checkBout.tintColor = .black
        
        return checkBout
    }()
    
    private lazy var autoLoginLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "자동 로그인"
        
        return label
    }()
    
    private lazy var warningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "존재하지 않는 계정입니다. 다시 입력해 주세요."
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var accountStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
//        stack.spacing = 0
        
        return stack
    }()
    
    private lazy var findIdButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFL, size: 12)
        
        return button
    }()
    
    private lazy var findPwButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFL, size: 12)
        
        return button
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFL, size: 12)
        
        return button
    }()
    
    private lazy var line1: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var line2: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
}

private extension LoginView {
    
    func setup() {
        setupSubViews()
    }
    
    func setupSubViews() {
        [navTitle, smallLogoImageView, backgroundImageView, titleLabel, subTitleLabel, idTextField, pwTextField, autoLoginCheckBox, autoLoginLabel, warningLabel, loginButton, accountStack].forEach { addSubview($0) }
        
//        accountStack.addArrangedSubview(findIdButton)
        [findIdButton, line1, findPwButton, line2, signupButton].forEach { accountStack.addArrangedSubview($0)}
        
        smallLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(38.0)
            $0.top.equalToSuperview().inset(83.0)
        }
        
        navTitle.snp.makeConstraints {
            $0.centerY.equalTo(smallLogoImageView)
            $0.leading.equalTo(smallLogoImageView.snp.trailing).offset(5.64)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(00.0)
            $0.bottom.equalToSuperview().inset(29.66)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(35.0)
            $0.top.equalToSuperview().offset(218.0)
            $0.trailing.equalToSuperview().inset(92.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(6.0)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(105.0)
            $0.leading.trailing.equalToSuperview().inset(35.0)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(45.0)
            $0.leading.trailing.equalToSuperview().inset(35.0)
        }
        
        autoLoginCheckBox.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(35.0)
            $0.top.equalTo(pwTextField.snp.bottom).offset(11.0)
            $0.width.height.equalTo(14.0)
        }
        
        autoLoginLabel.snp.makeConstraints {
            $0.centerY.equalTo(autoLoginCheckBox)
            $0.leading.equalTo(autoLoginCheckBox.snp.trailing).offset(4.0)
        }
        
        warningLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(loginButton.snp.top).offset(-10.0)
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.top.equalTo(pwTextField.snp.bottom).offset(70.0)
            $0.height.equalTo(48.0)
        }
        
        accountStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(82.0)
            $0.top.equalTo(loginButton.snp.bottom).offset(15.0)
            $0.height.equalTo(14.0)
        }
        
        line1.snp.makeConstraints {
            $0.width.equalTo(0.3)
        }
        
        line2.snp.makeConstraints {
            $0.width.equalTo(0.3)
        }
        
    }
    
    
}
