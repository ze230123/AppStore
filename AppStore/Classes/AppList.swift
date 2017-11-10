//
//  ViewController.swift
//  AppStore
//
//  Created by 泽i on 2017/10/27.
//  Copyright © 2017年 泽i. All rights reserved.
//

import UIKit
import MJRefresh

let dict: [String: Any] = [
    "api_token": "62d9c2178a6aaa6d0b6852b783c0d79a"
]
let appid = "59f86639ca87a854000002a6"

class AppList: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var items: [CustomAppModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    @objc func loadNewData() {
        let url = "http://api.fir.im/apps"
        Service.getCustomList(url: url, parameters: dict).then { (list: CustomListModel<CustomAppModel>) -> Void in
            self.items = list.items.filter { $0.name != "AppStore"}
        }.catch { (error) in
            printLog(error)
        }.always {
            self.collectionView.mj_header.endRefreshing()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        collectionView.mj_header = header

        loadNewData()

        let uploadUrl = "http://api.fir.im/apps/latest/\(appid)"
        Service.get(url: uploadUrl, parameters: dict).then { (update: UploadModel) -> Void in
            if update.isGreater(Constants.versionNumber) {
                self.showAlert(update: update)
            }
            }.catch { (error) in
                printLog(error)
        }
    }
    func showAlert(update: UploadModel) {
        let alert = UIAlertController(title: "版本更新", message: "更新版本：v\(update.versionShort)\n\(update.changeLog)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "暂不更新", style: .cancel, handler: nil)
        let doneAction = UIAlertAction(title: "立即更新", style: .default) { (action) in
            self.open(url: update.updateUrl)
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        present(alert, animated: true, completion: nil)
    }
}

extension AppList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        let model = items[indexPath.item]
        (cell as? ApplistCell)?.model = model
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
}
//"http://api.fir.im/apps/:id/download_token?api_token=xxxxx"
extension AppList: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        let downUrl = "http://api.fir.im/apps/\(item.id)/download_token"
        Service.get(url: downUrl, parameters: dict).then { (down: DownloadModel) -> Void in
            print("id \(item.id)")
            self.open(url: down.downloadUrl(id: item.id))
        }.catch { (error) in
            
        }
    }
}

extension UIViewController {
    func open(url: String) {
        guard let url = URL(string: url) else { return }
        print(url)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

extension AppList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 160)
    }
}
