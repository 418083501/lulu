//
//  GLESUtils.h
//  TestOpenGLES
//
//  Created by lurong on 15/1/30.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>

@interface GLESUtils : NSObject

+(GLuint)loadShader:(GLenum)type withString:(NSString *)shaderString;

+(GLuint)loadShader:(GLenum)type withFilepath:(NSString *)shaderFilepath;

@end
