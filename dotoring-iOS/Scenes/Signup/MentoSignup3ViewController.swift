//
//  MentoSignup3ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/22.
//

import UIKit

class MentoSignup3ViewController: UIViewController {
    
    var signup3View: Signup3View!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
    }
    
    override func loadView() {
        super.loadView()
        
        signup3View = Signup3View(frame: self.view.frame)
        
        signup3View.nextButtonActionHandler = { [weak self] in
            self?.nextButtonTapped()
        }
        
        self.view = signup3View
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
    
    func nextButtonTapped() {
        let vc = MentoSignup4ViewController()
        navigationController?.pushViewController(vc, animated: false)
    }

}
