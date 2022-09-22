//
//  MP3Picker.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 20/09/2022.
//

import Foundation
import SwiftUI
import MobileCoreServices
import FirebaseStorage
import UniformTypeIdentifiers
struct AudioPicker: UIViewControllerRepresentable{
    @Binding var done: Bool
    @Binding var urlSong: String
    func makeCoordinator() -> Coordinator {
        return AudioPicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AudioPicker>) -> UIDocumentPickerViewController {
        let types = UTType.types(tag: "mp3",
                                tagClass: UTTagClass.filenameExtension,
                                conformingTo: nil)
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: types)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
        
    }
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context:
                                UIViewControllerRepresentableContext<AudioPicker>) {
        //
    }
    class Coordinator: NSObject,UIDocumentPickerDelegate,UINavigationControllerDelegate{

        var parent: AudioPicker
        init(parent1: AudioPicker) {
            parent = parent1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let filename = urls.first?.lastPathComponent else {return}
            let ref = Storage.storage().reference(withPath: "/Musics/\(filename)")
            ref.putFile(from: urls.first!,metadata: nil) { _, error in
                if let error = error {
                    print("Can't upload Audio with: \(error)")
                }
                ref.downloadURL { urlSong, error in
                    guard let url = urlSong?.absoluteString else {
                        print("Error")
                        return
                    }
                    self.parent.urlSong = url
                }
                    self.parent.done = true
            }
        }
    }
}

