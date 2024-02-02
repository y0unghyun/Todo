//
//  ProfileViewController.swift
//  Todo
//
//  Created by 영현 on 2/2/24.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    let newUser = User(id: UUID(), name: "Tobi", age: 29)
    
    private var dummy = getSampleImages()
    
    private let gridFlowLayout: GridCollectionViewFlowLayout = {
        let layout = GridCollectionViewFlowLayout()
        layout.cellSpacing = 2
        layout.numberOfColumns = 3
        return layout
    }()
    
    // MARK: UI components
    let userInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "NAEBAECAMP"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = NSTextAlignment(.center)
        return label
    }()
    
    let menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Menu"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let userProfilePicture: UIImageView = {
        let pic = UIImageView()
        pic.image = UIImage(named: "ProfilePicture")
        pic.frame = CGRect(x: 0, y: 0, width: 88, height: 88)
        return pic
    }()
    
    let userPostNum: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    let userFollowerNum: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    let userFollowingNum: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.text = "post"
        return label
    }()
    
    let followerLabel: UILabel = {
        let label = UILabel()
        label.text = "follower"
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "following"
        return label
    }()
    
    let postStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    let followerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    let followingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    let userFollowStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    let userNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "김영현"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    let userBioLabel: UILabel = {
        let label = UILabel()
        label.text = "그냥 바보 입니다. 👀"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    let userLinkLabel: UILabel = {
        let label = UILabel()
        label.text = "velog.io/@y0unghyun"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    let userInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    let followButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    
    let MessageButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("Message", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setImage(UIImage(named: "More"), for: .normal)
        button.frame.size = CGSize(width: 30, height: 30)
        return button
    }()
    
    let middleBarStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setImage(UIImage(named: "Grid"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    let unknownButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setImage(UIImage(named: "Blank"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    let unknown2Button: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setImage(UIImage(named: "Blank"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    lazy var navStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Profile"), for: .normal)
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(moveToProfileDetailVC), for: .touchUpInside)
        return button
    }()
    
    let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private lazy var customCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.gridFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUser()
        addViews()
        setConstraint()
        
        self.customCollectionView.dataSource = self
        self.customCollectionView.delegate = self
    }

    // MARK: UI components constraints
    private func setConstraint() {
        userInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        userProfilePicture.translatesAutoresizingMaskIntoConstraints = false
        userPostNum.translatesAutoresizingMaskIntoConstraints = false
        postStack.translatesAutoresizingMaskIntoConstraints = false
        followerStack.translatesAutoresizingMaskIntoConstraints = false
        followingStack.translatesAutoresizingMaskIntoConstraints = false
        userFollowStack.translatesAutoresizingMaskIntoConstraints = false
        userInfoStack.translatesAutoresizingMaskIntoConstraints = false
        middleBarStack.translatesAutoresizingMaskIntoConstraints = false
        navStack.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userInfoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            userInfoLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            menuButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            menuButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -14),
            
            userProfilePicture.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),
            userProfilePicture.topAnchor.constraint(equalTo: self.userInfoLabel.bottomAnchor, constant: 14),
            
            userFollowStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -28),
            userFollowStack.leadingAnchor.constraint(equalTo: self.userProfilePicture.trailingAnchor),
            userFollowStack.centerYAnchor.constraint(equalTo: self.userProfilePicture.centerYAnchor),
            
            userInfoStack.topAnchor.constraint(equalTo: self.userProfilePicture.bottomAnchor, constant: 14),
            userInfoStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            
            moreButton.topAnchor.constraint(equalTo: self.userInfoStack.bottomAnchor, constant: 14),
            moreButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            moreButton.centerYAnchor.constraint(equalTo: self.middleBarStack.centerYAnchor),
            
            middleBarStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            middleBarStack.topAnchor.constraint(equalTo: self.userInfoStack.bottomAnchor, constant: 14),
            middleBarStack.trailingAnchor.constraint(equalTo: self.moreButton.leadingAnchor, constant: 8),
            
            navStack.topAnchor.constraint(equalTo: self.middleBarStack.bottomAnchor, constant: 14),
            navStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            navStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            navStack.heightAnchor.constraint(equalToConstant: 40),
            
            customCollectionView.topAnchor.constraint(equalTo: self.navStack.bottomAnchor, constant: 10),
            customCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            customCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: self.bottomStack.topAnchor, constant: -14),
            
            bottomStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bottomStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            bottomStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: add things into view
    private func addViews() {
        [userPostNum, postLabel].map ({
            self.postStack.addArrangedSubview($0)
        })
        [userFollowerNum, followerLabel].map ({
            self.followerStack.addArrangedSubview($0)
        })
        [userFollowingNum, followingLabel].map ({
            self.followingStack.addArrangedSubview($0)
        })
        [postStack, followerStack, followingStack].map {
            self.userFollowStack.addArrangedSubview($0)
        }
        [userNicknameLabel, userBioLabel, userLinkLabel].map {
            self.userInfoStack.addArrangedSubview($0)
        }
        [followButton, MessageButton].map {
            self.middleBarStack.addArrangedSubview($0)
        }
        [gridButton, unknownButton, unknown2Button].map {
            self.navStack.addArrangedSubview($0)
        }
        [profileButton].map {
            self.bottomStack.addArrangedSubview($0)
        }
        view.addSubview(userInfoLabel)
        view.addSubview(menuButton)
        view.addSubview(userProfilePicture)
        view.addSubview(userFollowStack)
        view.addSubview(userInfoStack)
        view.addSubview(middleBarStack)
        view.addSubview(navStack)
        view.addSubview(moreButton)
        view.addSubview(customCollectionView)
        view.addSubview(bottomStack)
    }
    
    // MARK: Other Methods
    @objc func moveToProfileDetailVC() {
        present(ProfileDetailViewController(), animated: true)
    }
    
    func setUser() {
        var persistentContainer: NSPersistentContainer? {
            (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        }
        
        guard let context = persistentContainer?.viewContext else { return }
        let entity = NSEntityDescription.entity(forEntityName: "UserData", in: context)
        
        if let entity = entity {
            let user = NSManagedObject(entity: entity, insertInto: context)
            user.setValue(newUser.id, forKey: "id")
            user.setValue(newUser.name, forKey: "name")
            user.setValue(newUser.age, forKey: "age")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: CollectionView Extension
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.prepare(image: self.dummy[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? GridCollectionViewFlowLayout, flowLayout.numberOfColumns > 0 else { fatalError() }
        
        let widthOfCells = collectionView.bounds.width

        let widthOfSpacing = CGFloat(flowLayout.numberOfColumns - 1) * flowLayout.cellSpacing

        let width = Int((widthOfCells - widthOfSpacing) / CGFloat(flowLayout.numberOfColumns))

        return CGSize(width: width, height: width * Int(flowLayout.ratioHeightToWidth))
    }
}

//MARK: ADD CANVAS FUNCTION
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ProfileViewController {
        return ProfileViewController()
    }
    
    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
    }
    
    typealias UIViewControllerType = ProfileViewController
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}

//MARK: ADD BORDER LINE FUNCTION
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat, height: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
    
    func addTopBorder(color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.frame = CGRect.init(x: 0, y: 0, width: self.borderWidth, height: thickness)
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }
}


struct Previews_ViewController_LibraryContent: LibraryContentProvider {
    var views: [LibraryItem] {
        LibraryItem(/*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/)
    }
}


func getSampleImages() -> [UIImage?] {
    (1...20).map { _ in return UIImage(named: "CatLoadingImage")}
}
