//
//  FullScreenPlayer.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 24.07.2021.
//

import Foundation
import SwiftUI
import AVKit

struct AVPlayerView: UIViewControllerRepresentable {

    let player : AVPlayer
    
    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) { }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerController = AVPlayerViewController()
        playerController.modalPresentationStyle = .fullScreen
        playerController.player = player
        return playerController
    }
}
