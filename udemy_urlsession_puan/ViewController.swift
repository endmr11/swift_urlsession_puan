//
//  ViewController.swift
//  udemy_urlsession_puan
//
//  Created by Eren Demir on 14.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var notTableView: UITableView!
    var notlarListesi = [Not]()
    override func viewDidLoad() {
        super.viewDidLoad()
        notTableView.delegate = self
        notTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        tumNotlar()

    }
    
    func ortalamaHesapla() {
        var toplam = 0
        print(">>> 1")
        for n in notlarListesi {
            toplam = toplam + (Int(n.not1!)! + Int(n.not2!)!)/2
        }
        print(">>> 2")
        if notlarListesi.count != 0 {
            navigationItem.prompt = "Ortalama: \(toplam/notlarListesi.count)"
            print(">>> 3")
        }else {
            navigationItem.prompt = "Ortalama: YOK"
            print(">>> 4")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            print("toDetay")
            if let index = sender as? Int{
                let gidilecekVC = segue.destination as! NotDetayViewController
                gidilecekVC.gelenNot = notlarListesi[index]
            }
        }
    }
    
    
    func tumNotlar() {
        let url = URL(string: "http://kasimadalan.pe.hu/notlar/tum_notlar.php")!
        URLSession.shared.dataTask(with: url){
            (data,response,error) in
            if error != nil  || data == nil {
                print("Hata: \(error!)")
                return
            }
            do{
                let res = try JSONDecoder().decode(Notlar.self, from: data!)
                if let notlar = res.notlar {
                    self.notlarListesi = notlar
                }
                DispatchQueue.main.async {
                    self.notTableView.reloadData()
                    self.ortalamaHesapla()
                }
            } catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notlarListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let not = notlarListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "notHucre", for: indexPath) as! NotHucreTableViewCell
        cell.dersLabel.text = not.ders_adi
        cell.vizeLabel.text = "\(not.not1!)"
        cell.finalLabel.text = "\(not.not2!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}
