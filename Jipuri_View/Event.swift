//
//  Event.swift
//  Jipuri_View
//
//  Created by 横山　新 on 2017/05/15.
//  Copyright © 2017年 横山　新. All rights reserved.
//


import UIKit
import NCMB
import SafariServices

class Event: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // イベントのリスト（タプル配列）
    var EventList : [(event_name:String, event_day:String, location:String, start_time:String, end_time:String, capacity:String, description:String, department_name:String, update_date:String, objectId: String)] = []
    
    var tmp_Event : [(event_name:String, event_day:String, location:String, start_time:String, end_time:String, capacity:String, description:String, department_name:String, update_date:String, objectId: String)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //切り替える度に配列を空にする
        EventList.removeAll()
        // Informationテーブルからすべてを取得
        // クラスのNCMBObjectを作成
        let obj = NCMBQuery(className: "Event")
        obj?.order(byDescending: "update_date")
        obj?.findObjectsInBackground { (objects, error) in
            if error != nil { // エラーがあるとき
                print(error?.localizedDescription)
            }else { // エラーがないとき
                for (i, value) in (objects?.enumerated())!{
                    
                    let result = value as? NCMBObject

                    // イベント名
                    guard let name = result?.object(forKey:"event_name")  as? Optional ?? "" else{
                        continue
                    }
                    
                    // 日程
                    guard let day = result?.object(forKey:"day")  as? Optional ?? "" else{
                        continue
                    }
                    
                    // 場所
                    guard let location = result?.object(forKey:"location")  as? Optional ?? "" else{
                        continue
                    }
                    
                    // 開始時刻
                    guard let start_time = result?.object(forKey:"start_time")  as? Optional ?? "" else{
                        continue
                    }

                    // 終了時刻
                    guard let end_time = result?.object(forKey:"end_time")  as? Optional ?? "" else{
                        continue
                    }
                    
                    // 定員
                    guard let capacity = result?.object(forKey:"capacity")  as? Optional ?? "" else{
                        continue
                    }
                    
                    // 詳細
                    guard let descriptions = result?.object(forKey:"description")  as? Optional ?? "" else{
                        continue
                    }
                    

                    // 担当部署
                    guard let department_name = result?.object(forKey:"event_department_name")  as? Optional ?? "" else{
                        continue
                    }
                    
                    
                    // 最終更新日
                    guard let update_date = result?.object(forKey:"update_date")  as? Optional ?? "" else{
                        continue
                    }
                    
                    guard let objectId = result?.object(forKey:"objectId")  as? Optional ?? "" else{
                        continue
                    }
                    
                    // 1つの情報をタプルでまとめて管理
                    let tmp_Event = (name, day, location, start_time, end_time, capacity, descriptions, department_name, update_date, objectId)
                    // 配列へ追加
                    self.EventList.append(tmp_Event)
                
                    
                    // Table Viewを更新する
                    self.tableView.reloadData()
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
        // イベントリストの総数
        return EventList.count
    }
    
    /*Cellに値を設定するメソッド，必ず記載すること*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 表示を行うCellオブジェクト（1行）を取得する．
        let cell = tableView.dequeueReusableCell(withIdentifier: "Event_cell", for: indexPath) as! Event_CustomTableViewCell
        
        // お菓子のタイトルを設定
        cell.Event_title.text = EventList[indexPath.row].event_name
        cell.Event_day.text = EventList[indexPath.row].event_day
        cell.Event_department.text = EventList[indexPath.row].department_name
        cell.Event_location.text = EventList[indexPath.row].location
        cell.Event_starttime.text = EventList[indexPath.row].start_time
        cell.Event_finishtime.text = EventList[indexPath.row].end_time
        cell.Event_lastupdateted.text = EventList[indexPath.row].update_date
        
        switch EventList[indexPath.row].department_name {
        case "女性部":
            cell.Event_department.backgroundColor = UIColor.magenta
        case "青年部":
            cell.Event_department.backgroundColor = UIColor.cyan
        case "福祉部":
            cell.Event_department.backgroundColor = UIColor.orange
        case "総務部":
            cell.Event_department.backgroundColor = UIColor.red
        case "防火防犯部":
            cell.Event_department.backgroundColor = UIColor.blue
        case "環境部":
            cell.Event_department.backgroundColor = UIColor.green
        case "役員":
            cell.Event_department.backgroundColor = UIColor.red
        default:
            cell.Event_department.backgroundColor = UIColor.black
        }
        
        
//        // URLを取り出す
//        let url = URL(string: "https://mb.api.cloud.nifty.com/2013-09-01/applications/zMCtGPFYQE1JZ2UY/publicFiles/" + EventList[indexPath.row].objectId)
//        
//        // URLから画像を取得
//        if let image_data = try? Data(contentsOf: url!){
//            // 正常に取得できた場合は，UIImageで画像オブジェクトを生成して，Cellに設定
//            //cell.Event_Image.image = UIImage(data: image_data)
//        }
        
        
        
        // 設定済みのCellオブジェクトを画面に反映
        return cell
    }
    
    
    /*Cellが選択された際に呼び出されるdelegateメソッド*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // ハイライト解除
        tableView.deselectRow(at: indexPath, animated: true)
        //print("ハイライト")
        
    }
    
    /* didSelectRowAtでは遷移先のview.didload()に間に合わない */
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
       
        // 渡す値を格納
        tmp_Event = [EventList[indexPath.row]]
 
    
    }
    
    /*  遷移内容をチェックして、値渡しとかする */
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "test" { //Detailに遷移する場合(Segueのid)
            // Detailをインスタンス化
            let secondVc = segue.destination as! Event_Detail
            // 値を渡す
            secondVc.EventList = tmp_Event
            
        }else {
            // どちらでもない遷移
        }
    }
    
    
}
