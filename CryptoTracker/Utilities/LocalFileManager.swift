//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 30/07/2024.
//

import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage?, folderName: String,imageName: String) {
        
        createFoderIfNeaded(folderName: folderName)
        
        guard
            let data = image?.pngData(),
            let url = getImagePath(imageName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image \(imageName). \(error.localizedDescription)")
        }
    }
    
    func getImage(imageName: String, folderNmae: String) -> UIImage? {
        guard
            let imageURL = getImagePath(imageName: imageName, folderName: folderNmae)?.path(),
            FileManager.default.fileExists(atPath: imageURL)
        else { return nil }
        
        return UIImage(contentsOfFile: imageURL)
        
    }
    
    private func createFoderIfNeaded(folderName: String) {
        guard let url = getFolderPath(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                
            } catch let error {
                print("Error creating folder \(folderName), \(error.localizedDescription)")
            }
        }
        
    }
    
    private func getImagePath(imageName: String, folderName: String) -> URL? {
        guard
            let folderURL = getFolderPath(folderName: folderName) else {
            return nil
        }
        return folderURL.appending(path: imageName + ".png")
        
    }
    
    private func getFolderPath(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appending(path: folderName)
    }
}
