//
//  CatViewController.swift
//  Todo
//
//  Created by 영현 on 1/11/24.
//

import UIKit

class CatViewController: UIViewController {
    
    var imageURL: String? {
        didSet {
            getCatImage()
        }
    }
    @IBOutlet weak var catImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catImageView.image = UIImage(named: "CatLoadingImage")
    }
    override func viewWillAppear(_ animated: Bool) {
        getJSONData()
    }
    @IBAction func refreshButtonTapped(_ sender: Any) {
        getJSONData()
    }
    
    func getJSONData() {
        let session = URLSession.shared
        if let catURL = URL(string: "https://api.thecatapi.com/v1/images/search") {
            let task = session.dataTask(with: catURL) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let JSONData = try JSONDecoder().decode([Cat].self, from: data)
                        print("Received: ", JSONData)
                        self.imageURL = JSONData.first?.url
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    func getCatImage() {
        let session = URLSession.shared
        guard let url = self.imageURL else { 
            print("Error: Empty imageURL")
            return
        }
        if let imageURL = URL(string: url) {
            let task = session.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    DispatchQueue.main.async {
                        self.catImageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
}
