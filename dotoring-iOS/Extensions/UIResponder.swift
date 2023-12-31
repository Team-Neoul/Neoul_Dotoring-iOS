//
//  UIResponder.swift
//  dotoring-iOS
//
//  Created by 우진 on 12/20/23.
//

import Foundation
import UIKit

// 현재 응답받는 UI를 알아내기 위해 사용 (textfield, textview 등)
extension UIResponder {
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static var currentResponder: UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap() {
        Static.responder = self
    }
}
