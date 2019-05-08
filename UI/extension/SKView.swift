//
//  SKView.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//
import SpriteKit

public extension SKView {
    func presentSceneTo(to scene: SKScene) {
        if (self.scene == nil) {
            presentScene(scene)
            
            return
        }
        
        change(scene)
    }
    
    func saveToPhoto() {
        UIImageWriteToSavedPhotosAlbum(image()!, nil, nil, nil);
    }
    
    func image() -> UIImage? {
        return SKView.image(view:self, subview:nil);
    }
    
    func image(withSubview:UIView) -> UIImage? {
        return SKView.image(view: self, subview: withSubview);
    }
    
    private func change(_ scene: SKScene) {
        let color:UIColor = .black;
        let sec:TimeInterval = 0.5;
        
        let imageView = UIView(frame: CGRect(x: 0, y: 0, width: layer.bounds.size.width, height: layer.bounds.size.height));
        
        imageView.backgroundColor = color;
        
        imageView.alpha = 0;
        
        // *********** fadeIn/fadeOut ***********
        UIView.animate(withDuration: sec, animations: { imageView.alpha = 1 },
                       completion: {(finished:Bool) in
                        
                            self.presentScene(nil);
                            self.presentScene(scene);

                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                                    UIView.animate(withDuration: sec, animations: { imageView.alpha = 0 }, completion: {(finished:Bool) in
                                            self.willRemoveSubview(imageView)})
                            }
        });
        
        superview?.addSubview(imageView);
    }
    
    class func image(view:UIView, subview:UIView?) -> UIImage? {
        var image:UIImage;
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0);
        
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true);
        
        image = UIGraphicsGetImageFromCurrentImageContext()!;
        
        UIGraphicsEndImageContext();
        
        if subview != nil {
            var rect = subview!.frame;
            
            rect.size.height *= image.scale;
            rect.size.width *= image.scale;
            
            let imageRef = image.cgImage!.cropping(to: rect);
            
            image = UIImage(cgImage: imageRef!, scale: image.scale, orientation: image.imageOrientation);
        }
        
        return image;
    }
}
