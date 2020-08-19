//
//  LoginVC.swift
//  Undefined
//
//  Created by 오준현 on 2020/08/04.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit
import AuthenticationServices

import SnapKit
import Then

class LoginVC: UIViewController {

    let appleLoginButton = ASAuthorizationAppleIDButton(type: .continue, style: .black)
    
    var apiURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(appleLoginButton)
        
        constraint()
        
        apiURL = url()
        print(apiURL)
    }
    
    private func url() -> String? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                return dict["API_URL"] as? String
            }
        }
        return nil
    }
    
    
    func constraint(){
        appleLoginButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    func setupEvents() {
        appleLoginButton.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
    }


    @objc fileprivate func appleLogin() {
            
        let appleIdRequest = ASAuthorizationAppleIDProvider().createRequest()
        appleIdRequest.requestedScopes = [.email, .fullName]

        let controller = ASAuthorizationController(authorizationRequests: [appleIdRequest])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

}

// MARK: - 애플 로그인

extension LoginVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userEmail = credential.email ?? ""
            let familyName = credential.fullName?.familyName ?? ""
            let givenName = credential.fullName?.givenName ?? ""

            let userIdentifier = credential.user

            print(userEmail)
            print(familyName)
            print(givenName)
            print(userIdentifier)
            
        }

    }
    
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
