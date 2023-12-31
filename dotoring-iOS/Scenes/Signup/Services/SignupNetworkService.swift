//
//  SignupNetworkService.swift
//  dotoring-iOS
//
//  Created by 우진 on 12/21/23.
//

import Foundation
import Alamofire

class SignupNetworkService {
    
    class func fetchFieldList(_ completion: @escaping (FieldsAPIResponse?, Error?) -> Void) {
        
        let urlToCall = SignupRouter.fields
        
        BaseNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...300)
            .responseDecodable(of: FieldsAPIResponse.self) { response in
                switch response.result {
                case .success(let successData):
                    print("SignupNetworkService - fetchFieldList() called")
                    
                    return completion(successData, nil)
                    
                case .failure(let error):
                    print("SignupNetworkService - fetchFieldList() failed")
                    
                    return completion(nil, error)
                }
            }
    }
    
    class func fetchMajorList(_ completion: @escaping (MajorsAPIResponse?, Error?) -> Void) {
        
        let urlToCall = SignupRouter.majors
        
        BaseNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...300)
            .responseDecodable(of: MajorsAPIResponse.self) { response in
                switch response.result {
                case .success(let successData):
                    print("SignupNetworkService - fetchMajorList() called")
                    
                    return completion(successData, nil)
                    
                case .failure(let error):
                    print("SignupNetworkService - fetchMajorList() failed")
                    
                    return completion(nil, error)
                }
            }
    }
    
    class func validNickname (uiStyle: UIStyle, nickname: String, _ completion: @escaping (ValidAPIResponse?, Error?) -> Void) {
        
        var urlToCall:  SignupRouter{
            switch uiStyle {
            case .mento:
                return SignupRouter.validMentoNickname(nickname: nickname)
            case .mentee:
                return SignupRouter.validMentiNickname(nickname: nickname)
            }
        }
        
        BaseNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...500)
            .responseDecodable(of: ValidAPIResponse.self) { response in
                switch response.result {
                case .success(let successData):
                    print("SignupNetworkService - validNickname() called")
                    
                    return completion(successData, nil)
                case .failure(let error):
                    print("SignupNetworkService - validNickname() failed")
                    
                    return completion(nil, error)
                }
            }
    }
    
    class func validId (loginId: String, _ completion: @escaping (ValidAPIResponse?, Error?) -> Void) {
        
        let urlToCall = SignupRouter.validId(loginId: loginId)
        
        BaseNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...500)
            .responseDecodable(of: ValidAPIResponse.self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let successData):
                    print("SignupNetworkService - validId() called")
                    
                    return completion(successData, nil)
                case .failure(let error):
                    print("SignupNetworkService - validId() failed")
                    
                    return completion(nil, error)
                }
            }
    }
    
    class func validEmail (email: String, _ completion: @escaping (ValidAPIResponse?, Error?) -> Void) {
        
        let urlToCall = SignupRouter.validEmail(email: email)
        
        BaseNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...500)
            .responseDecodable(of: ValidAPIResponse.self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let successData):
                    print("SignupNetworkService - validEmail() called")
                    
                    return completion(successData, nil)
                case .failure(let error):
                    print("SignupNetworkService - validEmail() failed")
                    
                    return completion(nil, error)
                }
            }
    }
    
    class func validCode (email: String, code: String, _ completion: @escaping (ValidAPIResponse?, Error?) -> Void) {
        
        let urlToCall = SignupRouter.validCode(email: email, code: code)
        
        BaseNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...500)
            .responseDecodable(of: ValidAPIResponse.self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let successData):
                    print("SignupNetworkService - validCode() called")
                    
                    return completion(successData, nil)
                case .failure(let error):
                    print("SignupNetworkService - validCode() failed")
                    
                    return completion(nil, error)
                }
            }
    }
    
    class func signup(uiStyle: UIStyle, certifications: URL, school: String, grade: String, majors: String, fields: String, nickname: String, introduction: String, loginId: String, password: String, email: String, _ completion: @escaping (ValidAPIResponse?, Error?) -> Void) {
        
        var urlToCall:  SignupRouter{
            switch uiStyle {
            case .mento:
                return SignupRouter.signupMento(certifications: certifications, school: school, grade: grade, majors: majors, fields: fields, nickname: nickname, introduction: introduction, loginId: loginId, password: password, email: email)
            case .mentee:
                return SignupRouter.signupMenti(certifications: certifications, school: school, grade: grade, majors: majors, fields: fields, nickname: nickname, introduction: introduction, loginId: loginId, password: password, email: email)
            }
        }
        
        MultipartNetworkManager
            .shared
            .session
            .upload(multipartFormData: urlToCall.multipartFormData, with: urlToCall)
            .validate(statusCode: 200...300)
            .responseDecodable(of: ValidAPIResponse.self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let successData):
                    print("SignupNetworkService - signup() called")
                    
                    return completion(successData, nil)
                    
                case .failure(let error):
                    print("SignupNetworkService - signup() failed")
                    
                    return completion(nil, error)
                }
            }
    }
}
