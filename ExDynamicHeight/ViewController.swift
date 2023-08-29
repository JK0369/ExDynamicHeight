//
//  ViewController.swift
//  ExDynamicHeight
//
//  Created by 김종권 on 2023/08/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let collectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(MyCell.self, forCellWithReuseIdentifier: "cell")
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        view.contentInsetAdjustmentBehavior = .always
        return view
    }()
    
    private static var width: Int {
        Int(UIScreen.main.bounds.width)
    }
    private static var height: Int {
        (100...800).randomElement()!
    }
    
    var dataSource = (1...10)
        .compactMap { _ in URL(string: "https://random.imagecdn.app/\(ViewController.width)/\(ViewController.height)") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(dataSource)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyCell
        cell?.url = dataSource[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
}
