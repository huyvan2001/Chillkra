//
//  AuthViewModel.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import Foundation
import Firebase
import FirebaseAuth
import Combine
import SwiftUI


class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthecationUser : Bool = false
    @Published var currentUser: User?
    var tempUserSession: FirebaseAuth.User?
    private let service = UserService()
    init(){
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    
    //MARK: LOGIN
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Fail to signIn with error \(error)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
        }
    }
    
    
    //MARK: SIGNUP
    func signup(withEmail email: String, name: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Fail to signup with error \(error)")
                return
            }
            guard let user = result?.user else { return }
            let data = ["name":name,
                        "email":email,]
            self.tempUserSession = user
            Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .setData(data)
        }
        
        
    //MARK: CHANGE PASSWORD
    func changePassword(password: String){
        Auth.auth().currentUser?.updatePassword(to: password)
    }
        
    }
    
    
    //MARK: FETCH USER
    func fetchUser(){
        guard let uid = userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
            print(user)
        }
    }
    
    //MARK: LOG OUT
    func logOut(){
        self.userSession = nil
        
        try? Auth.auth().signOut()
    }
    
    
    
}
