//
//  CoinImageDataService.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 30/07/2024.
//

import SwiftUI
import Combine

class CoinImageDataService {
    
    @Published var image: UIImage? = nil
    
    let coin: CoinModel
    private var imageSubscribtion: AnyCancellable?
    let fm = LocalFileManager.shared
    let folderName = "coin_images"
    let ImageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.ImageName = coin.id
        getImage()
    }
    
    private func getImage() {
        if let savedImage = fm.getImage(imageName: ImageName, folderNmae: folderName) {
            self.image = savedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
               return UIImage(data: data)
            })
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self] returnedImage in
                guard
                    let self = self,
                    let downlodedImage = returnedImage
                else { return }
                
                self.image = downlodedImage
                self.imageSubscribtion?.cancel()
                self.fm.saveImage(image: downlodedImage, folderName: folderName, imageName: ImageName)
            })
    }
}
