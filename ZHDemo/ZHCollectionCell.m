//
//  ZHCollectionCell.m
//  ZHDemo
//
//  Created by Edward on 13-7-12.
//  Copyright (c) 2013年 ZhiHu. All rights reserved.
//

#import "ZHCollectionCell.h"
#import "ZHCollectionObject.h"
#import <QuartzCore/QuartzCore.h>

#define Default_Cell_Height											95

#define CellContent_Left_Margin									10
#define CellContent_Top_Margin									15

// Des
#define DesContent_To_Title_Margin							10
#define DesContent_To_Right_Margin							25
#define DesContent_To_Underline_Margin					15

// Bottom Content
#define BottomContent_To_Underline_Margin				15
#define BottomContent_Avatar_To_Name_Margin			10
#define BottomContent_Answer_Max_Width					70
#define BottomContent_Answer_To_Right_Margin	  10
#define BottomContent_To_Bottom								  10


#define DesLabelFont														[UIFont systemFontOfSize:15.0f]
#define DesLabelWidth														250


@interface ZHCollectionCell ()
{
	CGFloat answerLabelOriginX;
}

@property (nonatomic) UILabel *collectionCellTitleLabel;
@property (nonatomic) UILabel *collectionCellDesLabel;
@property (nonatomic) UIButton *collectionCellAvatarButton;
@property (nonatomic) UILabel *collectionCellNameLabel;
@property (nonatomic) UILabel *collectionCellAnswersLabel;

@end

@implementation ZHCollectionCell

@synthesize collectionCellTitleLabel = collectionCellTitleLabel_;
@synthesize collectionCellDesLabel = collectionCellDesLabel_;
@synthesize collectionCellAvatarButton = collectionCellAvatarButton_;
@synthesize collectionCellNameLabel = collectionCellNameLabel_;
@synthesize collectionCellAnswersLabel = collectionCellAnswersLabel_;

- (id)initWithStyle:(UITableViewCellStyle)style
		reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    
    if (!collectionCellTitleLabel_) {
      self.collectionCellTitleLabel = [[UILabel alloc] init];
      [collectionCellTitleLabel_ setFont:[UIFont boldSystemFontOfSize:15.0f]];
      [collectionCellTitleLabel_ setNumberOfLines:1];
      [collectionCellTitleLabel_ setLineBreakMode:NSLineBreakByTruncatingTail];
      [self.contentView addSubview:collectionCellTitleLabel_];
    }
    
    if (!collectionCellDesLabel_) {
      self.collectionCellDesLabel = [[UILabel alloc] init];
      [collectionCellDesLabel_ setFont:DesLabelFont];
      [collectionCellDesLabel_ setTextColor:[UIColor darkTextColor]];
      [collectionCellDesLabel_ setNumberOfLines:0];
      [collectionCellDesLabel_ setLineBreakMode:NSLineBreakByWordWrapping];
      [self.contentView addSubview:collectionCellDesLabel_];
    }
    
    if (!collectionCellAvatarButton_) {
      self.collectionCellAvatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [collectionCellAvatarButton_ setSize:CGSizeMake(20, 20)];
      [collectionCellAvatarButton_ setImage:[UIImage imageNamed:@"ZHDMViewInputBox.png"]
                                   forState:UIControlStateNormal];
      [collectionCellAvatarButton_.layer setCornerRadius:3.0f];
      [self.contentView addSubview:collectionCellAvatarButton_];
      
      // Add Button Event here...
      //[collectionCellAvatarButton_ addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!collectionCellNameLabel_) {
      self.collectionCellNameLabel = [[UILabel alloc] init];
      [collectionCellNameLabel_ setFont:[UIFont systemFontOfSize:13.0f]];
      [self.contentView addSubview:collectionCellNameLabel_];
    }
    
    if (!collectionCellAnswersLabel_) {
      self.collectionCellAnswersLabel = [[UILabel alloc] init];
      [collectionCellAnswersLabel_ setFont:[UIFont systemFontOfSize:11.0f]];
      [collectionCellAnswersLabel_ setTextColor:[UIColor grayColor]];
      [collectionCellAnswersLabel_ setTextAlignment:NSTextAlignmentRight];
      [self.contentView addSubview:collectionCellAnswersLabel_];
    }
    
    answerLabelOriginX = self.width - BottomContent_Answer_Max_Width - BottomContent_Answer_To_Right_Margin;
  }
  return self;
}


- (void)bindWithObject:(id)object
{
	ZHCollectionObject *collectionObject = (ZHCollectionObject *)object;
  NSString *title = collectionObject.title;
  NSString *description = collectionObject.des;
  NSString *name = collectionObject.name;
  NSString *avatar_url = collectionObject.avatar_url;
  NSString *answer_count = collectionObject.answer_count;
  
  [self.collectionCellTitleLabel setText:title];
  [self.collectionCellDesLabel setText:description];
  [self.collectionCellNameLabel setText:name];
  [self.collectionCellAnswersLabel setText:[NSString stringWithFormat:@"%@个问答",answer_count]];
  
  //GCD add here ...
  //UIImage *avatar_image = [UIImage imageWithContentsOfFile:avatar_url];
  //[self.collectionCellAvatarButton setImage:avatar_image forState:UIControlStateNormal];
  
  [self.collectionCellTitleLabel sizeToFit];
  [self.collectionCellDesLabel sizeToFit];
  [self.collectionCellNameLabel sizeToFit];
  [self.collectionCellAnswersLabel sizeToFit];
  
  [self layoutIfNeeded];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
  
  // Layout title label
  [self.collectionCellTitleLabel setOrigin:CGPointMake(CellContent_Left_Margin, CellContent_Top_Margin)];
  
  // Layout des label
	CGFloat desLabelOriginY = [collectionCellTitleLabel_ bottom] + DesContent_To_Title_Margin;
  [self.collectionCellDesLabel setOrigin:CGPointMake(CellContent_Left_Margin, desLabelOriginY)];
  [self.collectionCellDesLabel setSize:desTextSize(self.collectionCellDesLabel.text)];
  
  // Layout Bottom contents
  CGFloat bottomContentOriginY = [self.collectionCellDesLabel bottom] + DesContent_To_Underline_Margin + BottomContent_To_Underline_Margin;
  [self.collectionCellAvatarButton setOrigin:CGPointMake(CellContent_Left_Margin, bottomContentOriginY)];
  
  CGFloat nameLabelOriginX = [self.collectionCellAvatarButton right] + BottomContent_Avatar_To_Name_Margin;
  [self.collectionCellNameLabel setOrigin:CGPointMake(nameLabelOriginX,bottomContentOriginY)];
  
  
  [self.collectionCellAnswersLabel setOrigin:CGPointMake(answerLabelOriginX, bottomContentOriginY)];
  
}

+ (CGFloat)RowHeightWitObject:(id)object
{
  ZHCollectionObject *collectionObject = (ZHCollectionObject *)object;
  NSString *des = collectionObject.des;
  if ([des isEqualToString:@""] || !des) {
    return Default_Cell_Height;
  }
  
  CGFloat rowHeight = desTextSize(des).height + Default_Cell_Height;
  return rowHeight;
}

CGSize desTextSize(NSString *desText) {
  
	CGSize size = [desText sizeWithFont:DesLabelFont
                    constrainedToSize:CGSizeMake(DesLabelWidth, MAXFLOAT)
                        lineBreakMode:NSLineBreakByWordWrapping];
  return size;
  
}

@end
