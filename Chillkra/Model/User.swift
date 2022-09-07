//
//  User.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

class User: Identifiable,Decodable{
    @DocumentID var id: String?
    let name: String
    let email: String
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == id
    }
    
}
