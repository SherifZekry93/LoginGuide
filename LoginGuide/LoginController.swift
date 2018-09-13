//
//  ViewController.swift
//  LoginGuide
//
//  Created by Sherif  Wagih on 9/1/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
protocol LoginControllerDelegate:class {
    func finishLoggingIn()
}
class LoginController: UIViewController,LoginControllerDelegate
{
    func finishLoggingIn() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        guard let mainNavigationController = rootViewController as? MainNavigationController else {return}
        
        mainNavigationController.viewControllers = [HomeController()]
        let defaults = UserDefaults()
        defaults.setLoginValue(value:true)
        print(defaults.isLoggedIn())
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        let index = IndexPath(item: pageController.currentPage, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
    }
    //Button Controls
    let nextButton:UIButton = {
        let next = UIButton()
        next.setTitle("Next", for: .normal)
        next.setTitleColor(.orange, for: .normal)
        next.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        return next
    }()
    
    let skipButton:UIButton = {
        let sk = UIButton()
        sk.setTitle("Skip", for: .normal)
        sk.setTitleColor(.orange, for: .normal)
        sk.addTarget(self, action: #selector(skipIntro), for: .touchUpInside)
        return sk
    }()
    //Pages datasource
    let pages:[Page] = {
        let firstPage = Page(imageName: "page1", title: "\nShare a great lesson!\n", message: "It's free to send your books to the people in your life.Every Recipient's first book is on us!")
        let secondPage = Page(imageName: "page2", title: "\nSend from your Library\n", message: "Tap the more menu next to any book. Choose \"Send this book\"")
        let thirdPage = Page(imageName: "page3", title: "\nSend from the player!\n", message: "Tap the more menu next to any book. Choose \"Send this book\"")
        return [firstPage,secondPage,thirdPage]
    }()
    //pagecontoller
    lazy var pageController:UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = self.pages.count + 1
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .orange
        return pc
    }()
    //collectionview
    lazy var collectionView:UICollectionView = {
        let layOut = UICollectionViewFlowLayout()
        var  cv = UICollectionView(frame: .zero, collectionViewLayout: layOut)
        layOut.scrollDirection = .horizontal
        layOut.minimumLineSpacing = 0
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv;
    }()
    
   //constraints layout
    var pageControllerBottomAnchor:NSLayoutConstraint?
    var skipControllerTopAnchor:NSLayoutConstraint?
    var nextControllerTopAnchor:NSLayoutConstraint?
    
    let cellId = "cellId"
    let loginCellId = "loginCellId"
    fileprivate func registerCells()
    {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier:cellId)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    fileprivate func observeKeyboardNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    @objc func KeyboardHide()
    {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }, completion: nil)
    }
    @objc func KeyboardShow()
    {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y:CGFloat = UIDevice.current.orientation.isLandscape ? -150 : -100
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }, completion: nil)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        observeKeyboardNotification()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(collectionView)
        view.addSubview(pageController)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
            ,
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            ,
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ,
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        registerCells()

        pageController.translatesAutoresizingMaskIntoConstraints = false
        pageControllerBottomAnchor =  pageController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:0)
        NSLayoutConstraint.activate(
            
            [
                
                pageControllerBottomAnchor!,
                pageController.heightAnchor.constraint(equalToConstant: 30),
                pageController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                pageController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
               
            ]
        )
       
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipControllerTopAnchor = skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate(
            [
                skipControllerTopAnchor!,
                skipButton.heightAnchor.constraint(equalToConstant: 30),
                skipButton.widthAnchor.constraint(equalToConstant: 60),
                skipButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor ),
                
            ]
            
        )
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextControllerTopAnchor =  nextButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate(
            [
                nextControllerTopAnchor!,
                nextButton.heightAnchor.constraint(equalToConstant: 30),
                nextButton.widthAnchor.constraint(equalToConstant: 60),
                nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor ),
        ])
    }
}

