//
//  CatViewController.swift
//  Todo
//
//  Created by 영현 on 1/11/24.
//

import UIKit

class CatViewController: UIViewController {
    
    var whichPetDoYouWantToDisplay: Bool = true
    var imageURL: String? {
        didSet {
            getPetImage()
        }
    }
    @IBOutlet weak var petSelector: UISegmentedControl!
    @IBOutlet weak var petImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petImageView.image = UIImage(named: "CatLoadingImage")
    }
    override func viewWillAppear(_ animated: Bool) {
        getJSONDataFromCatAPI()
    }
    @IBAction func refreshButtonTapped(_ sender: Any) {
        if whichPetDoYouWantToDisplay {
            getJSONDataFromCatAPI()
        } else {
            getJSONDataFromDogAPI()
        }
    }
    @IBAction func selectPetToDisplay(_ sender: Any) {
        switch petSelector.selectedSegmentIndex {
        case 0:
            whichPetDoYouWantToDisplay = true
        case 1:
            whichPetDoYouWantToDisplay = false
        default:
            whichPetDoYouWantToDisplay = true
        }
    }
    
    
    func getJSONDataFromCatAPI() {
        let session = URLSession.shared
        if let catURL = URL(string: "https://api.thecatapi.com/v1/images/search") {
            let task = session.dataTask(with: catURL) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let JSONData = try JSONDecoder().decode([Pet].self, from: data)
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
    
    func getJSONDataFromDogAPI() {
        let session = URLSession.shared
        if let dogURL = URL(string: "https://api.thedogapi.com/v1/images/search") {
            let task = session.dataTask(with: dogURL) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let JSONData = try JSONDecoder().decode([Pet].self, from: data)
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
    
    func getPetImage() {
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
                        self.petImageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
}
