//
//  TestModuleViewController.swift
//  ViperDemo
//
//  Created Mohamed Gamal on 10/28/19.
//
//

import UIKit
import RxSwift
import RxCocoa

class TestModuleViewController: UIViewController, TestModuleViewControllerProtocol {
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Attributes
	var presenter: TestModulePresenterProtocol?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attach()
        bindLoginButton()
        bindTextFields()
        handleInternetConnectivity()
    }
    
    private func bindTextFields() {
        emailField.rx.text.changed.bind { [weak self] (text) in
            guard let viewModel = self?.presenter?.viewModel else { return }
            viewModel.emailMobile.accept(text)
        }.disposed(by: disposeBag)
        
        passwordField.rx.text.changed.bind { [weak self] (text) in
            guard let viewModel = self?.presenter?.viewModel else { return }
            viewModel.password.accept(text)
        }.disposed(by: disposeBag)
    }
    
    private func bindLoginButton() {
        guard let viewModel = presenter?.viewModel else { return }
        logInBtn.rx.tap
            .bind(to: viewModel.loginTap)
            .disposed(by: disposeBag)
    }
    
    private func handleInternetConnectivity() {
        presenter?.viewModel.connectionErrorHandler.subscribe(onNext: { [weak self] connected in
            if connected == false {
            let alert = UIAlertController(title: "Error", message: "no internet connection", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alertx) in
            }
            alert.addAction(cancelAction)
            self?.present(alert, animated: true, completion: nil)
            }
            }).disposed(by: disposeBag)
    }
}
