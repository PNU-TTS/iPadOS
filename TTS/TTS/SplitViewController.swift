//
//  SplitViewController.swift
//  TTS
//
//  Created by 안현주 on 2022/08/28.
//

import UIKit

class SplitViewController: UISplitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredDisplayMode = .oneBesideSecondary
        
        let menuVC = MenuController(style: .insetGrouped)
        menuVC.delegate = self
        
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .blue
        secondVC.title = "Home"
        
        self.viewControllers = [
            UINavigationController(rootViewController: menuVC),
            UINavigationController(rootViewController: secondVC)
        ]
    }
}

extension SplitViewController: MenuControllerDelegate {
    func didTapMenuItem(at index: IndexPath, title: String?) {
        (self.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: true)
        let vc = UIViewController()
        vc.view.backgroundColor = .systemRed
        vc.title = title
        (self.viewControllers.last as? UINavigationController)?.pushViewController(vc, animated: true)
    }
}

protocol MenuControllerDelegate {
    func didTapMenuItem(at index: IndexPath, title:String?)
}

class MenuController: UITableViewController {
    
    var delegate: MenuControllerDelegate?
    let tableLabels: [[String]] = [
        ["계좌잔고", "거래 시장", "판매 등록"],
        ["판매 신청 내역", "개인 정보"]
    ]
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        title = "Menu"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Trade"
        default:
            return "Account"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLabels[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableLabels[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellLabel = tableView.cellForRow(at: indexPath)?.textLabel?.text
        print("in selected \(indexPath.row)")
        delegate?.didTapMenuItem(at: indexPath, title: cellLabel)
    }
}
