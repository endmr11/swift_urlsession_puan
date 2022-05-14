//
//  NotDetayViewController.swift
//  udemy_urlsession_puan
//
//  Created by Eren Demir on 14.05.2022.
//

import UIKit

class NotDetayViewController: UIViewController {
    
    @IBOutlet weak var dersTextfield: UITextField!
    @IBOutlet weak var vizeTextfield: UITextField!
    @IBOutlet weak var finalTextfield: UITextField!
    
    var gelenNot:Not?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let n = gelenNot {
            dersTextfield.text = n.ders_adi
            vizeTextfield.text = "\(n.not1!)"
            finalTextfield.text = "\(n.not2!)"
        }
    }
    

    @IBAction func btnGuncelle(_ sender: Any) {
        
        if let n = gelenNot, let ad = dersTextfield.text, let not1 = vizeTextfield.text, let not2 = finalTextfield.text {
            if let nid = n.not_id, let n1 = Int(not1), let n2 = Int(not2) {
                notGuncelle(not_id: nid, ders_adi: ad, not1: n1, not2: n2)
            }
        }
    }
    
    @IBAction func btnSil(_ sender: Any) {
        if let n = gelenNot {
            if let nid = n.not_id {
                notSil(not_id: nid)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func notGuncelle(not_id:String,ders_adi:String,not1:Int,not2:Int) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/update_not.php")!)
        request.httpMethod = "POST"
        let postString = "not_id=\(not_id)&ders_adi=\(ders_adi)&not1=\(not1)&not2=\(not2)"
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
    
    func notSil(not_id:String) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/delete_not.php")!)
                request.httpMethod = "POST"
                let postString = "not_id=\(not_id)"
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
