//
//  ViewController+ControlsDelegate.swift
//  LoginGuide
//
//  Created by Sherif  Wagih on 9/1/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
extension LoginController
{
    @objc func goToNextPage()
    {
        let toScroll = min(pageController.currentPage + 1, pages.count)
        let indexPath = IndexPath(item: toScroll, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        pageController.currentPage += 1
        scrollAndHideContros()
    }
    @objc func skipIntro()
    {
        pageController.currentPage = pages.count
        let indexPath = IndexPath(item: pages.count, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        scrollAndHideContros()
    }
    func setAnimationValue(pageValue:CGFloat = 0,skipAndNextValue:CGFloat = 0)
    {
        pageControllerBottomAnchor?.constant = pageValue
        nextControllerTopAnchor?.constant = skipAndNextValue
        skipControllerTopAnchor?.constant = skipAndNextValue
    }
    
    func scrollAndHideContros()
    {
        if pageController.currentPage == pages.count
        {
            setAnimationValue(pageValue: 100, skipAndNextValue: -100)
            UIView.animate(withDuration: 0.27)
            {
                self.view.layoutIfNeeded()
            }
        }
        else
        {
            setAnimationValue()
            UIView.animate(withDuration: 0.17)
            {
                self.view.layoutIfNeeded()
            }
        }
    }
}
