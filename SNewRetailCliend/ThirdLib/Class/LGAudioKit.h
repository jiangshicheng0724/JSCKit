//
//  LGAudioKit.h
//  下载地址：https://github.com/gang544043963/LGAudioKit
//
//  Created by ligang on 16/8/20.
//  Copyright © 2016年 LG. All rights reserved.
//

#ifndef LGAudioKit_h
#define LGAudioKit_h

#import "LGSoundRecorder.h"
#import "LGAudioPlayer.h"
typedef NS_ENUM(NSUInteger, LGVoicePlayState){
    LGVoicePlayStateNormal,/**< 未播放状态 */
    LGVoicePlayStateDownloading,/**< 正在下载中 */
    LGVoicePlayStatePlaying,/**< 正在播放 */
    LGVoicePlayStateCancel,/**< 播放被取消 */
};

#endif /* LGAudioKit_h */
