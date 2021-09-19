//
//  InstagramCollectionViewController.swift
//  InstagramApp
//
//  Created by Machir on 2021/9/18.
//

import UIKit

private let reuseIdentifier = "\(InstagramCollectionViewCell.self)"

class InstagramCollectionViewController: UICollectionViewController {
    
    var userInfo: InstagramResponse?
    var postImage = [InstagramResponse.Graphql.User.Edge_owner_to_timeline_media.Edges]()
    
    //抓取資料
    func fetchData() {
        let urlStr = "https://www.instagram.com/luckylulu0212/?__a=1"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970//解析JSON時間
                
                if let data = data {
                    do {
                        let searchResponse = try decoder.decode(InstagramResponse.self, from: data)
                        self.userInfo = searchResponse
                        DispatchQueue.main.async {
                            self.postImage = (self.userInfo?.graphql.user.edge_owner_to_timeline_media.edges)!
                            self.collectionView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return postImage.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? InstagramCollectionViewCell else {return UICollectionViewCell()}
    
        let item = postImage[indexPath.item]
        URLSession.shared.dataTask(with: item.node.display_url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    cell.showImageView.image = UIImage(data: data)
                }
            }
        }.resume()
    
        return cell
    }
    
    //CollectionReusableView要顯示的內容
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //設定collectionReusableView的kind為header。設定reusableView的ID並轉型成UserInfoCollectionReusableView
        guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(UserInfoCollectionReusableView.self)", for: indexPath) as? UserInfoCollectionReusableView else {return UICollectionReusableView()}
        
        return reusableView
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
