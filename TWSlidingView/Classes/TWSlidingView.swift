//
//  TWSlidingViewController.swift
//  TWSlidingViewController
//
//  Created by magicmon on 2016. 5. 19..
//  Copyright © 2016 magicmon. All rights reserved.
//

import UIKit

public enum TWSlidingType {
    case Normal
    case ZoomOut
    case Depth
}

public class TWSlidingView: UIView, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var viewList: [UIView] = []
    var beginOffsetX: CGFloat = 0.0
    var currentPage: Int = 0
    
    public var zoomScale: CGFloat = 0.9
    public var slidingAlpha: CGFloat = 0.6
    public var slidingType: TWSlidingType = .Normal
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    func commonInit() {
        scrollView = UIScrollView(frame: CGRectMake(0, 0, frame.width, frame.height))
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.directionalLockEnabled = true
        scrollView.backgroundColor = UIColor.blackColor()
        
        self.addSubview(scrollView)
    }
    
    public func addChildView(childView: UIView) {
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        childView.frame = CGRectMake(width * CGFloat(self.viewList.count), childView.frame.origin.y, childView.bounds.width, childView.bounds.height)
        self.scrollView.addSubview(childView)
        
        self.viewList.append(childView)
        
        self.scrollView.contentSize = CGSizeMake(width * CGFloat(self.viewList.count), height)
    }
    
    //MARK: - UIScrollViewDelegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.size.width
        let offsetX = scrollView.contentOffset.x
        
        var destView: UIView?
        
        
        switch self.slidingType {
        case .ZoomOut:
            
            let progress = min(1, fabs( (offsetX - self.beginOffsetX) / pageWidth))
            let nextPage = self.scrollView.contentOffset.x > self.beginOffsetX ? self.currentPage + 1 : self.currentPage - 1
            
            let sourceView = self.viewList[self.currentPage]
            
            if nextPage >= 0 {
                destView = self.viewList[nextPage]
            }
            
            updateZoomOutView(sourceView, destView: destView, progress: progress)
            break
        case .Depth:
            
            let progress = (offsetX - self.beginOffsetX) / pageWidth
            
            if progress > 0 {
                
                if self.currentPage - 1 >= 0 {
                    for index in 0...self.currentPage - 1 {
                        let prevView = self.viewList[index]
                        let movePrevX = (pageWidth - prevView.frame.size.width) + CGFloat(self.currentPage) * self.bounds.width
                        prevView.frame = CGRectMake(self.beginOffsetX + movePrevX, prevView.frame.origin.y, prevView.frame.size.width, prevView.frame.size.height)
                    }
                }
                
                destView = self.viewList[self.currentPage]
                if let destView = destView {
                    let moveX = (pageWidth - destView.frame.size.width) + (offsetX - self.beginOffsetX)
                    destView.frame = CGRectMake(self.beginOffsetX + moveX, destView.frame.origin.y, destView.frame.size.width, destView.frame.size.height)
                }
            }
            else if progress < 0 && self.currentPage - 1 >= 0 {
                destView = self.viewList[self.currentPage - 1]
                
                if let destView = destView {
                    let moveX = (pageWidth - destView.frame.size.width) + offsetX
                    destView.frame = CGRectMake(moveX, destView.frame.origin.y, destView.frame.size.width, destView.frame.size.height)
                }
            }
            
            updateDepthView(destView, progress: progress)
            break
        default:
            break
        }
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.currentPage = calculateCurrentPage()
        self.beginOffsetX = scrollView.bounds.width * CGFloat(self.currentPage)
    }
    
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        stoppedScrolling()
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            stoppedScrolling()
        }
    }
    
    func stoppedScrolling() {
        
        self.currentPage = calculateCurrentPage()
        
        switch self.slidingType {
        case .ZoomOut:
            let destView = self.viewList[self.currentPage]
            updateZoomOutView(nil, destView: destView, progress: 1)
            break
        case .Depth:
            
            self.beginOffsetX = scrollView.bounds.width * CGFloat(self.currentPage)
            
            let width = self.bounds.width
            let height = self.bounds.height
            
            for (index, sourceView) in self.viewList.enumerate() {
                let offsetX = width * CGFloat(index)
                
                if sourceView.frame.size.height != height {
                    sourceView.center = CGPointMake(offsetX + (sourceView.frame.size.width / 2), height / 2)
                }
            }
            break
        default:
            break
        }
    }
    
    
    //MARK: - Helper
    func scrollToPage(page: Int, animated: Bool) {
        let pageWidth = self.bounds.width
        let offset = CGPointMake(pageWidth * CGFloat(page), 0)
        
        self.scrollView.setContentOffset(offset, animated: animated)
    }
    
    func calculateCurrentPage() -> Int {
        let pageWidth = self.bounds.width
        return Int((self.scrollView.contentOffset.x + (pageWidth / 2)) / pageWidth)
    }
    
    private func updateZoomOutView(sourceView: UIView?, destView: UIView?, progress: CGFloat) {
        
        if let sourceView = sourceView {
            let sourceZoom = 1 - (1 - zoomScale) * progress
            sourceView.transform = CGAffineTransformMakeScale(sourceZoom, sourceZoom)
            sourceView.alpha = 1 - progress * (1 - slidingAlpha)
        }
        
        if let destView = destView {
            let destZoom = zoomScale + (1 - zoomScale) * progress
            destView.transform = CGAffineTransformMakeScale(destZoom, destZoom)
            destView.alpha = slidingAlpha + (1 - slidingAlpha) * progress
        }
    }
    
    private func updateDepthView(destView: UIView?, progress: CGFloat) {
        
        var destViewZoom: CGFloat = 1.0
        var destViewAlpha: CGFloat = 1.0
        
        if progress < 0 {
            destViewZoom = zoomScale - (1 - zoomScale) * progress
            destViewAlpha = slidingAlpha - (1 - slidingAlpha) * progress
        } else if progress > 0 {
            destViewZoom = 1 - (1 - zoomScale) * progress
            destViewAlpha = 1 - (1 - slidingAlpha) * progress
        }
        
        destView?.alpha = destViewAlpha
        destView?.transform = CGAffineTransformMakeScale(destViewZoom, destViewZoom)
    }
}