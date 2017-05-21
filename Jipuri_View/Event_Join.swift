//
//  Event_Join.swift
//  Jipuri_View
//
//  Created by 横山　新 on 2017/05/19.
//  Copyright © 2017年 横山　新. All rights reserved.
//

import UIKit
import NCMB

class Event_Join: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    var objectId = ""
    
    // 名前のField
    @IBOutlet weak var Name_Field: UITextField!
    
    // 年齢用のField
    @IBOutlet weak var Age_Field: UITextField!
    
    // TELL用のField
    @IBOutlet weak var Tell_Field: UITextField!
    
    // 住所用のField
    @IBOutlet weak var Adress_Field: UITextField!
    
    // 性別を入力するようのField
    @IBOutlet weak var Gender_Field: UITextField!
    let Gender_List = ["未設定","男性","女性"]
    
    // 性別用のpicker
    var pickerView: UIPickerView = UIPickerView()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        /* pickerの初期設定 */
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar_Gender = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem_Gender = UIBarButtonItem(title: "次へ", style: .plain, target: self, action: #selector(Event_Join.done_Gender))
        let cancelItem_Gender = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(Event_Join.cancel_Gender))
        toolbar_Gender.setItems([cancelItem_Gender, doneItem_Gender], animated: true)
        
        self.Gender_Field.inputView = pickerView
        self.Gender_Field.inputAccessoryView = toolbar_Gender
        self.Gender_Field.text = Gender_List[0]
        
        /* pickerの初期設定 */
        
        Name_Field.delegate = self
        
        
        /*  Age_Fieldの初期設定 */
        Age_Field.delegate = self
        let toolbar_Age = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem_Age = UIBarButtonItem(title: "次へ", style: .plain, target: self, action: #selector(Event_Join.done_Age))
        let cancelItem_Age = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(Event_Join.cancel_Age))
        toolbar_Age.setItems([cancelItem_Age, doneItem_Age], animated: true)
        Age_Field.inputAccessoryView = toolbar_Age
        
        
        /*  Tell_Fieldの初期設定 */
        Tell_Field.delegate = self
        let toolbar_Tell = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem_Tell = UIBarButtonItem(title: "次へ", style: .plain, target: self, action: #selector(Event_Join.done_Tell))
        let cancelItem_Tell = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(Event_Join.cancel_Tell))
        toolbar_Tell.setItems([cancelItem_Tell, doneItem_Tell], animated: true)
        Tell_Field.inputAccessoryView = toolbar_Tell
        
        
        Adress_Field.delegate = self
        
        
        // キーボードを開く際に呼び出す通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // キーボードを閉じる際に呼び出す通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    
    @IBAction func tapScreen(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // キーボード表示時
    func keyboardShow() {
        // キーボードを開く際に画面を上に170ずらす
        self.view.bounds = CGRectMake(0,170, self.view.frame.size.width, self.view.frame.size.height)
    }
    
    // キーボード非表示時
    func keyboardHide() {
        // キーボードを閉じる際に画面を元に戻す
        self.view.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    }
    
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    /* picker用の関数 */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender_List.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Gender_List[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.Gender_Field.text = Gender_List[row]
    }
    
    /* picker用の関数 */
    
    
    /* Gender用のdone,cancel */
    
    func cancel_Gender() {
        self.Gender_Field.text = ""
        self.Gender_Field.endEditing(true)
    }
    
    func done_Gender() {
        //self.Gender_Field.endEditing(true)
        Age_Field.becomeFirstResponder()
        
    }
    
    /* Age用のdone,cancel */
    
    func cancel_Age() {
        Age_Field.text = ""
        Age_Field.endEditing(true)
    }
    
    func done_Age() {
        //Age_Field.endEditing(true)
        Tell_Field.becomeFirstResponder()
        
    }
    
    /* Tell用のdone,cancel */
    
    func cancel_Tell() {
        Tell_Field.text = ""
        Tell_Field.endEditing(true)
    }
    
    func done_Tell() {
        //Tell_Field.endEditing(true)
        Adress_Field.becomeFirstResponder()
        
    }
    
    /* Returnボタンが押されたら */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        switch textField.tag {
        case 0:
            Gender_Field.becomeFirstResponder()
            break
        case 4:
            Adress_Field.endEditing(true)
            break
        default:
            break
        }
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /* 申し込み時間を取得する */
    
    func getNowClockString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm"
        let now = Date()
        return formatter.string(from: now)
    }
    
    /* 未入力の項目を探す */
    
    func isValidated() -> Bool{
        var Validated_List = ""
        
        if Name_Field.text == ""{
            Validated_List += "氏名は必須項目です\n"
            Name_Field.backgroundColor = UIColor.lightGray
        }else {
            Name_Field.backgroundColor = UIColor.white
        }
        
        if self.Gender_Field.text == "未設定"{
            Validated_List += "性別は必須項目です\n"
        }
        
        if Age_Field.text == ""{
            Validated_List += "年齢は必須項目です\n"
            Age_Field.backgroundColor = UIColor.lightGray
        }else {
            Age_Field.backgroundColor = UIColor.white
        }
        
        if Tell_Field.text == ""{
            Validated_List += "電話番号は必須項目です\n"
            Tell_Field.backgroundColor = UIColor.lightGray
        }else {
            Tell_Field.backgroundColor = UIColor.white
        }
        
        if Adress_Field.text == ""{
            Validated_List += "住所は必須項目です\n"
            Adress_Field.backgroundColor = UIColor.lightGray
        }else {
            Adress_Field.backgroundColor = UIColor.white
        }
        
        if Validated_List != "" {
        
            //        ① コントローラーの実装
            let alertController = UIAlertController(title: "未入力の項目があります",message: Validated_List , preferredStyle: UIAlertControllerStyle.alert)
            
            //        ②-1 OKボタンの実装
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
                //        ②-2 OKがクリックされた時の処理
            }
            
            //        ③-1 ボタンに追加
            alertController.addAction(okAction)
            
            //        ④ アラートの表示
            present(alertController,animated: true,completion: nil)
            
            return false
        }
        
        return true
    }
    
    /* 申し込みが成功したら */
    
    func Join_Result(){
        //        ① コントローラーの実装
        let alertController = UIAlertController(title: "申し込み完了",message: Name_Field.text! + "さんの申し込みを受け付けました" , preferredStyle: UIAlertControllerStyle.alert)
        
        //        ②-1 OKボタンの実装
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            //        ②-2 OKがクリックされた時の処理
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        //        ③-1 ボタンに追加
        alertController.addAction(okAction)
        
        //        ④ アラートの表示
        present(alertController,animated: true,completion: nil)
    }
    
    
    /* 申込内容をNCMBへ */
    
    func NCMB_Join(){
        // クラスのNCMBObjectを作成
        let obj = NCMBObject(className: "Participants")
        // オブジェクトに値を設定
        /** 文字列 **/
        obj?.setObject(Name_Field.text!, forKey: "name")
        /** 文字列 **/
        obj?.setObject(self.Gender_Field.text!, forKey: "sex")
        /** 文字列 **/
        obj?.setObject(Age_Field.text!, forKey: "age")
        /** 文字列 **/
        obj?.setObject(Tell_Field.text!, forKey: "tell")
        /** 文字列 **/
        obj?.setObject(Adress_Field.text!, forKey: "address")
        /** 文字列 **/
        obj?.setObject(objectId, forKey: "eventID")
        /** 文字列 **/
        obj?.setObject(getNowClockString(), forKey: "join_time")
        
        // データストアへの保存を実施
        obj?.saveInBackground({ (error) in
            if error != nil {
                // 保存に失敗した場合の処理
            }else{
                // 保存に成功した場合の処理
                self.Join_Result()
            }
        })
    }
    
    /* 申し込み内容の確認 */
    
    func Join_Confim(){
        
        let tmp =
            "氏名： " + Name_Field.text! + "\n"
                + "性別： " + self.Gender_Field.text! + "\n"
                + "年齢： " + Age_Field.text! + "\n"
                + "電話番号： " + Tell_Field.text! + "\n"
                + "住所： " + Adress_Field.text! + "\n"
                + "以上の内容でお間違いないですか？"
        
        
        
        //        ① コントローラーの実装
        let alertController = UIAlertController(title: "内容の確認",message: tmp, preferredStyle: UIAlertControllerStyle.alert)
        
        //        ②-1 OKボタンの実装
        let okAction = UIAlertAction(title: "はい", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            //        ②-2 OKがクリックされた時の処理
            self.NCMB_Join()
        }
        //        CANCELボタンの実装
        let cancelButton = UIAlertAction(title: "いいえ", style: UIAlertActionStyle.cancel, handler: nil)
        
        //        ③-1 ボタンに追加
        alertController.addAction(okAction)
        //        ③-2 CANCELボタンの追加
        alertController.addAction(cancelButton)
        
        //        ④ アラートの表示
        present(alertController,animated: true,completion: nil)
        
    }
    
    /* 申し込みと同時にイベントリストへ戻る */
    
    @IBAction func Join(_ sender: Any) {
        
        if (isValidated()){
            self.Join_Confim()
        }
    }
    
}
