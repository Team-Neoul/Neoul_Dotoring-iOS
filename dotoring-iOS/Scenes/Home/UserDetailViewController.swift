//
//  UserDetailViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/07.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var userID: Int?
    var userDetailInfo: UserDetailInfo?
    var userDetailView: UserDetailView!
    var isReportConfirmButtonClicked: Bool = false
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: UserDetailViewController.self, action: .none)
        let blockAction = UIAction(title: "차단", image: UIImage(systemName: "nosign"), handler: blockButtonActionHandler)
        let reportAction = UIAction(title: "신고", image: UIImage(systemName: "exclamationmark.bubble"), handler: reportButtonActionHandler)
        
        barButtonItem.menu = UIMenu(title: "",
                                    image: nil,
                                    identifier: nil,
                                    options: .displayInline,
                                    children: [blockAction, reportAction])
        
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        fetchUserDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("보여짐\(isReportConfirmButtonClicked)")
        if isReportConfirmButtonClicked == true {
            let text = "신고는 반대 의견을 나타내는\n기능이 아닙니다.\n신고 사유에 맞지 않는 신고를 했을 경우\n해당 신고는 처리되지 않습니다."

            showAlert(
                alertType: .onlyConfirm,
                alertText: text,
                boldText: "해당 신고는 처리되지 않습니다.",
                confirmButtonText: "확인",
                confirmButtonHighlight: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isReportConfirmButtonClicked = false
    }

    override func loadView() {
        super.loadView()
        
        userDetailView = UserDetailView(frame: self.view.frame)
        
//        setButtonAddTarget()

        self.view = userDetailView
    }
    
    private func setNavigationItems() {
        if uiStyle == .mento {
            navigationController?.navigationBar.topItem?.backButtonTitle = "추천 멘티"
        } else {
            navigationController?.navigationBar.topItem?.backButtonTitle = "추천 멘토"
        }
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
}

private extension UserDetailViewController {
    
    func blockButtonActionHandler(sender: UIAction!) {
        showAlert(
            alertType: .canCancel,
            alertText: "닉네임 님을\n차단하시겠습니까?",
            highlightText: "차단",
            hasSecondaryText: true,
            secondaryText: "차단 해제는 마이페이지에서 가능합니다.",
            cancelButtonText: "아니오",
            confirmButtonText: "네",
            changeButtonPosition: true,
            cancelButtonHighlight: true)
    }
    
    func reportButtonActionHandler(sender: UIAction!) {
        
        let vc = ReportReasonAlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
    }
    
    /**
     * 응답 받은 멘티 또는 멘토 상세정보를 view에 적용
     */
    func updateUI(userInfo: UserDetailInfo) {
        
        let profileImageURLString = userInfo.profileImage.replacingOccurrences(of: "http://localhost:8080/", with: API.BASE_URL)
        let profileImageURL = URL(string: profileImageURLString)
        let profilePlaceholdImage: UIImage
        
        userDetailView.userDetailProfileCardView.gradeLabel.text = "\(userInfo.grade) 학년"
        userDetailView.userDetailProfileCardView.nicknameLabel.text = userInfo.nickname
//        userDetailView.introductionContentLabel.text = userInfo.introduction
        userDetailView.userDetailProfileCardView.departmentLabel.text = userInfo.majors.joined(separator: ", ")
        
        if uiStyle == .mento {
            userDetailView.hopeMentoringContentLabel.text = userInfo.preferredMentoring
            profilePlaceholdImage = UIImage(named: "MenteeProfileBaseImg")!
        } else {
            userDetailView.hopeMentoringContentLabel.text = userInfo.mentoringSystem
            profilePlaceholdImage = UIImage(named: "MentoProfileBaseImg")!
        }
        
        userDetailView.userDetailProfileCardView.profileImageView.kf.setImage(with: profileImageURL, placeholder: profilePlaceholdImage)
        
        let userFieldCount =  userInfo.fields.count
        for i in 0..<userFieldCount {
            let fieldRectView = FieldRectView()
            fieldRectView.contentLabel.text = "\(userInfo.fields[i])"
            userDetailView.fieldStackView.addArrangedSubview(fieldRectView)
        }
        
        let userTagCount = userInfo.tags.count
        for i in 0..<userTagCount {
            let tagView = TagTextField(isEnabled: false)
            tagView.textField.text = userInfo.tags[i]
            tagView.backgroundColor = .BaseGray100
            userDetailView.tagSubStackView.addArrangedSubview(tagView)
        }
    }
    
    /**
     * 멘티 또는 멘토 상세정보를 요청하고 받습니다.
     */
    func fetchUserDetail() {
        self.view.makeToastActivity(.center)
        // 예외처리 하기
        guard let unwrappedUserID = userID else { return }
        
        HomeNetworkService.fetchUserDetail(uiStyle: uiStyle, userID: unwrappedUserID) { response, error in
            
            if error != nil {
                // 유저 상세정보 요청 오류 발생
                print("유저 상세정보 요청 오류 발생 : \(error?.asAFError?.responseCode ?? 0)")
                if let statusCode = error?.asAFError?.responseCode {
                    Alert.showAlert(title: " 유저 상세정보 요청 오류 발생", message: "\(statusCode)")
                } else {
                    Alert.showAlert(title: " 유저 상세정보 요청 오류 발생", message: "네트워크 연결을 확인하세요.")
                }
            } else {
                if response?.success == true {
                    guard let data = response?.response else { return }
                    self.userDetailInfo = data
                    guard let unwrapedUserDetailInfo = self.userDetailInfo else { return }
                    self.updateUI(userInfo: unwrapedUserDetailInfo)
                } else {
                    Alert.showAlert(title: "오류", message: "알 수 없는 오류입니다. 다시 시도해 주세요. code : \(response?.error?.code ?? "0")")
                }
            }
        }
        self.view.hideToastActivity()
    }
}

extension UserDetailViewController: CustomAlertDelegate {
    func action() {
        return
    }
    
    func exit() {
        return
    }
    
}
