//
//  ProfileViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 24/08/22.
//

import UIKit

class ProfileViewController: BaseVIewController {

    @IBOutlet weak var imgProfile: UIView!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    
    var profileData: Profile?
    
    let profileViewModel: ProfileViewModel
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        loadData()
    }
    
    func loadData() {
        profileViewModel.requestProfileData()
    }
    
    func setupUI() {
        imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        labelEmail.layer.cornerRadius = 12
        labelEmail.layer.masksToBounds = true
    }
    
    func setupBinding() {
        profileViewModel.loading.subscribe(onNext: { loading in
            if loading {
                self.showLoading()
            } else {
                self.removeLoading()
            }
        }).disposed(by: profileViewModel.disposeBag)
        
        profileViewModel.profile.subscribe(onNext: { [self] result in
            profileData = result
            labelEmail.text = result.email
            if let getName = UserDefaults.standard.value(forKey: "SAVED_NAME") as? String {
                labelName.text = getName
                profileData?.name = getName
            } else {
                labelName.text = result.name
                profileData?.name = result.name
            }
            lblOrigin.text = result.origin
        }).disposed(by: profileViewModel.disposeBag)
    }
    
    @IBAction func btnEditTapped(_ sender: Any) {
        let profileEditViewController = ModuleBuilder.getView(module: .profileEdit) as! ProfileEditViewController
        profileEditViewController.profileData = profileData
        self.navigationController?.pushViewController(profileEditViewController, animated: true)
    }
}
