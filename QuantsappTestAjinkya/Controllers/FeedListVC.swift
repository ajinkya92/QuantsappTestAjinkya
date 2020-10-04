//
//  FeedListVC.swift
//  QuantsappTestAjinkya
//
//  Created by apple on 04/10/20.
//

import UIKit
import Alamofire
import Toast_Swift

class FeedListVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var feedTblView: UITableView!
    
    //Variables
    var feedDetailsArr: [FeedDetails] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        setupInitialUI()
    }
    
    private func setupInitialUI() {
        feedTblView.delegate = self
        feedTblView.dataSource = self
        feedTblView.register(UINib(nibName: "FeedTblCell", bundle: nil), forCellReuseIdentifier: "FeedTblCell")
        serviceCalls()
    }
    
    private func serviceCalls() {
        getFeedsList()
    }

}

// MARK: - TABLE VIEW DELEGATE & DATA SOURCE IMPLEMENTATION
extension FeedListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedDetailsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTblCell") as? FeedTblCell else {return UITableViewCell()}
        cell.configureFeedCell(feedDetails: feedDetailsArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

// MARK: - SERVICES IMPLEMENTATIONS
extension FeedListVC {
    
    func getFeedsList() {
        
        ServiceManager.instance.getWebServiceDataWith(
            url: AppUrls.GET_FEEDS_URL,
            method: .get,
            encoding: JSONEncoding.default) { [weak self] (result: Result<Feed, ServiceErrorMessages>) in
            guard let self = self else {return}
            
            self.view.makeToastActivity(.center)
            
            switch result {
            case .success(let returnedResponse):
                self.feedDetailsArr = returnedResponse.feed
                
                DispatchQueue.main.async {
                    self.view.hideToastActivity()
                    self.feedTblView.reloadData()
                }
                
            case .failure(let error):
                self.view.hideToastActivity()
                self.view.makeToast(error.rawValue, duration: 2.0, position: .bottom)
            }
            
            
        }
        
    }
    
}
