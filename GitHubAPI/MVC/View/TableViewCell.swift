//
//  TableViewCell.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with repository: [Repository], indexPath: IndexPath) {
        let repoRow = repository[indexPath.row]
        name.text = repoRow.name
        fullName.text = repoRow.fullName
    }
}
