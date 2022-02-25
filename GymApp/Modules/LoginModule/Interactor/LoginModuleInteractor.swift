//
//  LoginModuleInteractor.swift
//  GymApp
//
//  Created by Chris on 2021/5/23.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation


struct Jwt : Codable{
    var id_token: String
}

class LoginModuleInteractor: LoginModuleInteractorProtocol {
    
    var presenter: LoginModulePresenterProtocol?
    
    func handleSignIn(username: String, password: String){
        
        // Sign in and get the id_token.
        UserService.shared.signIn(username: username, password: password){ (res) in
            switch res{
            case .failure(let err):
                
                var message = ""
                
                switch err {
                case .unauthorized:
                    message = "用户名或者密码错误。"
                case .badRequest:
                    message = "无法连接到服务器。"
                default:
                    message = "出现未知错误。"
                }
                
                DispatchQueue.main.async {
                    self.presenter?.showSignInErrorAlert(message: message)
                }

            case .success(let id_token):
                // Save the id_token into UserDeafults.
                UserDefaults.standard.setValue(id_token.id_token, forKey: "id_token")
                UserDefaults.standard.synchronize()
                
                // Get the user profile.
                UserService.shared.getProfile(){ res in
                    switch res{
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.presenter?.showSignInErrorAlert(message: "获取资料出现错误。")
                        }
                    case .success(let user):
                        
                        // Show the full function screen.
                        DispatchQueue.main.async {
                            //
                            self.presenter!.showMainScreen()
                        }
                        
                    }
                }
            }
        }
        
    }
    
    func signUp(user: User) {

        let encoder = JSONEncoder()
        
        var data : Data = Data()
        do {
            data = try encoder.encode(user)
        } catch (let err) {
            print(err)
        }
        
        UserService.shared.signUp(data: data) { res in
            switch(res) {
            case.success(_):
                DispatchQueue.main.async {
                    self.presenter?.showSignUpSuccess()
                }
            case.failure(let err):
                
                var message = ""
                
                switch (err) {
                case .badRequest:
                    message = "服务器出错。"
                case .conflict:
                    message = "该用户名已存在，请更换其他用户名再次尝试。"
                case .unauthorized:
                    break
                case .unknown:
                    message = "服务器出现未知错误。"
                }
                
                DispatchQueue.main.async {
                    self.presenter?.showSignUpFailed(message: message)
                }
                
            }
        }
    }
    
}
