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
    
    private let service = UserService()
    
    init(){
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
        SongService().fetchJSONSong()
        SongService().fetchJSONType()
        SongService().fetchJSONEtype()
    }
    
    
    enum LoginError {
        case Unknown
        case UsernameNotExist
        case WrongPass
        
        var message: String {
            switch self {
            case .Unknown:
                return "Fail to Login. Please check email and password !!!"
            case .UsernameNotExist:
                return ""
            case .WrongPass:
                return ""
            }
        }
    }
    enum SignUpError{
        case ExistEmail
        case EmptyField
        
        var message: String {
            switch self {
            case .ExistEmail:
                return "Fail to Sign Up. Email exists!!!"
            case .EmptyField:
                return "Please fill Information "
            
            }
        }
    }
    
    //MARK: LOGIN
    func login(withEmail email: String,
               password: String,
               completion:@escaping (LoginError?)->Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password) { result, error in
            if let error = error {
                print("Fail to signIn with error \(error)")
                completion(.Unknown)
            }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            completion(nil)
        }
    }
    
    
    
    //MARK: SIGNUP
    func signup(withEmail email: String,
                name: String,
                password: String,
                completion:@escaping(SignUpError?)->Void){
        
        Auth.auth().createUser(withEmail: email,
                               password: password) { result, error in
            if let error = error {
                print("Fail to signup with error \(error)")
                completion(.ExistEmail)
            }
            guard let user = result?.user else { return }
            let data = ["name":name,
                        "email":email]
            Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .setData(data)
            completion(nil)
        }
    }
    
    
    
    //MARK: CHANGE PASSWORD
    func changePassword(email:String,
                        currentPassword: String,
                        newPassword: String,
                        completion:@escaping(Bool) -> Void){
        
        let credential = EmailAuthProvider.credential(withEmail:email,
                                                      password: currentPassword)
        Auth.auth().currentUser?.reauthenticate(with: credential,
                                                completion: { _, error in
                completion(false)
        })
        
        Auth.auth().currentUser?.updatePassword(to: newPassword)
        completion(true)
    }
    
    
    
    
    
    
    //MARK: Edit Profilename
    func editName(_ name: String){
        guard let uid = userSession?.uid else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .updateData(["name":name])
        { _ in
            self.fetchUser()
        }
    }
    
    
    //MARK: Edit ProfileImage
    func editImage(_ image: UIImage){
        guard let uid = userSession?.uid else { return }
        
            ImageUploader.uploadImage(image: image) { urlImageProfile in
                Firestore.firestore().collection("users")
                    .document(uid)
                    .updateData(["urlImage": urlImageProfile])
                { _ in
                    self.fetchUser()
                }
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
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    
    //MARK: RESET PASSWORD
    func resetPassword(email: String,
                       completion:@escaping(Bool)->Void){
        Auth.auth().sendPasswordReset(withEmail: email) { _ in
            print("Email isn't exist")
        }
        completion(true)
    }
    
    
}
