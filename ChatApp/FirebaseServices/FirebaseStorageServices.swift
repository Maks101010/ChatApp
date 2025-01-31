//
//  FirebaseStorageServices.swift
//  ChatApp
//
//  Created by differenz48 on 31/01/25.
//
import FirebaseStorage
import Foundation
import SwiftUI
 
 
class FireBaseStorageService {
    static let shared : FireBaseStorageService = FireBaseStorageService()
    private init () {}
    let storage : Storage = Storage.storage()
}
 
extension FireBaseStorageService {
    func uploadImage(image: UIImage, path: String, completion: @escaping (Result<String, Error>) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Error: Could not convert UIImage to Data")
            completion(.failure(NSError(domain: "ImageConversionError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not convert UIImage to Data"])))
            return
        }
 
        let storageRef = storage.reference().child(path)
 
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                Indicator.hide()
                Alert.show(message: "\(error.localizedDescription)")
                print("Error uploading image: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
 
            // Get download URL
            storageRef.downloadURL { url, error in
                Indicator.hide()
                if let error = error {
                    Alert.show(message: "\(error.localizedDescription)")
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(.failure(error))
                } else if let url = url {
                    print("Image uploaded successfully: \(url.absoluteString)")
                    completion(.success(url.absoluteString)) // Return download URL
                }
            }
        }
    }
}
