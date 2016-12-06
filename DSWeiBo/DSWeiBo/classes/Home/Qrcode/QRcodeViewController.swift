//
//  QRcodeViewController.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/30.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation


class QRcodeViewController: UIViewController,UITabBarDelegate {
    ///关闭按钮
    @IBOutlet weak var closeBtn: UIBarButtonItem!
    ///相册按钮
    @IBOutlet weak var photoAlbum: UIBarButtonItem!
    ///tabBar
    @IBOutlet weak var customTabbar: UITabBar!
    ///冲击波View
    @IBOutlet weak var sacnLineView: UIImageView!
    ///容器高度
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    ///冲击波顶部约束
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    
    
    //MARK: - 懒加载
    ///会话对象 (负责输入和输出设置之间的数据传递)
    private lazy var  session : AVCaptureSession = AVCaptureSession()
    
    ///输入设备 (摄像头)
    private lazy var deviceInput : AVCaptureInput? = {
        //获取摄像头 (默认设置后置摄像头)
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            //创建输入对象
            let input = try AVCaptureDeviceInput.init(device: device)
            return input
        }catch{
            print(error)
            return nil
        }
    }()
    ///输入对象
    private lazy var deviceOutPut : AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    ///预览图层
    lazy var previewLayer : AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer.init(session: self.session) // 闭包要访问外界数据  要self
        layer?.frame = UIScreen.main.bounds
        return layer!
    }()
    
    ///绿框图层
    lazy var drawlayer : CALayer = {
        let lay = CALayer()
        lay.frame =  UIScreen.main.bounds
        return lay
    }()
    
    
    
    //点击关闭
    @IBAction func closeClick(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    //点击相册
    @IBAction func photoAlbumClick(_ sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabbar.delegate = self
        //1.设置默认item选项
        customTabbar.selectedItem = customTabbar.items![0]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //1.设置以及执行动画(利用约束)
        animationScanLainView()      //一定要在ViewDidAppear中调用
        //2. 开始扫描
        startScan()
    }
    
    private func animationScanLainView(){
        // 1.重新设置冲击波顶部约束
        // 一定要加上这一句, 否则会混乱
        self.scanLineCons.constant = -self.contentViewHeight.constant
        view.layoutIfNeeded()
        //2 执行动画
        UIView.animate(withDuration: 2.0, animations: {
            //2.1 重置约束
            self.scanLineCons.constant = self.contentViewHeight.constant
            //2.2 指定动画重复次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            //2.3 冲击波强制更新界面
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func startScan(){
        //1.判断能否将输入添加到会话中
        if !session.canAddInput(deviceInput) {
            return
        }
        //2.判断能否将输出添加到会话中
        if !session.canAddOutput(deviceOutPut) {
            return
        }
        //3.添加到会话中
        session.addInput(deviceInput)
        session.addOutput(deviceOutPut)
        //4.设置输出能够解析的数据类型 (一定要在输出对象添加到会话之后才能设置,否则Bug)
        deviceOutPut.metadataObjectTypes = deviceOutPut.availableMetadataObjectTypes  //设置系统所有的数据类型都能解析
        //5.设置输出对象的代理 (只要解析成功就会通知代理)
        deviceOutPut.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        //添加预览图层到底层
        view.layer.insertSublayer(previewLayer, at: 0)
        //添加绿框到预览图层
        previewLayer.addSublayer(drawlayer)
        //6.告诉session会话,开始扫描
        session.startRunning()
    }

    //MARK: - UITabBarDelegate 代理
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1{
            self.contentViewHeight.constant = 300
            self.sacnLineView.layer.removeAllAnimations()
            animationScanLainView()
        }else{
            //1 修改容器的高度
             self.contentViewHeight.constant = 150
            //2 停止动画
            self.sacnLineView.layer.removeAllAnimations()
            // 3.重新开始动画
            animationScanLainView()
        }
    }
}

extension QRcodeViewController:AVCaptureMetadataOutputObjectsDelegate{
    ///输出处理代理方法
    //只要解析到数据,就会调用
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        //0. 先清除layer
        clearCorners()
        //1获取扫描到的数据
        guard let obj = metadataObjects.last as? AVMetadataMachineReadableCodeObject
            else{
                return
        }
        //2 获取二维码位置
        //2.1 转换corners 坐标
        let objCorners = previewLayer.transformedMetadataObject(for: obj)
        //2.2 绘制图形绿框
        drawCorners(objCorners: objCorners as! AVMetadataMachineReadableCodeObject)
    }
    
    
    /// 绘制绿色框(Bethel曲线)
    ///
    /// - parameter objCorners: 保存了坐标的 AVMetadataMachineReadableCodeObject 对象
    private func drawCorners(objCorners :AVMetadataMachineReadableCodeObject){
        if objCorners.corners.isEmpty{
            return
        }
        //1.新建layer
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        //2.创建贝塞尔路径
        let path = UIBezierPath()
        var point = CGPoint.zero
        var index : Int = 0
        //2.1从corners数组中开始取point坐标
        point = CGPoint.init(dictionaryRepresentation: objCorners.corners[0] as! CFDictionary)!
        //2.2 移动到起始点
        path.move(to: point)
        while index < objCorners.corners.count{
            point = CGPoint.init(dictionaryRepresentation: objCorners.corners[index] as! CFDictionary)!
            index += 1
            //2.3 点添加成路径线
            path.addLine(to: point)
        }
        //2.4 关闭路径
        path.close()
        //2.5 绘制路径
        layer.path = path.cgPath
        //3.将创建好的layer添加到drawLayer上去
        drawlayer.addSublayer(layer)
    }
    
    private func  clearCorners(){
        if drawlayer.sublayers?.count == 0 || drawlayer.sublayers == nil {
            return
        }
        //移除所有子图层
        for subLay in drawlayer.sublayers! {
            subLay.removeFromSuperlayer()
        }
    }
    
    
}
