//
//  MockMovieListView.swift
//  MoviesAppTests
//
//  Created by Musa Kökcen on 13.04.23.
//

@testable import MoviesApp

class MockMovieListView: MovieListViewInterface {
    
    var isPrepareUICalled: Bool = false
    var isReloadDataCalled: Bool = false
    var isShowHUDCalled: Bool = false
    var isDismissHUDCalled: Bool = false
    var isShowAlertCalled: Bool = false
    
    func prepareUI() {
        isPrepareUICalled = true
    }
    
    func reloadData() {
        isReloadDataCalled = true
    }
    
    static var storyboardId: String {""}
    
    func showHUD() {
        isShowHUDCalled =  true
    }
    
    func dismissHUD() {
        isDismissHUDCalled = true
    }

    func showAlert(message: String, title: String, action: (() -> Void)?) {
        isShowAlertCalled = true
    }
}
