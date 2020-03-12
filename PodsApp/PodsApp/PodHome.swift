//
//  PodHome.swift
//  PodsApp
//
//

import UIKit

class PodHome: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView! //conatined tableView
    var selectedRow: Int?
    var pods : [Pod] = [] //user associated pods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "podCell")
        cell.textLabel?.text = pods[indexPath.row].name
        cell.imageView?.image = UIImage(named: pods[indexPath.row].image)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    @IBAction func unwindToPodHome(segue: UIStoryboardSegue) {
    }
    @IBAction func createPod(segue: UIStoryboardSegue) {
        let addPodController = segue.source as! PodCreate
        self.pods.append(addPodController.newPod!)
        tableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            let destVC = segue.destination as! PodDetails
            let selectedIndexPath = tableView.indexPathForSelectedRow
            destVC.dataFromTable = pods[(selectedIndexPath?.row)!]
            self.selectedRow = tableView.indexPathForSelectedRow!.row
        }

    }

}
