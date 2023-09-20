//
//  SearchViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 25/08/22.
//

import UIKit

class SearchViewController: BaseVIewController {
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnRemoveText: UIButton!
    
    var game: [Game]!
    var filteredData = [Game]()
    
    let searchViewModel: SearchViewModel
    
    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
        
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
    
    func setupUI() {
        btnRemoveText.isHidden = true
        
        txtSearch.delegate = self
        txtSearch.becomeFirstResponder()
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = 100
        tableView.register(UINib(nibName: GameCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: GameCell.cellIdentifier)
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func setupBinding() {
        searchViewModel.filtered.subscribe(onNext: { filtered in
            self.filteredData = filtered
            self.updateUI()
        }).disposed(by: searchViewModel.disposeBag)
        
        searchViewModel.loading.subscribe(onNext: { loading in
            if loading {
                self.showLoading()
            } else {
                self.removeLoading()
            }
        }).disposed(by: searchViewModel.disposeBag)
    }
    
    func loadData() {
        searchViewModel.getFilteredData(data: game, search: txtSearch.text)
    }
    
    @IBAction func btnRemoveTextTapped(_ sender: Any) {
        txtSearch.text = ""
        btnRemoveText.isHidden = true
        
        loadData()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.cellIdentifier, for: indexPath) as! GameCell
        let data = filteredData[indexPath.row]
        
        cell.update(data: data)
        return cell
    }
}

extension SearchViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if textfield.text != "" && textfield.text != nil {
            btnRemoveText.isHidden = false
        } else {
            btnRemoveText.isHidden = true
        }
        
        loadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearch.resignFirstResponder()
    }
}
