//
//  OpenGLView.m
//  TestOpenGLES
//
//  Created by lurong on 15/1/29.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import "OpenGLView.h"
#import "GLESUtils.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

@interface OpenGLView ()
{
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
    GLuint _colorRenderBuffer;
    GLuint _frameBuffer;
    
    
    
    GLuint _programHandle;
    GLuint _positionSlot;
    
}

-(void)setupLayer;

- (void)setupProgram;

@end

@implementation OpenGLView

-(void)setPosX:(float)posX
{
    _posX = posX;
    
#warning 这里
    
}

-(void)setupProgram
{
    NSString *vertextPath = [[NSBundle mainBundle] pathForResource:@"vertextShader" ofType:@"glsl"];
    NSString *fragmentPath = [[NSBundle mainBundle] pathForResource:@"FragmentShader" ofType:@"glsl"];
    
    GLuint vertextShader = [GLESUtils loadShader:GL_VERTEX_SHADER withFilepath:vertextPath];
    GLuint fragmentShader = [GLESUtils loadShader:GL_FRAGMENT_SHADER withFilepath:fragmentPath];
    
    _programHandle = glCreateProgram();
    
    if (!_programHandle) {
        
        NSLog(@"create fail!");
        
        return;
    }
    
    glAttachShader(_programHandle, vertextShader);
    glAttachShader(_programHandle, fragmentShader);
    
    glLinkProgram(_programHandle);
    
    GLint programIsOk = 0;
    glGetProgramiv(_programHandle, GL_LINK_STATUS, &programIsOk);
    
    if (!programIsOk) {
        GLint length = 0;
        
        glGetProgramiv(_programHandle, GL_INFO_LOG_LENGTH, &length);
        
        if (length > 1) {
            char *infoLog = malloc(sizeof(char) * length);
            free(infoLog);
        }
        
        glDeleteProgram(_programHandle);
        _programHandle = 0;
        
        return;
        
    }
    
    glUseProgram(_programHandle);
    
    _positionSlot = glGetAttribLocation(_programHandle, "vPosition");
    
    
}

+ (Class)layerClass {
    // 只有 [CAEAGLLayer class] 类型的 layer 才支持在其上描绘 OpenGL 内容。
    return [CAEAGLLayer class];
}

-(void)setupLayer
{
    _eaglLayer = (CAEAGLLayer *)self.layer;
    _eaglLayer.opaque = YES;
    
    _eaglLayer.drawableProperties = @{
                                      kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8,
                                      kEAGLDrawablePropertyRetainedBacking:@(0)
                                      };
    
}

-(void)setupContext
{
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!_context) {
        
        //        exit(1);
        
        return;
    }
    
    if (![EAGLContext setCurrentContext:_context]) {
        
        //        exit(1);
        
        return;
    }
}

-(void)setupRenderBuffer
{
    glGenBuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

-(void)setupFrameBuffer
{
    glGenFramebuffers(1, &_frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
}

- (void)destoryRenderAndFrameBuffer
{
    glDeleteFramebuffers(1, &_frameBuffer);
    _frameBuffer = 0;
    glDeleteRenderbuffers(1, &_colorRenderBuffer);
    _colorRenderBuffer = 0;
}

- (void)drawTriCone
{
    GLfloat vertexs[] = {
        -.5,.5,0,
        .5,.5,0,
        .5,-.5,0,
        -.5,-.5,0,
        0,0,-.707
    };
    
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, 0, vertexs);
    glEnableVertexAttribArray(_positionSlot);
    
    
    //弄不懂什么意思
    GLubyte indices[] = {
        0, 1, 1, 2, 2, 3, 3, 0,
        4, 0, 4, 1, 4, 2, 4, 3
    };
    
    glDrawElements(GL_LINES, sizeof(indices)/sizeof(GLubyte), GL_UNSIGNED_BYTE, indices);
    
}

- (void)render {
    glClearColor(0, 1.0, 1.0, 1.);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    
//    GLfloat vertices[] = {
//        -0.5,-0.5,0.,
//        -0.5,0.5,0.,
//        0.5,0.5,0.,
//        0.5,-0.5,0.
//    };//x,y,z
//    
//    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, 0, vertices);
//    
//    glEnableVertexAttribArray(_positionSlot);
//    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    [self drawTriCone];
    
    
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

- (void)cleanup
{
    [self destoryBuffers];
    
    if (_programHandle != 0) {
        glDeleteProgram(_programHandle);
        _programHandle = 0;
    }
    
    if (_context && [EAGLContext currentContext] == _context)
        [EAGLContext setCurrentContext:nil];
    
    _context = nil;
}

- (void)destoryBuffers
{
    glDeleteRenderbuffers(1, &_colorRenderBuffer);
    _colorRenderBuffer = 0;
    
    glDeleteFramebuffers(1, &_frameBuffer);
    _frameBuffer = 0;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
        [self setupContext];
    }
    return self;
}

- (void)layoutSubviews {
    [EAGLContext setCurrentContext:_context];
    
    [self destoryRenderAndFrameBuffer];
    
    [self setupRenderBuffer];
    [self setupFrameBuffer];
    
    [self setupProgram];
    
    [self render];
}

@end
