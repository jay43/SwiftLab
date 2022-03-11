//
//  InstagramShareView.swift
//  SwiftLab
//
//  Created by PC on 11/03/22.
//

import SwiftUI
import Foundation
import LoggerAPI

struct InstagramShareView: View {
    
    var imageToShare: some View {
        // An image defined in your app's asset catalogue.
        return Image(systemName: "seal.fill")
            .foregroundColor(.yellow)
            .frame(width: 60, height: 60)
    }
    
    var body: some View {
        VStack {
            
            // Display the image that will be shared to Instagram.
            imageToShare
            
            if InstagramSharingUtils.canOpenInstagramStories {
                Button(action: { InstagramSharingUtils.shareToInstagramStories(imageToShare.snapshot()) }) {
                    Text("Share to Instagram Stories")
                }
            } else {
                Text("Instagram is not available.")
            }
        }
    }
}

struct InstagramShareView_Previews: PreviewProvider {
    static var previews: some View {
        InstagramShareView()
    }
}


struct InstagramSharingUtils {
    
    // Returns a URL if Instagram Stories can be opened, otherwise returns nil.
    private static var instagramStoriesUrl: URL? {
        if let url = URL(string: "instagram-stories://share?source_application=uk.sdonnelly.personal-best-0") {
            if UIApplication.shared.canOpenURL(url) {
                return url
            }
            return nil
        }
        return nil
    }
    
    // Convenience wrapper to return a boolean for `instagramStoriesUrl`
    static var canOpenInstagramStories: Bool {
        return instagramStoriesUrl != nil
    }
    
    // If Instagram Stories is available, writes the image to the pasteboard and
    // then opens Instagram.
    static func shareToInstagramStories(_ image: UIImage) {
        
        // Check that Instagram Stories is available.
        guard let instagramStoriesUrl = instagramStoriesUrl else {
            return
        }
        
        // Convert the image to data that can be written to the pasteboard.
        let imageDataOrNil = UIImage.pngData(image)
        guard let imageData = imageDataOrNil() else {
            Log.error("🙈 Image data not available.")
            return
        }
        let pasteboardItem = ["com.instagram.sharedSticker.backgroundImage": imageData]
        let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)]
        
        // Add the image to the pasteboard. Instagram will read the image from the pasteboard when it's opened.
        UIPasteboard.general.setItems([pasteboardItem], options: pasteboardOptions)
        
        // Open Instagram.
        UIApplication.shared.open(instagramStoriesUrl, options: [:], completionHandler: nil)
    }
}


extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
