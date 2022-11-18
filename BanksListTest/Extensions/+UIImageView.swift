//
//  +UIImageView.swift
//  BanksListTest
//
//  Created by Victor De la Torre on 17/11/22.
//

import UIKit
import SVProgressHUD

extension UIImageView {
    private var activityIndicator: UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = UIColor.black
            self.addSubview(activityIndicator)

            activityIndicator.translatesAutoresizingMaskIntoConstraints = false

            let centerX = NSLayoutConstraint(item: self,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: activityIndicator,
                                             attribute: .centerX,
                                             multiplier: 1,
                                             constant: 0)
            let centerY = NSLayoutConstraint(item: self,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: activityIndicator,
                                             attribute: .centerY,
                                             multiplier: 1,
                                             constant: 0)
            self.addConstraints([centerX, centerY])
            return activityIndicator
        }
    
    func imageFromUrl(urlString: String, placeHolderImage: UIImage) {
        let activityIndicator = self.activityIndicator
        
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error)in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                
                if error != nil {
                    return
                } else {
                    if self.image == nil {
                        self.image = placeHolderImage
                    }
                }
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
    
}
