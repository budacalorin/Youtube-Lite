//
//  UploadViewModel.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 26.07.2021.
//

import Foundation

class UploadViewModel: CombineViewModel {
    
    @Published var name: String = ""
    
    @Published var description: String = ""
    
    @Published var url: String = ""
    
    @Published var tags: [String] = []
    
    @Published var newTag: String = ""
    
    @Published var errorMessage: String = ""
    
    private func resetVariables() {
        DispatchQueue.main.async { [weak self] in
            self?.name = ""
            self?.description = ""
            self?.url = ""
            self?.tags = []
        }
    }
    
    func pressedUploadButton() {
        guard !name.isEmpty,
              !description.isEmpty,
              !url.isEmpty,
              User.currentUser.id != nil else {
                  DispatchQueue.main.async { [weak self] in
                    self?.errorMessage = "The data you entered is invalid"
                  }
                  return
              }
        
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = "Posted!"
        }
        
        FirebaseHelper.shared.videoHelper.updateVideo(
            video: Video(
                id: UUID().uuidString,
                name: name,
                description: description,
                url: url,
                userUID: User.currentUser.id!,
                tags: tags,
                stars: StarsData()
            )
        )
        
        resetVariables()
    }
}
