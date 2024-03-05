//
//  PetDetailsViewController.swift
//  NetworkingAndAPI
//
//  Created by Fawaz Alzamel on 04/03/2024.
//

import UIKit
import Kingfisher
import Alamofire
import SnapKit

class PetDetailsViewController: UIViewController {

    
    var pets : Pet?
    
    let idLabelView = UILabel()
    let nameLabelView = UILabel()
    let adoptedLabelView = UILabel()
    let imageLabelView = UIImageView()
    let ageLabelView = UILabel()
    let genderLabelView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(idLabelView)
        view.addSubview(nameLabelView)
        view.addSubview(adoptedLabelView)
        view.addSubview(imageLabelView)
        view.addSubview(ageLabelView)
        view.addSubview(genderLabelView)
        
        setupUI()
        setUpConstraints()
        title = "Pet Details"
    }
    

    func setupUI(){
        
        imageLabelView.kf.setImage(with: URL(string: pets?.image ?? "No image"))
        imageLabelView.contentMode = .scaleToFill
        
        idLabelView.text = "Pet ID: \(pets?.id ?? 00)"
        
        nameLabelView.text = "Pet Name: \(pets?.name ?? "No Name")"
        
        adoptedLabelView.text = "Pet is Adopted: \(pets?.adopted ?? false)"
        
        ageLabelView.text = "Pet's Age: \(pets?.age ?? 00)"
        
        genderLabelView.text = "Pet's Gender: \(pets?.gender ?? "Not Specified")"
    }
    

    func setUpConstraints(){
        
        imageLabelView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        nameLabelView.snp.makeConstraints { make in
            make.top.equalTo(imageLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        idLabelView.snp.makeConstraints { make in
            make.top.equalTo(nameLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        adoptedLabelView.snp.makeConstraints { make in
            make.top.equalTo(idLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        ageLabelView.snp.makeConstraints { make in
            make.top.equalTo(adoptedLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        genderLabelView.snp.makeConstraints { make in
            make.top.equalTo(ageLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
