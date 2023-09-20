
CoordMode, Mouse, Screen
MouseGetPos, xpos, ypos
SysGet, MCount, MonitorCount

global MCount
; 记录上一个跳转到的显示器 
; Record the display that was previously jump to
global before_monitor := 1 
; all of monitors
global monitors := {}

; 初始化 获取显示器数量 坐标尺寸 中心点等
; Obtain the number of displays, dimensions, center points, etc
init()

; ###################################################
; 进阶用法
; 为特定显示器添加动作或事件
; 对应执行函数在最后
; Advanced usage
; Adding Actions or Events to a Specific Display
; The corresponding execution function is at the end
; ###################################################
monitors[1].on_before_jump := Func("on_before_jump1")
; ; monitors[1].on_after_jump := Func("on_after_jump1")
monitors[2].on_jump_in := Func("on_jump_in2")


; ###################################################
; 热键 hotkey
; ###################################################

; 显示鼠标当前坐标
; Display the current mouse coordinates
#!C::
    MouseGetPos, xpos, ypos
    MsgBox, x: %xpos%  -- y: %ypos%
return

; 鼠标跳转到下一个显示器
; Mouse jumps to the next display
#!X::
    the_next := 1

    cur_monitor := find_cur_monitor()

    if(MCount!= cur_monitor)
        the_next += 1
    ; MsgBox %the_next%

    mouse_jump(the_next)
return

; 鼠标跳转到上一个显示器
; Mouse jumps to the previous display
#!Z::
    the_prev := before_monitor
    ; MsgBox %the_prev%
    mouse_jump(the_prev)
return

; 鼠标跳转到指定显示器
; Mouse jumps to the specified display
+!1::
    mouse_jump(1)
return
+!2::
    mouse_jump(2)
return

; ###################################################
; 初始化 initialization
; ###################################################
init()
{
    ; 循环所有的显示器 根据显示器的上右下左 获取中心点
    Loop, %MCount%
    {
        cur := A_Index
        SysGet, temp, monitor, %cur%
    
        ; MsgBox,显示器%cur% Left: %tempLeft%  -- Top:  %tempTop%  -- Right:  %tempRight%  -- Bottom:  %tempBottom%  -- x: %xpos%  -- y: %ypos%
        ; 计算对应屏幕的中心点
        ; Calculate the center point of the corresponding screen
        m_x:= (tempLeft+tempRight)//2
        m_y:= (tempTop+tempBottom)//2

        monitors[cur] := {left: tempLeft,top: tempTop,right: tempRight,bottom: tempBottom,x: m_x,y: m_y}
    }
}
; 当前鼠标所在显示器
find_cur_monitor()
{
    MouseGetPos, xpos, ypos
    ; 循环所有的显示器
    Loop, %MCount%
    {
        cur := A_Index
        ;   monitors[cur] := {left: tempLeft,top: tempTop,right: tempRight,bottom: tempBottom,x: m_x,y: m_y}

        ; 判断当前鼠标所在的显示器
        ; Determine the display where the current mouse is located
        if(xpos >= monitors[cur].Left)
        and (xpos <= monitors[cur].Right)
        and (ypos >= monitors[cur].Top)
        and (ypos <= monitors[cur].Bottom)
        {
            ; MsgBox, 改变前 显示器%cur%
            ; before_monitor := cur
            return cur
        }
    }
}

; 鼠标跳转显示器
mouse_jump(to)
{
    cur_monitor := find_cur_monitor()

    before_monitor := cur_monitor

    if(monitors[cur_monitor].on_before_jump){
        monitors[cur_monitor].on_before_jump()
    }

    MouseMove, monitors[to].x, monitors[to].y, 0

    if(monitors[cur_monitor].on_after_jump){
        monitors[cur_monitor].on_after_jump()
    }

    if(monitors[to].on_jump_in){
        monitors[to].on_jump_in()
    }

    ; 激活窗口
    MouseGetPos, mouseX, mouseY, winId
    WinActivate, ahk_id %winId%
    WinWaitActive, ahk_id %winId% ; 等待窗口激活
}

; ###################################################
; 进阶用法 Advanced usage
; ###################################################

; 跳出1号显示器之前
on_before_jump1()
{
    ; Send, {LWin down}2{LWin up}
    _activeVSCodeWindow()
}
; 激活vscode窗口
_activeVSCodeWindow()
{
    SetTitleMatchMode, 2  ; 设置标题匹配模式为包含模式
    ; 替换为你要匹配的 VSCode 窗口标题
    windowTitle := "Visual Studio Code"
    WinActivate, % windowTitle
    WinWaitActive, % windowTitle
}
; 跳出1号显示器之后
on_after_jump1()
{
    MsgBox on_after_jump1
}
; 进入到2号显示器之后
on_jump_in2()
{
    ; 移动到指定坐标
    ; Move to specified coordinates
    MouseMove, -1580, 500, 0
}