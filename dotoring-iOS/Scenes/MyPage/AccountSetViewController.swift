//
//  AccountSetViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

class AccountSetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setNavigationItems()
    }
    
    private func setNavigationItems() {
        navigationItem.title = "계정 설정"
        navigationController?.navigationBar.topItem?.backButtonTitle = "마이페이지"
        navigationController?.navigationBar.tintColor = .label
        
    }

}
