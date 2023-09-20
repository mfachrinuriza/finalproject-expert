//
//  DetailViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 24/08/22.
//

import UIKit
import SwiftUI

class DetailViewController: BaseVIewController {
    @IBOutlet weak var backroundImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    private let shimmer = DetailShimmer()
    
    var gameId: Int!
    var detailViewModel: DetailViewModel
    
    init(
        detailViewModel: DetailViewModel
    ) {
        self.detailViewModel = detailViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.loadData()
    }
    
    func loadData() {
        detailViewModel.requestGameDetail(id: gameId)
    }
    
    func updateUI() {
        if let gameData = detailViewModel.gameDetail.value {
            self.setNavigationBarWithTitleAndLikeButton(title: "Detail Game", isFavorite: detailViewModel.isFavorite.value)
            
            if let url = URL(string: gameData.background_image ?? "") {
                backroundImage.kf.setImage(with: url)
            }
            
            lblTitle.text = gameData.name
            lblRating.text = "\(gameData.rating ?? 0)"
            lblDate.text = "Released \(gameData.released ?? "")"
            
            if let attributedString = Extensions.convertHTMLToAttributedString(gameData.description ?? "") {
                lblDesc.attributedText = attributedString
            }
        }
    }
    
    func setupBinding() {
        detailViewModel.error.subscribe(onNext: { [weak self] error in
            self?.showAlert(title: "Perhatian", message: error)
        }).disposed(by: detailViewModel.disposeBag)
        
        // Shimmering
        detailViewModel.shimmering.subscribe(onNext: { shimmering in
            if shimmering {
                self.showShimmer()
            } else {
                self.removeShimmer()
            }
        }).disposed(by: detailViewModel.disposeBag)
        
        detailViewModel.isFavorite.subscribe(onNext: { [weak self] result in
            self?.updateUI()
        }).disposed(by: detailViewModel.disposeBag)
    }
    
    override func onRequestFavorite() {
        if let game = detailViewModel.gameDetail.value {
            if detailViewModel.isFavorite.value {
                detailViewModel.requestDeleteFavorite(id: game.id ?? 0)
            } else {
                let request = Game(
                    id: game.id,
                    slug: game.slug,
                    name: game.name,
                    released: game.released,
                    description: game.description,
                    background_image: game.background_image,
                    rating: game.rating
                )
                detailViewModel.requestCreateFavorite(request: request)
            }
        }
    }
    
    private func showShimmer() {
        AutoShimmerView.showShimmer(shimmer, in: self)
    }
    
    private func removeShimmer() {
        AutoShimmerView.hideShimmer(shimmer)
    }
}
