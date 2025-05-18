//
//  BaseViewModel.swift
//  MyHome
//
//  Created by BoBo Tun on 12/01/2025.
//
import Foundation
import Combine
import RxCocoa
import RxSwift
import RxRelay
class BaseViewModel {
    let disposableBag = DisposeBag()
    var bindings = Set<AnyCancellable>()
    weak var viewController : BaseViewController?
    //let apiService: APIServiceProtocol
    let errorPublishSubject = PassthroughSubject<APIError,Never>()
    let showErrorMessagePublishSubject = PassthroughSubject<String,Never>()
    let loadingPublishSubject = PassthroughSubject<Bool,Never>()
    let isNoDataPublishSubject = PassthroughSubject<Bool,Never>()
    let isNoInternetPublishSubject = PassthroughSubject<Bool,Never>()
    let isSeverErrorPublishSubject = PassthroughSubject<Bool,Never>()
    let isNoMoreDataPublishSubject = PassthroughSubject<Bool,Never>()
    var isShowNoDataPageForUnKnownError: Bool = true
    let showFooterLoadingViewPublisher = PassthroughSubject<Bool, Never>()
    let hideFooterLoadingViewPublisher = PassthroughSubject<Bool, Never>()
    let showPullToRefreshAnimationViewPublisher = PassthroughSubject<Bool, Never>()
    
//    init() {
//        //self.apiService = APIService()
//    }
//    
//    deinit {
//        debugPrint("Deinit ::: \(type(of: self))")
//    }
    
    func bindViewModel(in viewController: BaseViewController? = nil,
                       isDataShowingPage: Bool = true) {
        self.viewController = viewController
        isShowNoDataPageForUnKnownError = isDataShowingPage
        
        loadingPublishSubject.sink{[unowned self] (result) in
            if result {
                self.viewController?.showLoading()
            } else {
                self.viewController?.hideLoading()
                if let vc = self.viewController as? BaseTableViewController{
                    vc.hidePullToRefreshAnimationViewPublishSubject.send(true)
                    vc.hideFooterLoadingViewPublishSubject.send(true)
                }
            }
        }.store(in: &bindings)
        
        errorPublishSubject.sink{[unowned self] (error) in
            self.viewController?.hideLoading()
            if let vc = self.viewController as? BaseTableViewController{
                vc.hidePullToRefreshAnimationViewPublishSubject.send(true)
                vc.hideFooterLoadingViewPublishSubject.send(true)
            }
            switch error as APIError {
            case .noNetwork :
                self.isNoInternetPublishSubject.send(true)
            case .noData:
                self.isNoDataPublishSubject.send(true)
            case .unknownError:
                self.viewController?.showToast(message: "Something Went Wrong")
            case .serverError:
                self.isSeverErrorPublishSubject.send(true)
            default:
                self.isSeverErrorPublishSubject.send(true)
            }
        }.store(in: &bindings)
        
        showErrorMessagePublishSubject.sink { [weak self] (errorMessage) in
            self?.viewController?.showToast(message: errorMessage, isShowing: {
                self?.viewController?.view.isUserInteractionEnabled = false
            }, completion: {
                self?.viewController?.view.isUserInteractionEnabled = true
            })
        }.store(in: &bindings)
    }
}

