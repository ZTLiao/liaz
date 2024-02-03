cmake_minimum_required(VERSION 3.4.1)

#设置生成的so动态库最后输出的路径
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/libs/${ANDROID_ABI})

#.h文件目录
include_directories(
        ${CMAKE_SOURCE_DIR}/src/main/cpp/include #h文件目录
)

add_library( # Sets the name of the library.
        liaz                                        # c/cpp代码将要编译成为so库的名称，java代码加载库文件要用这个名称
        SHARED                                      # 动态库
        ${CMAKE_SOURCE_DIR}/src/main/cpp/decrypt.c  # cpp代码文件路径 可以在下面接着随意添加c、c++文件
        )

find_library(   # 调用系统库
        log-lib # 打印用
        log)

target_link_libraries( # Specifies the target library.
        liaz
        ${log-lib})