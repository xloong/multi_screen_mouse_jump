# 鼠标一键跳转多屏 (multi screen mouse jump)

一个可以一键（组合键）跳转鼠标到下一个或上一个显示屏的小工具

多屏用户适用

为患有鼠标手，腱鞘炎的朋友提供方便  

A small tool that can jump the mouse to the next or previous display screen with one click (combination of keys)

Suitable for multi screen users

Provide convenience for friends with carpal tunnel syndrome and tenosynovitis  

## 使用 usage

`win + alt + x`  
  将鼠标跳转到下一个屏幕的中心  
  Jump the mouse to the center of the next screen  

`win + alt + z`  
  将鼠标跳转到上一个屏幕的中心  
  Jump the mouse to the center of the previous screen  

`win + alt + c`  
  显示鼠标当前所在位置的坐标  
  Display the coordinates of the current mouse position  

*新增 new features*
`shift + alt + 1`  
`shift + alt + 2`  
  鼠标跳转到指定显示器  
  Mouse jumps to the specified display  

用win键来设置快捷键主要不想有冲突，至于使用起来按键多，麻烦的问题，我是用鼠标多余的功能键映射快捷键，使用鼠标的时候一键就触发了；使用触摸板的时候，也近一些

之前触摸板的三指手势设置的是 power toys 的 鼠标跳转，现在把一部分手势换成这个快捷键，触摸板用起来更丝滑了。至于为什么不继续用 power toys ，从那个缩略图显示，再到点击缩略图，感觉太拖沓了，不如直接一键跳转来的爽利。  

跳转后会自动激活鼠标所在的窗口，方便直接操作。  

Using the win key to set shortcut keys is mainly to avoid conflicts. As for the troublesome problem of having too many buttons, I used the redundant function keys of the mouse to map shortcut keys, which were triggered with just one click when using the mouse; When using the touchpad, it is also closer

Previously, the three finger gestures on the touchpad were set to the mouse jump of power toys. Now, some of the gestures have been replaced with this shortcut key, making the touchpad smoother to use.
As for why not continue using Power Toys, from the thumbnail display to clicking on the thumbnail, it feels too slow, so it's better to just jump to it with one click.

After jumping, the window where the mouse is located will be automatically activated, making it convenient for direct operation.

### 提示 tips

你可以在代码中修改快捷键

可以按代码中的注释，修改鼠标跳转到指定屏幕的指定坐标位置

**由于我只有2个显示屏，因此多余2个显示屏的使用，未经测试**

You can modify the shortcut keys in the code

You can modify the mouse to jump to the specified coordinate position on the specified screen according to the comments in the code

**Since I only have 2 screens, the use of the remaining 2 screens has not been tested**

## 进阶用法 advanced usage

可以为指定的显示器添加动作或事件

**前提是你已经知道对应显示器的编号**

You can add actions or events to specific displays

**The prerequisite must be that you already know the corresponding display number**

`on_before_jump`  
  鼠标跳转前的动作  
  Actions before mouse jump

`on_after_jump`  
  鼠标跳转后的动作  
  Actions after mouse jump

`on_jump_in`  
  鼠标跳转入新显示屏的动作  
  Actions when the mouse jumps into the new display screen

例如 eg.

在跳离屏幕1之前，将 VS Code 激活置顶(安心摸鱼不被抓)  
Activate VS Code to the top before jumping out screen 1

```AutoHotkey
monitors[1].on_before_jump := Func("on_before_jump1")
; ...
on_before_jump1()
{
    SetTitleMatchMode, 2
    windowTitle := "Visual Studio Code"
    WinActivate, % windowTitle
    WinWaitActive, % windowTitle
}
```

在跳入屏幕2之后，立即将鼠标移动到指定坐标  
After jumping into screen 2, immediately move the mouse to the specified coordinates

```AutoHotkey
monitors[2].on_jump_in := Func("on_jump_in2")
; ...
on_jump_in2()
{
    MouseMove, -1580, 500, 0
}
```

**注意 NB**

在上面2个例子中  
`on_before_jump1()`是绑定在显示器1`on_before_jump`上的  
`on_jump_in2()` 是绑定在显示器2`on_jump_in`上的  
他们的执行顺序不同，具体参见代码

你可以根据需要添加其他的动作或事件

In the two examples above.  
`on_before_jump1()`is bound to screen 1 `on_before_jump`.   
`on_jump_in2()` is bound to screen 2`on_jump_in`.  
Their execution order is different. Please refer to the code for details

You can add other actions or events as needed