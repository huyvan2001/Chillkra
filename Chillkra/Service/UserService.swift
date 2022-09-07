//
//  UserService.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    
    //MARK: FetchUser
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void ){
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                guard let user = try? snapshot.data(as: User.self) else { return}
                completion(user)

            }
    }
    
    
    
    
    
    
}
