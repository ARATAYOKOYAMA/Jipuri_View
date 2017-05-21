//
//  Config.swift
//  Jipuri_View
//
//  Created by 横山　新 on 2017/05/21.
//  Copyright © 2017年 横山　新. All rights reserved.
//

import UIKit
import SafariServices

class Config: UIViewController, SFSafariViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table ViewのdataSouceを設定
        tableView.dataSource = self
        
        // Table Viewのdelegateを設定
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*Cellの総数を返すdatasouceメソッド，必ず記載すること*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // お菓子リストの総数
        return 3
    }
    
    /*Cellに値を設定するメソッド，必ず記載すること*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 2:
            
            // 表示を行うCellオブジェクト（1行）を取得する．
            let cell_bo = tableView.dequeueReusableCell(withIdentifier: "bottomcell", for: indexPath) as! Config_Custom_TableViewCell
            cell_bo.Title.text = "陣川あさひ町会"
            cell_bo.Adress.text = "住所：北海道函館市陣川79-55"
            cell_bo.Tell.text = "電話番号："
            cell_bo.HP.text = "ホームページ："
            
            return cell_bo
            
        case 0:
            // 表示を行うCellオブジェクト（1行）を取得する．
            let cell = tableView.dequeueReusableCell(withIdentifier: "Top_Cell", for: indexPath) as! Config_Custom01_TableViewCell
            
            cell.title.text = "ヘルプ"
            cell.mid_label.text = "じぷりの取り扱い説明書が見れます。"
            
            // 設定済みのCellオブジェクトを画面に反映
            return cell
            
        default:
            // 表示を行うCellオブジェクト（1行）を取得する．
            let cell = tableView.dequeueReusableCell(withIdentifier: "Mid_Cell", for: indexPath) as! Config_Custom01_TableViewCell
            
            cell.title.text = "入力情報のリセット"
            cell.mid_label.text = "参加申し込みで入力した情報の"
            cell.bottom_label.text = "履歴が削除されます。"
            
            // 設定済みのCellオブジェクトを画面に反映
            return cell
        }
        
        
    }
    
    /*Cellが選択された際に呼び出されるdelegateメソッド*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // ハイライト解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    
    /* 電話かけるやつ */
    @IBAction func Tell_Jinkawa(_ sender: Any) {
        let url = NSURL(string: "tel://0138318855")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    /* HPひらくやつ */
    @IBAction func Link_To_JinkawaHP(_ sender: Any) {
        // URLをstringからURL型に変換
        let urlToLink = URL(string: "http://www.jinkawaasahi.com/")
        
        // SFSafariViewを開く
        let safariViewController = SFSafariViewController(url: urlToLink!)
        
        // delegateの通知先を自分自身
        safariViewController.delegate = self
        
        // SafariViewが開かれる
        present(safariViewController, animated: true, completion: nil)
    }
    
    /*SafariViewが閉じられた時に呼ばれるdelegateメソッド*/
    func safariViewController(_ controller: SFSafariViewController) {
        
        // SafariViewを閉じる
        dismiss(animated: true, completion: nil)
    }
}
