//
//  NotEkleViewController.swift
//  udemy_urlsession_puan
//
//  Created by Eren Demir on 14.05.2022.
//

import UIKit

class NotEkleViewController: UIViewController {
    
    @IBOutlet weak var dersTextfield: UITextField!
    @IBOutlet weak var vizeTextfield: UITextField!
    @IBOutlet weak var finalTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnEkle(_ sender: Any) {
        if let d = dersTextfield.text, let v = vizeTextfield.text, let f = finalTextfield.text {
            if let n1 = Int(v), let n2 = Int(f) {
                notEkle(ders_adi: d, not1: n1, not2: n2)
                navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    func notEkle(ders_adi:String,not1:Int,not2:Int) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/insert_not.php")!)
        request.httpMethod = "POST"
        let postString = "ders_adi=\(ders_adi)&not1=\(not1)&not2=\(not2)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request){
            (data,response,error) in
            if error != nil  || data == nil {
                print("Hata: \(error!)")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!,options: []) as? [String:Any] {
                    print(json)
                }
            } catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}
