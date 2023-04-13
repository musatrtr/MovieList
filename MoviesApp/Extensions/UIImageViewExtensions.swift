//
//  UIImageViewExtensions.swift
//  MoviesApp
//
//  Created by Musa Kökcen on 12.04.23.
//

import UIKit

extension UIImageView {
    static let baseImageUrl: String = "https://image.tmdb.org/t/p/w500"
    
    @discardableResult
    func loadImage(from path: String,
                   placeholder: UIImage? = nil) ->
    URLSessionDataTask? {
        self.image = nil
        let key = NSString(string: path)
        if let cachedImage = CacheManager.shared.getFrom(key: key) {
            self.image = cachedImage
            return nil
        }

        let urlString = UIImageView.baseImageUrl + path
        guard let url = URL(string: urlString) else {
            return nil
        }
        if let placeholder = placeholder {
            self.image = placeholder
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data,
                   let downloadedImage = UIImage(data: data) {
                    CacheManager.shared.add(key: key, value: downloadedImage)
                    self.image = downloadedImage
                }
            }
        }
        task.resume()
        return task
    }
}
