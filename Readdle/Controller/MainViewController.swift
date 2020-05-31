//
//  MainViewController.swift
//  CustomCollectionLayout
//
//  Created by Vladimir Drozdin on 24/05/20.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
        
    var selectedCell: ProfileCollectionViewCell?
    var selectedCellImageViewSnapshot: UIView?
    
    var animator: Animator?
    
    private enum PresentationStyle: String, CaseIterable {
            case table
            case defaultGrid
            
            var buttonImage: UIImage {
                switch self {
                case .table: return #imageLiteral(resourceName: "table")
                case .defaultGrid: return #imageLiteral(resourceName: "default_grid")
                }
            }
        }
        
        private var selectedStyle: PresentationStyle = .table {
            didSet { updatePresentationStyle() }
        }
        
        private var styleDelegates: [PresentationStyle: CollectionViewSelectableItemDelegate] = {
            let result: [PresentationStyle: CollectionViewSelectableItemDelegate] = [
                .table: TabledContentCollectionViewDelegate(),
                .defaultGrid: DefaultGriddedContentCollectionViewDelegate(),
            ]
            result.values.forEach {
                $0.didSelectItem = { _ in
                }
            }
            return result
        }()
        
        private var datasource: [Profile] = ProfilesProvider.get()
        var datasourceCurrent: [Profile] = ProfilesProvider.get()
        var datasourceAppearenceArray: [Profile] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            updatePresentationStyle()
            collectionView.delegate = self
            collectionView.dataSource = self
            self.collectionView.register(ProfileCollectionViewCell.nib, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseID)
            collectionView.contentInset = .zero
            updatePresentationStyle()
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            self.collectionView.addGestureRecognizer(tap)
            self.collectionView.isUserInteractionEnabled = true

        }
        
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
       if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
        
        selectedCell = collectionView.cellForItem(at: indexPath) as? ProfileCollectionViewCell
        selectedCellImageViewSnapshot = selectedCell?.ibImageView.snapshotView(afterScreenUpdates: false)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        let cell = self.collectionView.cellForItem(at: indexPath as IndexPath) as! ProfileCollectionViewCell
        let data = getAppropriateData()
        let profile = data[indexPath.item]
        vc.modalPresentationStyle = .fullScreen
        vc.image = cell.ibImageView.image!
        vc.name = cell.ibLabel.text!
        vc.status = profile.status
        vc.transitioningDelegate = self
        vc.email = profile.email
        present(vc, animated: true, completion: nil)
        }
    }
        
        private func updatePresentationStyle() {
            collectionView.delegate = styleDelegates[selectedStyle]
            collectionView.performBatchUpdates({
                collectionView.reloadData()
            }, completion: nil)

        }
    
    @IBAction func segmentControllerPressed(_ sender: Any) {
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: selectedStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        selectedStyle = allCases[nextIndex]
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        DispatchQueue.global(qos: .background).async {
            let randomStatusCount = Int.random(in: 1..<self.datasourceCurrent.count)
            let pickStatus = self.datasourceCurrent[randomPick: randomStatusCount]
        for j in 0..<pickStatus.count {
            for i in 0..<self.datasourceCurrent.count {
                if pickStatus[j].email == self.datasourceCurrent[i].email {
                    if self.datasourceCurrent[i].status == "online" {
                        self.datasourceCurrent[i].status = "offline"
                    } else {
                        self.datasourceCurrent[i].status = "online"
                    }
                }
            }
        }
            let randomNamesCount = Int.random(in: 1..<self.datasourceCurrent.count)
            let pickName = self.datasourceCurrent[randomPick: randomNamesCount]
        for j in 0..<pickName.count {
            for i in 0..<self.datasourceCurrent.count {
                if pickName[j].email == self.datasourceCurrent[i].email {
                    self.datasourceCurrent[i].name = "\(firstNames.randomElement()!) \(lastNames.randomElement()!)"
                }
            }
        }
            if self.datasourceCurrent.count > 3 {
                let randomRemoveCount = Int.random(in: 1...self.datasourceCurrent.count / 3)
            let pickRemove = self.datasourceCurrent[randomPick: randomRemoveCount]
            for j in 0..<pickRemove.count {
      
                self.datasourceAppearenceArray.append(pickRemove[j])
                self.datasourceCurrent = self.datasourceCurrent.filter{ $0.email != pickRemove[j].email}
  
            }
        }
        
            if self.datasourceCurrent.count < self.datasource.count {
                let randomAddCount = Int.random(in: 1...self.datasourceAppearenceArray.count)
                let pickAdd = self.datasourceAppearenceArray[randomPick: randomAddCount]
            for j in 0..<pickAdd.count {
                self.datasourceCurrent.append(pickAdd[j])
                self.datasourceAppearenceArray = self.datasourceAppearenceArray.filter{ $0.email != pickAdd[j].email}
            }
        }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func getAppropriateData() -> [Profile] {
        return datasourceCurrent
    }
    
    
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         let data = getAppropriateData()
         return data.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseID, for: indexPath) as? ProfileCollectionViewCell else {
            fatalError("Wrong cell")
        }
        
        let data = getAppropriateData()
        
        let fruit = data[indexPath.item]

        cell.loadGravatar(url: fruit.email)
        cell.loadStatus(with: fruit.status)
        cell.update(title: fruit.name)

        return cell
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let firstViewController = presenting as? MainViewController,
            let secondViewController = presented as? InfoViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }

        animator = Animator(type: .present, firstViewController: firstViewController, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let secondViewController = dismissed as? InfoViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot else { return nil }

        animator = Animator(type: .dismiss, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return nil
    }
}

