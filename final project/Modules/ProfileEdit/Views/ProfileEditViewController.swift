//
//  ProfileEditViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 10/10/22.
//

import UIKit

class ProfileEditViewController: BaseVIewController {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    let profileEditViewModel: ProfileEditViewModel
    
    var profileData: Profile?
    
    init(profileEditViewModel: ProfileEditViewModel) {
        self.profileEditViewModel = profileEditViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        loadData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.setNavigationBarWithTitleAndSaveButton(title: "Edit Profile")
    }
    
    func setupUI() {
        imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        labelEmail.layer.cornerRadius = 12
        labelEmail.layer.masksToBounds = true
    }
    
    func setupBinding() {
        profileEditViewModel.success.subscribe(onNext: { result in
            self.presentProfile()
        }).disposed(by: profileEditViewModel.disposeBag)
    }
     
    
    func loadData() {
        txtName.text = profileData?.name
    }
    
    func presentProfile() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func onRequestEdit() {
        profileEditViewModel.requestChangeData(name: txtName.text!)
    }
}
