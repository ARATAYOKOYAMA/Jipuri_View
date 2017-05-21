//
//  Event_Detail.swift
//  Jipuri_View
//
//  Created by 横山　新 on 2017/05/17.
//  Copyright © 2017年 横山　新. All rights reserved.
//

import UIKit
import NCMB

class Event_Detail: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // イベントのリスト（タプル配列）
    var EventList : [(event_name:String, event_day:String, location:String, start_time:String, end_time:String, capacity:String, description:String, department_name:String, update_date:String, objectId: String)] = []
    
    @IBOutlet weak var Update_Label: UILabel!
    @IBOutlet weak var Event_Name_Label: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table ViewのdataSouceを設定
        tableView.dataSource = self
        
        // Table Viewのdelegateを設定
        tableView.delegate = self
        
        Update_Label.text = EventList[0].update_date
        
        Event_Name_Label.title = EventList[0].event_name
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    /*Cellの総数を返すdatasouceメソッド，必ず記載すること*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // イベントリストの総数
        return 7
    }
    
    /*Cellに値を設定するメソッド，必ず記載すること*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 表示を行うCellオブジェクト（1行）を取得する．
        let cell = tableView.dequeueReusableCell(withIdentifier: "Event_Detail", for: indexPath) as! Event_Detail_Custom_TableViewCell
        
        
        
        switch indexPath.row {
        case 0:
            cell.Label_name.text = "担当部署名"
            cell.Label_Value.text = EventList[0].department_name
            cell.Label_Value.textColor = UIColor.white
        case 1:
            cell.Label_name.text = "日程"
            cell.Label_Value.text = EventList[0].event_day + " " + EventList[0].start_time + "~" + EventList[0].end_time
        case 2:
            cell.Label_name.text = "場所"
            cell.Label_Value.text = EventList[0].location
        case 3:
            cell.Label_name.text = "定員"
            cell.Label_Value.text = EventList[0].capacity
        case 4:
            cell.Label_name.text = "詳細"
            cell.Label_Value.text = EventList[0].description
        case 5:
            cell.Label_name.text = "申込締切日"
            cell.Label_Value.text = ""
        case 6:
            cell.Label_name.text = "作成日"
            cell.Label_Value.text = ""
        default:
            print("test")
        }
        
        if indexPath.row == 0{
            switch EventList[0].department_name {
            case "女性部":
                cell.Label_Value.backgroundColor = UIColor.magenta
            case "青年部":
                cell.Label_Value.backgroundColor = UIColor.cyan
            case "福祉部":
                cell.Label_Value.backgroundColor = UIColor.orange
            case "総務部":
                cell.Label_Value.backgroundColor = UIColor.red
            case "防火防犯部":
                cell.Label_Value.backgroundColor = UIColor.blue
            case "環境部":
                cell.Label_Value.backgroundColor = UIColor.green
            case "役員":
                cell.Label_Value.backgroundColor = UIColor.red
            default:
                cell.Label_Value.backgroundColor = UIColor.black
            }
        }

        
        // 設定済みのCellオブジェクトを画面に反映
        return cell
    }
    
    /*Cellが選択された際に呼び出されるdelegateメソッド*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // ハイライト解除
        //tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func To_Join(_ sender: Any) {
        // Segue&ナビゲーションコントローラーで繋いであら不思議 そもそも遷移するやつ
        self.performSegue(withIdentifier: "To_Join", sender: EventList[0].objectId)
    }
    
    /*  遷移内容をチェックして、値渡しとかする */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "To_Join" { //Detailに遷移する場合(Segueのid)
            // Detailをインスタンス化
            let secondVc = segue.destination as! Event_Join
            // 値を渡す
            secondVc.objectId = EventList[0].objectId
            
        }else {
            // どちらでもない遷移
        }
    }
}

