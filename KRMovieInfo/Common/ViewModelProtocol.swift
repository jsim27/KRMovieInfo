//
//  ViewModelProtocol.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/04.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
