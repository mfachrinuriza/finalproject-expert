//
//  FavoriteViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import UIKit
import RxCocoa
import RxSwift

class FavoriteViewController: BaseVIewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblIsEmpty: UILabel!
    
    var favoriteViewModel: FavoriteViewModel
    
    init(favoriteViewModel: FavoriteViewModel) {
        self.favoriteViewModel = favoriteViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        loadData()
    }
    
    func loadData() {
        favoriteViewModel.requestFavoriteList()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: GameCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: GameCell.cellIdentifier)
    }
    
    func updateUI() {
        if favoriteViewModel.favoriteList.value.count > 0 {
            tableView.isHidden = false
            lblIsEmpty.isHidden = true
        } else {
            tableView.isHidden = true
            lblIsEmpty.isHidden = false
        }
        tableView.reloadData()
    }
    
    func setupBinding() {
        favoriteViewModel.error.subscribe(onNext: { error in
            self.showAlert(title: "Perhatian", message: error)
        }).disposed(by: favoriteViewModel.disposeBag)
        
        favoriteViewModel.loading.subscribe(onNext: { loading in
            if loading {
                self.showLoading()
            } else {
                self.removeLoading()
            }
        }).disposed(by: favoriteViewModel.disposeBag)
        
        favoriteViewModel.favoriteList.subscribe(onNext: { result in
            self.updateUI()
        }).disposed(by: favoriteViewModel.disposeBag)
        
        favoriteViewModel.favoriteDetail.subscribe(onNext: { result in
            self.presentDetail()
        }).disposed(by: favoriteViewModel.disposeBag)
    }
    
    @objc func buttonUnfavoriteTapped(_ sender : UIButton) {
        let index = sender.tag
        let data = favoriteViewModel.favoriteList.value[index]
        favoriteViewModel.requestDeleteFavorite(id: data.id ?? 0)
    }
    
    func presentDetail() {
        if let gameId = self.favoriteViewModel.selectedGameId.value {
            let detailViewController = ModuleBuilder.getView(module: .detail(gameId: gameId)) as! DetailViewController
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteViewModel.favoriteList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.cellIdentifier, for: indexPath) as! GameCell
        let data = favoriteViewModel.favoriteList.value[indexPath.row]
        
        cell.update(data: data)
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(buttonUnfavoriteTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = favoriteViewModel.favoriteList.value[indexPath.row]
        self.favoriteViewModel.selectedGameId.accept(data.id)
        self.favoriteViewModel.requestFavoriteDetail(id: data.id ?? 0)
    }
}
