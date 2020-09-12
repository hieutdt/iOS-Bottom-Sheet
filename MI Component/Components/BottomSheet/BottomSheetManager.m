//
//  BottomSheetManager.m
//  MI Component
//
//  Created by HieuTDT on 9/7/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import "BottomSheetManager.h"
#import "BottomSheet.h"
#import "UIView+Additions.h"

#define KEYWINDOW UIWindow *window = [UIView keyWindow];
#define SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height

#define kMinimumTopConstraint 50

typedef NS_ENUM(NSInteger, BottomSheetState) {
    BottomSheetExpanded,
    BottomSheetNormal,
    BottomSheetHidden
};

@interface BottomSheetManager()

@property (nonatomic, strong) BottomSheet *bottomSheet;
@property (nonatomic, strong) UIView *dimView;
@property (nonatomic, strong) NSLayoutConstraint *bottomSheetTopConstraint;

@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, assign) UIViewController *currentViewController;
@property (nonatomic, assign) BottomSheetState state;
@property (nonatomic, assign) CGFloat cardPanStartingTopConstant;

@end

@implementation BottomSheetManager

+ (BottomSheetManager *)instance {
    static BottomSheetManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BottomSheetManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _state = BottomSheetHidden;
        
        _bottomSheet = [[BottomSheet alloc] init];
        _dimView = [[UIView alloc] init];
        
        _dimView.backgroundColor = UIColor.blackColor;
        _bottomSheet.backgroundColor = UIColor.whiteColor;
        
        /// Add Pan gesture recognizer
        UIPanGestureRecognizer *viewPan = [[UIPanGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(viewPanned:)];
        viewPan.delaysTouchesBegan = NO;
        viewPan.delaysTouchesEnded = NO;
        [_bottomSheet addGestureRecognizer:viewPan];
        
        /// Layouts
        [self _addDimLayerToWindow];
        [self _addBottomSheetToWindow];
        
        /// Add tap gesture to dim layer
        UITapGestureRecognizer *dimmerTap = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(hideVisibleBottomSheet)];
        [_dimView addGestureRecognizer:dimmerTap];
        
        /// Hide them
        _bottomSheet.hidden = YES;
        _dimView.hidden = YES;
    }
    return self;
}

#pragma mark - Public methods

- (void)showBottomSheetWithContent:(UIView *)contentView {
    /// Default contentViewHeight is 1/2 screen height
    /// and default case is can not expanded
    [self showBottomSheetWithContent:contentView
                              height:SCREEN_HEIGHT/2
                         canExpanded:NO];
}

- (void)showBottomSheetWithContent:(UIView *)contentView
                            height:(CGFloat)contentHeight
                       canExpanded:(BOOL)canExpanded {
    
    KEYWINDOW
    
    /// Set content view for bottom sheet
    contentView.backgroundColor = [UIColor whiteColor];
    [_bottomSheet setContentView:contentView];
    [_bottomSheet setCanExpanded:canExpanded];
    _contentViewHeight = contentHeight;
    
    /// Visible bottom sheet and dim layer
    _bottomSheet.hidden = NO;
    _dimView.hidden = NO;
    _dimView.alpha = 0;
    
    /// Update bottomm sheet's top constraint and relayout this
    _bottomSheetTopConstraint.constant = SCREEN_HEIGHT - contentHeight;
    [window layoutSubviews];
    
    /// Animate show bottom sheet and dim layer
    _bottomSheet.transform = CGAffineTransformTranslate(_bottomSheet.transform, 0, contentHeight + 100);
    [UIView animateWithDuration:0.2 animations:^{
        self.dimView.alpha = 0.6;
        self.bottomSheet.transform = CGAffineTransformIdentity;
    }];
}

- (void)hideVisibleBottomSheet {
    KEYWINDOW
    self.bottomSheetTopConstraint.constant = 1000;
    
    [UIView animateWithDuration:0.2 animations:^{
        [window layoutIfNeeded];
        self.dimView.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.bottomSheet.hidden = YES;
        self.dimView.hidden = YES;
        self.bottomSheet.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - Add and constraint subviews

- (void)_addDimLayerToWindow {
    KEYWINDOW
    [window addSubview:self.dimView];
    
    self.dimView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dimView.topAnchor constraintEqualToAnchor:window.topAnchor].active = YES;
    [self.dimView.bottomAnchor constraintEqualToAnchor:window.bottomAnchor].active = YES;
    [self.dimView.leadingAnchor constraintEqualToAnchor:window.leadingAnchor].active = YES;
    [self.dimView.trailingAnchor constraintEqualToAnchor:window.trailingAnchor].active = YES;
}

- (void)_addBottomSheetToWindow {
    KEYWINDOW
    [window addSubview:self.bottomSheet];
    
    self.bottomSheet.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bottomSheet.leadingAnchor constraintEqualToAnchor:window.leadingAnchor].active = YES;
    [self.bottomSheet.trailingAnchor constraintEqualToAnchor:window.trailingAnchor].active = YES;
    [self.bottomSheet.bottomAnchor constraintEqualToAnchor:window.bottomAnchor].active = YES;
    self.bottomSheetTopConstraint = [self.bottomSheet.topAnchor constraintEqualToAnchor:window.topAnchor];
    self.bottomSheetTopConstraint.constant = 1000;
    self.bottomSheetTopConstraint.active = YES;
}

#pragma mark - PanGesture handle

- (void)viewPanned:(UIPanGestureRecognizer *)panGesture {
    /// How much has user dragged
    CGPoint translation = [panGesture translationInView:self.bottomSheet];
    
    /// How fast has user dragged
    CGPoint velocity = [panGesture velocityInView:self.bottomSheet];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            _cardPanStartingTopConstant = _bottomSheetTopConstraint.constant;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if (self.cardPanStartingTopConstant + translation.y > kMinimumTopConstraint) {
                self.bottomSheetTopConstraint.constant = self.cardPanStartingTopConstant + translation.y;
            }
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            
            /// If user drag down with a very fast speed
            if (velocity.y > 1700) {
                [self hideVisibleBottomSheet];
                return;
            }
            
            if (self.bottomSheetTopConstraint.constant < SCREEN_HEIGHT * 0.25
                && self.bottomSheet.canExpanded) {
                /// Show bottom sheet at .Expanded state
                self.state = BottomSheetExpanded;
                
            } else if (self.bottomSheetTopConstraint.constant < SCREEN_HEIGHT - 100) {
                /// Show bottom sheet at .Normal state
                self.state = BottomSheetNormal;
                
            } else {
                /// Hide the bottom sheet
                self.state = BottomSheetHidden;
            }
            
            [self _showBottomSheetWithState:self.state];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - ShowBottomSheetWithState

- (void)_showBottomSheetWithState:(BottomSheetState)state {
    
    /// Ensure there's no pending layout changes before animation runs
    KEYWINDOW
    [window layoutIfNeeded];
    
    switch (state) {
        case BottomSheetExpanded:
            self.bottomSheetTopConstraint.constant = kMinimumTopConstraint;
            break;
        
        case BottomSheetNormal:
            self.bottomSheetTopConstraint.constant = SCREEN_HEIGHT - self.contentViewHeight;
            break;
        
        case BottomSheetHidden:
            self.bottomSheetTopConstraint.constant = 1000;
            /// Hide and return
            [self hideVisibleBottomSheet];
            return;
            
        default:
            break;
    }
    
    /// Animate update bottom sheet
    [UIView animateWithDuration:0.2 animations:^{
        [window layoutIfNeeded];
        self.dimView.alpha = 0.7;
    }];
}

@end
