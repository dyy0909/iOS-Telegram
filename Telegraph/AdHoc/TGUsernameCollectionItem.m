#import "TGUsernameCollectionItem.h"

#import "TGUsernameCollectionItemView.h"

@implementation TGUsernameCollectionItem

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        self.highlightable = false;
        self.selectable = false;
        
        _title = TGLocalized(@"Settings.Username");
        _placeholder = TGLocalized(@"Username.Placeholder");
        _keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}

- (Class)itemViewClass
{
    return [TGUsernameCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, 44.0f);
}

- (void)bindView:(TGUsernameCollectionItemView *)view
{
    [super bindView:view];
    
    [view setTitle:_title];
    [view setPrefix:_prefix];
    [view setPlaceholder:_placeholder];
    [view setSecureEntry:_secureEntry];
    [view setKeyboardType:_keyboardType];
    [view setUsername:_username];
    [view setUsernameValid:_usernameValid];
    
    __weak TGUsernameCollectionItem *weakSelf = self;
    view.usernameChanged = ^(NSString *username)
    {
        __strong TGUsernameCollectionItem *strongSelf = weakSelf;
        strongSelf.username = username;
        
        if (strongSelf.usernameChanged)
            strongSelf.usernameChanged(username);
    };
}

- (void)unbindView
{
    ((TGUsernameCollectionItemView *)self.boundView).usernameChanged = nil;
    
    [super unbindView];
}

- (void)setUsernameValid:(bool)usernameValid
{
    _usernameValid = usernameValid;
    [((TGUsernameCollectionItemView *)self.boundView) setUsernameValid:_usernameValid];
}

- (void)setUsernameChecking:(bool)usernameChecking
{
    _usernameChecking = usernameChecking;
    [((TGUsernameCollectionItemView *)self.boundView) setUsernameChecking:_usernameChecking];
}

- (void)becomeFirstResponder
{
    [((TGUsernameCollectionItemView *)self.boundView) becomeFirstResponder];
}

@end
