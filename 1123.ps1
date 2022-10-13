cmd.exe --% /c "mshta vbscript:Execute("msgbox ""O �ltimo dispositivo USB conectado a este computador teve um mau funcionamento e o Windows n�o o reconhece. Clique em OK para iniciar os reparos  "",16,""Dispositivo USB n�o reconhecido"":close")"
$ErrorActionPreference = "Stop"

$notificationTitle = "Iniciando a repara��o do dispositivo USB. Cancelar o processo pode trazer danos ao dispositivo"

[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText01)

#Convert to .NET type for XML manipuration
$toastXml = [xml] $template.GetXml()
$toastXml.GetElementsByTagName("text").AppendChild($toastXml.CreateTextNode($notificationTitle)) > $null

#Convert back to WinRT type
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($toastXml.OuterXml)

$toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
#$toast.SuppressPopup = $true

$notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("Dispositivo USB desconhecido")
$notifier.Show($toast);