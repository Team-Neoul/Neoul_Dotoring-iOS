//
//  MatchViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/1/24.
//

import UIKit
import SnapKit

class MatchViewController: UIViewController {
    let businessNameList = ["교학상장", "캡스톤디자인 지원사업", "기타"]
    let pjtGoalList = ["공모전", "대외활동", "학업", "학교생활", "기타"]
    var selectedBusinessNameElements: [Int] = []
    var selectedPjtGoalElements: [Int] = []
    
    private let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var baseColor: UIColor = {
        if uiStyle == .mento {
            return UIColor.BaseGreen!
        } else {
            return UIColor.BaseNavy!
        }
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let bannerSectionView = BannerSectionView(frame: .zero)
    let searchSectionView = SearchSectionView(frame: .zero)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0

        let spacingView = UIView()
        spacingView.backgroundColor = .systemBackground
        spacingView.snp.makeConstraints {
            $0.height.equalTo(50.0)
        }

        [
            bannerSectionView,
            searchSectionView,
            spacingView
        ].forEach {
            stackView.addArrangedSubview($0)
        }

        return stackView
    }()
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "MatchFloatingImgBtn")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 60/2
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        if uiStyle == .mento {
            button.tintColor = .BaseGreen
        } else {
            button.tintColor = .BaseNavy
        }
        let postWriteAction = UIAction(title: "글 쓰기", image: UIImage(systemName: "pencil"), handler: postButtonActionHandler)
        let myPostAction = UIAction(title: "내 글 보기", image: UIImage(systemName: "doc.text.magnifyingglass"), handler: {_ in })
        button.showsMenuAsPrimaryAction = true
        button.menu = UIMenu(title: "",
                                    image: nil,
                                    identifier: nil,
                                    options: .displayInline,
                                    children: [postWriteAction, myPostAction])
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        searchSectionView.parentViewController = self
        setupNavigationController()
        setupAddTarget()
        setupLayout()
        fetchNotificationList()
    }

}

private extension MatchViewController {
    func setupNavigationController() {
        navigationItem.title = "매칭"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupAddTarget() {
        searchSectionView.businessNameFilterButton.addTarget(self, action: #selector(searchFilterButtonTapped), for: .touchUpInside)
        searchSectionView.pjtGoalFilterButton.addTarget(self, action: #selector(searchFilterButtonTapped), for: .touchUpInside)
    }
    
    func postButtonActionHandler(sender: UIAction!) {
        let vc = BusinessEditViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    func setupLayout() {
        [scrollView, floatingButton].forEach {
            view.addSubview($0)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

extension MatchViewController: SelectViewControllerDelegate {
    
    @objc private func searchFilterButtonTapped(sender: UIButton) {
        
        if sender == searchSectionView.businessNameFilterButton {
            let vc = SelectViewController(titleText: "지원사업명", style: uiStyle, sender: sender, elements: businessNameList, previousSelectedElements: selectedBusinessNameElements, delegate: self)
            presentSheetPresentationController(vc: vc)
        } else if sender == searchSectionView.pjtGoalFilterButton {
            let vc = SelectViewController(titleText: "프로젝트 목표", style: uiStyle, sender: sender, elements: pjtGoalList, previousSelectedElements: selectedPjtGoalElements, delegate: self)
            presentSheetPresentationController(vc: vc)
        }
    }
    
    func presentSheetPresentationController(vc: UIViewController) {
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
            sheet.prefersGrabberVisible = true
       }
       present(vc, animated: true)
    }
    
    // 지원사업명, 프로젝트 목표 필터 뷰컨트롤러 화면이 사라질 때 선택한 데이터를 받음
    func didSelectViewControllerDismiss(elements: [String], selectedElements: [Int], sender: UIButton) {
        // 선택한 데이터가 0개 이상일 때만 데이터 저장 및 뷰 수정
        if selectedElements.count > 0 {
            if sender == searchSectionView.businessNameFilterButton {
                // 이 뷰컨트롤러에 선택한 데이터 저장하는 코드
                self.selectedBusinessNameElements = selectedElements
                searchSectionView.businessNameFilterButton.backgroundColor = baseColor
            } else {
                self.selectedPjtGoalElements = selectedElements
                searchSectionView.pjtGoalFilterButton.backgroundColor = baseColor
            }
        } else {
            if sender == searchSectionView.businessNameFilterButton {
                selectedBusinessNameElements = []
                searchSectionView.businessNameFilterButton.backgroundColor = .BaseGray700
            } else {
                selectedPjtGoalElements = []
                searchSectionView.pjtGoalFilterButton.backgroundColor = .BaseGray700
            }
        }
        
    }
    
}

// Network
extension MatchViewController {
    func fetchNotificationList() {
        MatchNetworkService.fetchNotificationList() { response, error in
            if error != nil {
                print("매칭 공고 요청 오류 발생: \(error?.asAFError?.responseCode ?? 0)")
                if let statusCode = error?.asAFError?.responseCode {
                    Alert.showAlert(title: "매칭 공고 요청 오류 발생", message: "\(statusCode)")
                } else {
                    Alert.showAlert(title: "매칭 공고 요청 오류 발생", message: "네트워크 연결을 확인하세요.")
                }
            } else {
                if response?.success == true {
                    guard let notificationDTOS = response?.response?.notificationDTOS else {return}
                    self.searchSectionView.matchNotis = notificationDTOS
                    self.searchSectionView.collectionView.reloadData()
                } else {
                    Alert.showAlert(title: "오류", message: "알 수 없는 오류입니다. 다시 시도해 주세요. code : \(response?.error?.code ?? "0")")
                }
            }
        }
    }
}
