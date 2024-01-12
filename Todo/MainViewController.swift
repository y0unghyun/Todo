//
//  MainViewController.swift
//  Todo
//
//  Created by 영현 on 1/10/24.
//

import UIKit



class MainViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let session = URLSession.shared

        if let mainImage = URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg") {
            let task = session.dataTask(with: mainImage) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    DispatchQueue.main.async {
                        self.mainImageView.image = UIImage(data: data)
                    }
                    print("Received Data: \(data)")
                }
            }
            
            task.resume()
        }
    }

}
