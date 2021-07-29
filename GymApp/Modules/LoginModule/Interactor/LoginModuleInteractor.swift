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
    
    func handleSignIn(){
        
        // Sign in and get the id_token.
        UserService.shared.signIn(username: "user1", password: "password1"){ (res) in
            switch res{
            case .failure(let err):
                print("error")
                DispatchQueue.main.async {
                    self.presenter?.showNetworkErrorAlert()
                }
            case .success(let id_token):
                // Save the id_token into UserDeafults.
                UserDefaults.standard.setValue(id_token.id_token, forKey: "id_token")
                UserDefaults.standard.synchronize()
                
                // Get the user profile.
                UserService.shared.getProfile(){ res in
                    switch res{
                    case .failure(let err):
                        print("error")
                    case .success(let user):
                        print(user)
                        
                        // Send the user profile to presenter and show.
                        
                        
                        
                        // Show the full function screen.
                        DispatchQueue.main.async {
                            //
                            self.presenter!.showMainScreen()
                        }
                        
                    }
                }
                
                
                
            }
        }
        
        
        
        
        
        // Present view controller.
        

        
        
        
    }
    
}
