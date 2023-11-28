//
//  MentoSignup1ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/01.
//

import UIKit

class MentoSignup1ViewController: UIViewController {
    
    private lazy var stepBar: SignupStepBar = {
        let bar = SignupStepBar(stepCount: 6, currentStep: 1, style: .mento)
        
        return bar
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 24)
        let text = "Q. 멘토님은 어떤 분인가요?"
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseGreen!, range: (text as NSString).range(of: "멘토"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var content1Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "A. 저는"
        
        return label
    }()
    
    private lazy var content2Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "에 다니는"
        
        return label
    }()
    
    private lazy var content3Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "학년"
        
        return label
    }()
    
    private lazy var content4Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "멘토입니다."
        
        return label
    }()
    
    private lazy var content5Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "저는 대학교에서"
        
        return label
    }()
    
    private lazy var content6Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "를 다녔어요."
        
        return label
    }()
    
    private lazy var companyTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "학교", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var yearTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        lineTextField.textField.keyboardType = .numberPad
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "학년", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var jobTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        lineTextField.isUserInteractionEnabled = false

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "멘토링 분야", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var jobTextFieldButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectTextFieldTapped), for: .touchUpInside)
               
        return button
    }()
    
    private lazy var departmentTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.textAlignment = .center
        lineTextField.isUserInteractionEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let centeredPlaceholder = NSAttributedString(string: "학과", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        lineTextField.textField.attributedPlaceholder = centeredPlaceholder
        
        return lineTextField
    }()
    
    private lazy var departmentTextFieldButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectTextFieldTapped), for: .touchUpInside)
               
        return button
    }()
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        self.hideKeyboardWhenTappedAround()
        setupSubViews()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        let vc = Signup2ViewController()
        navigationController?.pushViewController(vc, animated: false)
    }

}

private extension MentoSignup1ViewController {
    
    func setupUI() {
        self.navigationController?.navigationBar.tintColor = .BaseGray700
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel()
        titleLabel.text = "멘토로 회원가입"
        titleLabel.textColor = UIColor.label // 전체 글씨 색상
        titleLabel.font = .nanumSquare(style: .NanumSquareOTFR, size: 15)
        titleLabel.sizeToFit()

        let mentorRange = (titleLabel.text! as NSString).range(of: "멘토")
        let attributedString = NSMutableAttributedString(string: titleLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.BaseGreen!, range: mentorRange)

        titleLabel.attributedText = attributedString

        self.navigationItem.titleView = titleLabel
    
    }
    
    func setupSubViews() {
        
        [stepBar, titleLabel, nextButton, jobTextFieldButton, departmentTextFieldButton].forEach {view.addSubview($0)}
        
        [content1Label, content2Label, content3Label, content4Label, content5Label, content6Label].forEach {view.addSubview($0)}
        
        [companyTextField, yearTextField, jobTextField, departmentTextField].forEach {view.addSubview($0)}
        
        stepBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(17)
            $0.top.equalToSuperview().offset(147)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(stepBar.snp.leading)
            $0.top.equalTo(stepBar.snp.bottom).offset(20)
        }
        
        content1Label.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(65)
        }
        
        companyTextField.snp.makeConstraints {
            $0.centerY.equalTo(content1Label)
            $0.leading.equalTo(content1Label.snp.trailing).offset(17)
            $0.width.equalTo(100)
        }
        
        content2Label.snp.makeConstraints {
            $0.centerY.equalTo(companyTextField)
            $0.leading.equalTo(companyTextField.snp.trailing).offset(17)
        }
        
        yearTextField.snp.makeConstraints {
            $0.centerX.equalTo(companyTextField)
            $0.top.equalTo(companyTextField.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        content3Label.snp.makeConstraints {
            $0.centerY.equalTo(yearTextField)
            $0.leading.equalTo(yearTextField.snp.trailing).offset(17)
        }
        
        jobTextField.snp.makeConstraints {
            $0.centerX.equalTo(yearTextField)
            $0.top.equalTo(yearTextField.snp.bottom).offset(20)
            $0.width.equalTo(100)
        }
        
        content4Label.snp.makeConstraints {
            $0.centerY.equalTo(jobTextField)
            $0.leading.equalTo(jobTextField.snp.trailing).offset(17)
        }
        
        content5Label.snp.makeConstraints {
            $0.leading.equalTo(content1Label.snp.leading).offset(25)
            $0.top.equalTo(jobTextField.snp.bottom).offset(26)
        }
        
        departmentTextField.snp.makeConstraints {
            $0.centerX.equalTo(jobTextField)
            $0.top.equalTo(content5Label.snp.bottom).offset(15)
            $0.width.equalTo(100)
        }
        
        content6Label.snp.makeConstraints {
            $0.centerY.equalTo(departmentTextField)
            $0.leading.equalTo(departmentTextField.snp.trailing).offset(17)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(departmentTextField.snp.bottom).offset(55)
            $0.height.equalTo(48)
        }
        
        jobTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(jobTextField)
            $0.centerX.centerY.equalTo(jobTextField)
        }
        
        departmentTextFieldButton.snp.makeConstraints {
            $0.width.height.equalTo(departmentTextField)
            $0.centerX.centerY.equalTo(departmentTextField)
        }
        
    }
}

extension MentoSignup1ViewController: SelectViewControllerDelegate {
    
    @objc private func selectTextFieldTapped(sender: UIButton) {
        let vc = SelectViewController()
        if sender == jobTextFieldButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "직무 분야 선택"
            vc.style = .mento
        } else if sender == departmentTextFieldButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "학과 선택"
            vc.style = .mento
        } else {
            vc.selectViewControllerDelegate = self
            vc.titleText = "필터"
        }
        vc.sender = sender
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
            sheet.prefersGrabberVisible = true
       }
       present(vc, animated: true)
    }
    
    // 직무선택, 학과선택 뷰컨트롤러 화면이 사라질 때 선택한 데이터를 받음
    func didSelectViewControllerDismiss(elements: [String], selectedElements: [Int], sender: UIButton) {
        // 선택한 데이터가 0개 이상일 때만 데이터 저장 및 뷰 수정
        if selectedElements.count > 0 {
            // 이 뷰컨트롤러에 데이터 저장하는 코드 추가해야 됨
            var selectedElementString: String = ""
            for selectedElement in selectedElements {
                print(elements[selectedElement])
                selectedElementString += (elements[selectedElement]+", ")
            }
            selectedElementString = String(selectedElementString.dropLast(2))
            
            if sender == jobTextFieldButton { // 직무 선택일 때
                jobTextField.textField.text = selectedElementString
            } else { // 학과 선택일 때
                departmentTextField.textField.text = selectedElementString
            }
            
        }
        
    }
    
}
