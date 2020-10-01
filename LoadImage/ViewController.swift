//
//  ViewController.swift
//  LoadImage
//
//  Created by Rodolphe DUPUY on 09/09/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var athens = "https://cdn.pixabay.com/photo/2016/12/08/13/42/athens-1891719_1280.jpg"
    var xanthos = "http://bronze-age-towns.com/files/2020/09/entree-du-theatre-lycien-de-xanthos-300x166.jpg"
    var rodData = "https://www.roddata.net/web_images/LogoRDC_Nad.png"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivity(true)
    }
    
    func setupActivity(_ bool: Bool) {
        activityIndicator.isHidden = !bool
        bool ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    
    @IBAction func loadImage(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            requestImageFrom(athens)
        case 1:
            requestImageFrom(xanthos)
        default:
            requestImageFrom(rodData)
        }
    }
    
    func requestImageFrom(_ urlString: String) {
        if !activityIndicator.isAnimating {
            setupActivity(true)
        }
        if let url = URL(string: urlString) {
            myImageView.image = nil
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    self.setupActivity(false)
                    if let d = data {
                        let image = UIImage(data: d)
                        self.myImageView.image = image
                    }
                    if let r = response {
                        print("Response: \(r)")
                    }
                    if let e = error {
                        print("Erreur: \(e.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
    
}
