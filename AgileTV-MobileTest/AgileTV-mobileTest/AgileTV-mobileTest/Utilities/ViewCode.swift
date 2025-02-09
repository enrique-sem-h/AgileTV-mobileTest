//
//  ViewCode.swift
//  AgileTV-MobileTest
//
//  Created by Enrique Carvalho on 08/02/25.
//

// This protocol is an interesting approach for view setup, it should be conformed in an extension by the UIView and the setupView() method should be called in the view's initializer
protocol ViewCode {
    func addSubviews()
    func setupConstraints()
    func configurations()
}


extension ViewCode {
    func setupView() {
        addSubviews()
        setupConstraints()
        configurations()
    }
    
    func configurations() {
        
    }
}
