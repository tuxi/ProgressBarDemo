//
//  ViewController.swift
//  ProgressBarDemo
//
//  Created by alpface on 15/08/2017.
//  Copyright © 2017 alpface. All rights reserved.
//

import UIKit

class ExampleItem: NSObject {
    var title: String?
    var exampleClass: AnyClass?
    
    convenience init(exampleClass: AnyClass, title: String) {
        self.init()
        self.exampleClass = exampleClass
        self.title = title
    }
}

class ViewController: UITableViewController {
    
    internal var items: [ExampleItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = ExampleItem(exampleClass: ExampleProgressViewController.classForCoder(), title: "progress")
        self.items.append(item1)
        
        let item2 = ExampleItem(exampleClass: ExampleLoadingViewController.classForCoder(), title: "loading")
        self.items.append(item2)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let example = self.items[indexPath.row]
        cell?.textLabel?.text = example.title
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let example = self.items[indexPath.row]
        if let exampleClass = example.exampleClass, let title = example.title {
            // 动态获取命名空间,开发中应该充分利用guard语句，guard可以有效的解决可选绑定容易形成{}嵌套问题
//            guard   let name = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
//                return
//            }
            // 根据字符串获取Class
//            let controllerName = NSStringFromClass(exampleClass)
//            let cls: AnyClass? = NSClassFromString(name + "." + controllerName)
            
            // Swift中如果想通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型，这里注意：所有的视图控制器都是继承于UIViewController
            guard let typeClass = exampleClass as? UIViewController.Type else {
                return
            }
            // 通过Class创建对象
            let childController = typeClass.init()
            
            // 设置控制器相关属性
            childController.title = title
            self.navigationController?.pushViewController(childController, animated: true)
        }
    }
    
}

