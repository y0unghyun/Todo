//
//  CatViewController.swift
//  Todo
//
//  Created by 영현 on 1/11/24.
//
// if let-binding과 guard let-binding의 의미를 생각해보며 refactoring 진행해보기

import UIKit

class PetViewController: UIViewController {
    
    var whichPetDoYouWantToDisplay: Bool = true
    var urlForPet: String = "https://api.thecatapi.com/v1/images/search"
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
        getJSONData()
    }
    @IBAction func refreshButtonTapped(_ sender: Any) {
        getJSONData()
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
    
    func getJSONData() {
        let session = URLSession.shared
        if whichPetDoYouWantToDisplay { urlForPet = "https://api.thecatapi.com/v1/images/search" }
        else { urlForPet = "https://api.thedogapi.com/v1/images/search" } // 삼항연산자, url을 열거형으로?
        if let petURL = URL(string: urlForPet) {
            let task = session.dataTask(with: petURL) { (data, response, error) in
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
