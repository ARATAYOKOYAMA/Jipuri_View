//
//  Information.swift
//  Jipuri_View
//
//  Created by 横山　新 on 2017/05/14.
//  Copyright © 2017年 横山　新. All rights reserved.
//

import UIKit
import NCMB
import SafariServices

class Information: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // お知らせのリスト（タプル配列）
    //var InfoList : [NCMBObject] = []
    var InfoList : [(department_name:String , title:String, date:String, info:String)] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //切り替える度に配列を空にする
        InfoList.removeAll()
        // Informationテーブルからすべてを取得
        // クラスのNCMBObjectを作成
        let obj3 = NCMBQuery(className: "Information")
        obj3?.order(byDescending: "date")
        obj3?.findObjectsInBackground { (objects, error) in
            if error != nil { // エラーがあるとき
                print(error?.localizedDescription)
            }else { // エラーがないとき
                
                for (i, value) in (objects?.enumerated())!{
                    
                    let result = value as? NCMBObject
                    
                    //print(result?.object(forKey:"department_name"))
                    
                    // 担当部署
                    guard let department_name = result?.object(forKey:"department_name")  as? Optional ?? "" else{
                        continue
                    }
                    // タイトル
                    guard let title = result?.object(forKey:"title")  as? Optional ?? "" else{
                        continue
                    }
                    
                    // 作成日
                    guard let date = result?.object(forKey:"date")  as? Optional ?? "" else{
                        continue
                    }
                    // 本文
                    guard let info = result?.object(forKey:"info")  as? Optional ?? "" else{
                        continue
                    }
                    
                    // 1つの情報をタプルでまとめて管理
                    let tmp_Info = (department_name, title, date, info)
                    // 配列へ追加
                    self.InfoList.append(tmp_Info)
                    // Table Viewを更新する
                    self.tableView.reloadData()
                    //print(result)
                }
                
            }
        }
        // Table ViewのdataSouceを設定
        tableView.dataSource = self
        
        // Table Viewのdelegateを設定
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var tableView: UITableView!
    
    
    /*Cellの総数を返すdatasouceメソッド，必ず記載すること*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // お菓子リストの総数
        return InfoList.count
    }

    /*Cellに値を設定するメソッド，必ず記載すること*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 表示を行うCellオブジェクト（1行）を取得する．
        let cell = tableView.dequeueReusableCell(withIdentifier: "information_cell", for: indexPath) as! Information_CustomTableViewCell
        
        // お菓子のタイトルを設定
        cell.Info_department.text = InfoList[indexPath.row].department_name
        cell.Info_title.text = InfoList[indexPath.row].title
        cell.Info_date.text = InfoList[indexPath.row].date
        
        switch InfoList[indexPath.row].department_name {
        case "女性部":
            cell.Info_department.backgroundColor = UIColor.magenta
        case "青年部":
            cell.Info_department.backgroundColor = UIColor.cyan
        case "福祉部":
            cell.Info_department.backgroundColor = UIColor.orange
        case "総務部":
            cell.Info_department.backgroundColor = UIColor.red
        case "防火防犯部":
            cell.Info_department.backgroundColor = UIColor.blue
        case "環境部":
            cell.Info_department.backgroundColor = UIColor.green
        default:
            cell.Info_department.backgroundColor = UIColor.black
        }
        //cell.Info_department.backgroundColor = UIColor.red
        
        // 設定済みのCellオブジェクトを画面に反映
        return cell
    }
    
    /*Cellが選択された際に呼び出されるdelegateメソッド*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // ハイライト解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title:InfoList[indexPath.row].title, message: InfoList[indexPath.row].info, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancel = UIAlertAction(title: "閉じる", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセルをタップした時の処理")
        })
        
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)

    }

}
