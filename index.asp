<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'/*
 '* Copyright 2006-2014 DNSPod, Inc.  All Rights Reserved.
 '* 
 '* @author		李院长
 '* @email		mjj@dnspod.com
 '* @version	1.0.0
 '*/
%>
<!--#include file="md5.asp"-->
<%
callback_key   = "mjj"                          ' 添加监控时设置的密钥

monitor_id     = Request.Form("monitor_id")     ' 监控编号
domain_id      = Request.Form("domain_id")      ' 域名编号
domain         = Request.Form("domain")         ' 域名名称
record_id      = Request.Form("record_id")      ' 记录编号
sub_domain     = Request.Form("sub_domain")     ' 主机名称
record_line    = Request.Form("record_line")    ' 记录线路
ip             = Request.Form("ip")             ' 记录IP
status         = Request.Form("status")         ' 当前状态
status_code    = Request.Form("status_code")    ' 状态代码
reason         = Request.Form("reason")         ' 宕机原因
created_at     = Request.Form("created_at")     ' 发生时间
checksum       = Request.Form("checksum")       ' 校检代码

If md5(monitor_id & domain_id & record_id & callback_key & created_at) <> checksum Then
    ' 非法请求
    Response.Write("BAD REQUEST")
Else
    ' 开始处理
    if status = "Warn" or status = "Ok" Then
        ' 宕机恢复

        ' ----* 这里是您的代码 *----
		file_put_contents "log/monitor.log", created_at & " " & monitor_id & " " & status & "(" & status_code & ") " & domain & "(" & domain_id & ") " & sub_domain & "(" & record_id & ") " & record_line & " " & ip
    ElseIf status = "Down" Then
        ' 已经宕机

        ' ----* 这里是您的代码 *----
		file_put_contents "log/monitor.log", created_at & " " & monitor_id & " " & status & "(" & status_code & ") " & domain & "(" & domain_id & ") " & sub_domain & "(" & record_id & ") " & record_line & " " & ip & " " & reason
    End If
    
    ' 处理完成
    Response.Write("DONE")
End If

Sub file_put_contents(strFile, strText)
	strFile = Server.MapPath(strFile)
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

	If objFSO.FileExists(strFile) Then
		Set objFile = objFSO.OpenTextFile(strFile, 8, True)
	Else
		Set objFile = objFSO.CreateTextFile(strFile)
	End If

	objFile.WriteLine(strText)
	objFile.Close
	Set objFile = Nothing
	Set objFSO = Nothing
End Sub
%>
