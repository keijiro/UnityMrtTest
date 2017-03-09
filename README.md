Unity MRT Test
--------------

This example shows how to use MRT (multi render targets) buffers in Unity.

![Screenshot](http://i.imgur.com/vx56Tkx.png)

**Note** - In most cases, the MRT feature doesn’t work with OpenGL ES 2.0.
It’s recommended to use with OpenGL ES 3.0 or Metal. In case OpenGL ES 2.0
support is required, shader blocks using MRT should be disabled with
`#if !SHADER_API_GLES` directives, because they emit shader compilation
error at run time.
