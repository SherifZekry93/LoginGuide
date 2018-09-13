//
//  PageCell.swift
//  LoginGuide
//
//  Created by Sherif  Wagih on 9/1/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell
{
    var page:Page?{
        didSet{
            guard let page = page
            else
            {
                return
            }
            var imageName = page.imageName
            if UIDevice.current.orientation.isLandscape
            {
                imageName += "_landscape"
                print(imageName)
            }
            imageView.image = UIImage(named: imageName)
            //textView.text = page.title
            let attributedText = NSMutableAttributedString(
                string: page.title, attributes:
                [
                    NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18),
                    NSAttributedStringKey.foregroundColor: UIColor.black
                ]
            )
            
            attributedText.append(NSAttributedString(
                string: page.message, attributes:
                [
                    NSAttributedStringKey.foregroundColor: UIColor.darkGray,
                    NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)
                ]
))
            textView.attributedText = attributedText
            textView.textAlignment = .center
        }
    }
    lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        //iv.image = UIImage(named:(page?.imageName)!)
        iv.clipsToBounds = true
        return iv
    }()
     lazy var textView:UITextView = {
        let tv = UITextView()
        tv.text = page?.title
       // tv.backgroundColor = .red
        tv.isEditable = false
        tv.isScrollEnabled = false
        //tv.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.8, alpha: 1)
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews()
    {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparator)
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
            ,
            imageView.topAnchor.constraint(equalTo: topAnchor)
            ,
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
            ,
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ,
            imageView.bottomAnchor.constraint(equalTo: textView.topAnchor)
            
            ])
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalTo: heightAnchor,multiplier:  0.4 )
            ,
            textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
            ,
            textView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ,
            textView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        lineSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineSeparator.heightAnchor.constraint(equalToConstant:2)
            ,
            lineSeparator.leadingAnchor.constraint(equalTo: leadingAnchor)
            ,
            lineSeparator.trailingAnchor.constraint(equalTo: trailingAnchor)
            ,
            lineSeparator.topAnchor.constraint(equalTo: imageView.bottomAnchor)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
