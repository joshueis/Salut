//
//  AvatarVC.swift
//  Salut
//
//  Created by Israel Carvajal on 10/8/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class AvatarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var avtrType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

    @IBAction func segmentCChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0{
            avtrType = .dark
        } else{
            avtrType = .light
        }
        collectionView.reloadData()
    }
    @IBAction func backPressed(_ sender: Any) {
        
    }
    
    
    //for collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configCell(index: indexPath.item, type: avtrType)
            return cell
        }else{
            return AvatarCell()
        }
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    //set up the size according to the device's screen
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numOfCol : CGFloat = 3 // for regular width
        if (UIScreen.main.bounds.width > 320){
            numOfCol = 4
        }
        
        let spaceBetweenCells : CGFloat = 10
        let padding: CGFloat = 20
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfCol - 1) * spaceBetweenCells) / numOfCol
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avtrType == .dark{
            UserDataService.instance.setAvatarName(avtrName: "dark\(indexPath.item)")
        }else{
            UserDataService.instance.setAvatarName(avtrName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
