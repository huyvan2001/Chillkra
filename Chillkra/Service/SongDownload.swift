//
//  SongDownload.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 13/09/2022.
//

import Foundation
class SongDownload: NSObject,ObservableObject{
    var downloadTask: URLSessionDownloadTask?
    var downloadURL : URL?
    let fileManager = FileManager.default
    @Published var finishDownloading: Float = 0
    @Published var locationUrl: URL?
    @Published var downloadAmount: Float = 0
    
    lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    
    func fetchSongUrl(_ url: URL,completion:@escaping(Bool)-> Void){
        downloadURL = url
        guard let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
              let lastpathComponent = downloadURL?.lastPathComponent
        else {
            fatalError()
        }
        
        let destinationUrl = documentPath.appendingPathComponent(lastpathComponent)
        if fileManager.fileExists(atPath: destinationUrl.path){
            DispatchQueue.main.async {
                self.locationUrl = destinationUrl
                print(self.locationUrl!)
            }
            completion(true)
            return
        }
        downloadTask = urlSession.downloadTask(with: url)
        downloadTask?.resume()
        completion(false)
    }
    
}

extension SongDownload: URLSessionDownloadDelegate{
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            self.downloadAmount = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            print(self.downloadAmount)
            
            
        }
    }
    
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
              let lastpathComponent = downloadURL?.lastPathComponent
        else {
            fatalError()
        }
        let destinationUrl = documentPath.appendingPathComponent(lastpathComponent)
        do{
            try fileManager.copyItem(at: location, to: destinationUrl)
            while fileManager.fileExists(atPath: destinationUrl.path){
                DispatchQueue.main.async {
                    self.locationUrl = destinationUrl
                }
            }
        }
        catch{
            print(error)
        }
        
    }
    
    
}
