//
//  GLESUtils.m
//  TestOpenGLES
//
//  Created by lurong on 15/1/30.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import "GLESUtils.h"

@implementation GLESUtils

+(GLuint)loadShader:(GLenum)type withFilepath:(NSString *)shaderFilepath
{
    
    NSError *error;
    
    NSString *path = [NSString stringWithContentsOfFile:shaderFilepath encoding:NSUTF8StringEncoding error:&error];
    if (!path) {
        return 0;
    }
    
    return [self loadShader:type withString:path];
}

+(GLuint)loadShader:(GLenum)type withString:(NSString *)shaderString
{
    
    GLuint shader = glCreateShader(type);
    
    if (!shader) {
        
        NSLog(@"create fail!");
        
        return 0;
    }
    
    const char *shaderStrUTF8 = shaderString.UTF8String;
    
    glShaderSource(shader, 1, &shaderStrUTF8, NULL);
    glCompileShader(shader);
    
    GLint isComplie = 0;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &isComplie);
    
    if (!isComplie) {
        
        
        GLint lenth = 0;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &lenth);
        
        if (lenth > 1) {
            
            char * infoLog = malloc(sizeof(char) * lenth);
            glGetShaderInfoLog (shader, lenth, NULL, infoLog);
            NSLog(@"Error compiling shader:\n%s\n", infoLog );
            
            free(infoLog);
            
        }
        
        glDeleteShader(shader);
        return 0;
        
    }
    
    return shader;
}

@end
