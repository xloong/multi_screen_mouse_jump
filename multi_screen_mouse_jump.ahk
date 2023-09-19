
CoordMode, Mouse, Screen
MouseGetPos, xpos, ypos

SysGet, MCount, MonitorCount

before_monitor := 1 ; 记录上一个显示器
monitors := {}
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

    ; 指定鼠标跳转后所在 显示器的指定位置
    ; Specify the specified position on the display after the mouse jumps
    if(cur==1){
        ; 指定屏幕位置
        ; Specify screen position
        ; m_x := 1200
        ; m_y := 800

        ; 根据中心点偏移
        ; Offset based on center point
        ; m_x := m_x+200
        ; m_y := m_y-300
    }

    monitors[cur] := {left: tempLeft,top: tempTop,right: tempRight,bottom: tempBottom,x: m_x,y: m_y}

}

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
            before_monitor := cur
            if(MCount= cur){
                the_next := 1
            }
            else{
                the_next += 1
            }
        }
    }
    ; MsgBox %the_next%
    MouseMove, monitors[the_next].x, monitors[the_next].y, 0

    ; 激活窗口
    MouseGetPos, mouseX, mouseY, winId
    WinActivate, ahk_id %winId%
    WinWaitActive, ahk_id %winId% ; 等待窗口激活

return

; 鼠标跳转到上一个显示器
; Mouse jumps to the previous display
#!Z::
    the_prev := before_monitor
    MouseGetPos, xpos, ypos
    ; 循环所有的显示器
    Loop, %MCount%
    {
        cur := A_Index

        ; 判断当前鼠标所在的显示器
        ; Determine the display where the current mouse is located
        if(xpos >= monitors[cur].Left)
        and (xpos <= monitors[cur].Right)
        and (ypos >= monitors[cur].Top)
        and (ypos <= monitors[cur].Bottom)
        {
            ; MsgBox, 改变前 显示器%cur%
            before_monitor := cur
        }
    }
    ; MsgBox %the_prev%
    MouseMove, monitors[the_prev].x, monitors[the_prev].y, 0

    ; 激活窗口
    MouseGetPos, mouseX, mouseY, winId
    WinActivate, ahk_id %winId%
    WinWaitActive, ahk_id %winId% ; 等待窗口激活

return
