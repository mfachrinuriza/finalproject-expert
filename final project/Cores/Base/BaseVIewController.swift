//
//  BaseVIewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 24/08/22.
//

import UIKit

class BaseVIewController: UIViewController, UIGestureRecognizerDelegate {

    var loading: LoadingView?
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        loading = LoadingView()
        self.view.addSubview(loading!)
        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        loading?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        loading?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loading?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loading?.indicator.startAnimating()
    }
    
    func removeLoading() {
        loading?.indicator.stopAnimating()
        loading?.removeFromSuperview()
    }
    
    func setNavigationBarWithoutTitle() {
        let image = UIImage(named: "ic_arrow_left")!
        let barItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(onDismissController))
        self.navigationItem.leftBarButtonItem = barItem
        
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            self.navigationItem.scrollEdgeAppearance = navigationBarAppearance
            self.navigationItem.standardAppearance = navigationBarAppearance
            self.navigationItem.compactAppearance = navigationBarAppearance
            self.navigationController?.navigationBar.barTintColor = Color.getColor(name: .bg)
        } else {
            self.navigationController?.navigationBar.barTintColor = Color.getColor(name: .bg)
        }
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setNavigationBarWithTitle(title: String) {
        setNavigationBarWithoutTitle()
        
        let label = UILabel(frame: CGRect(x: 8, y: 0, width: self.navigationController!.navigationBar.frame.width, height: self.navigationController!.navigationBar.frame.height))
        label.text = title
        label.textColor = Color.getColor(name: .black70)
        label.font = UIFont(name: FONT.interSemiBold, size: 16)
        label.textAlignment = .left
        self.navigationItem.titleView = label
    }
    
    @objc func onDismissController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationBarWithTitleAndLikeButton(title: String, isFavorite: Bool) {
        setNavigationBarWithTitle(title: title)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 16))
        if isFavorite {
            button.setImage(UIImage(named: "ic_love_black"), for: .normal)
        } else {
            button.setImage(UIImage(named: "ic_love_gray"), for: .normal)
        }
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(onRequestFavorite), for: .touchUpInside)
        let barItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    @objc func onRequestFavorite() {
        
    }
    
    func setNavigationBarWithTitleAndSaveButton(title: String) {
        setNavigationBarWithTitle(title: title)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: self.navigationController!.navigationBar.frame.height))
        button.setTitle("Save", for: .normal)
        button.setTitleColor(Color.getColor(name: .primary), for: .normal)
        button.titleLabel?.font = UIFont(name: FONT.interMedium, size: 14)
        button.addTarget(self, action: #selector(onRequestEdit), for: .touchUpInside)
        let barItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    @objc func onRequestEdit() {
        
    }
}
