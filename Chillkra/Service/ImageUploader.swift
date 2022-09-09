//
//  ImageUploader.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 08/09/2022.
//

import SwiftUI
import Firebase
import FirebaseStorage
struct ImageUploader{
    static func uploadImage(image: UIImage,completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/Avatas/\(fileName)")
        
        ref.putData(imageData,metadata: nil) { _,error in
            if let error = error {
                print("DEBUG: Can't upload image with error: \(error.localizedDescription)")
            }
            
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else { return }
                
                completion(imageUrl)
                
            }
            
        }
        
        
    }
}
