# http://stackoverflow.com/questions/19320102/returning-data-through-pipeline-from-an-event

$t0 = $(Get-Date)
$tprev = $t0
$tnow = $0

Function WriteTimeStamp {
  $tnow = $(Get-Date)
  $ts = New-TimeSpan $t0 $tnow
$color = ""

  if ( (New-TimeSpan $tprev $tnow).TotalSeconds -ge 5 )
  {
    $color = "Yellow"
  }
  elseif ( (New-TimeSpan $tprev $tnow).TotalSeconds -ge 10 )
  {
    $color = "Red"
  }
  
  if ($color -ne "")
  {
  write-host "$ts " -foregroundcolor $color -NoNewLine
  }
  else
  {
  write-host "$ts " -NoNewLine
  }
  $tprev = $tnow
}

Function ShellSvnAsynchronously {
    Param(
        [String] $command,
        [String] $arguments
    )

$abscommand = Get-Command $command | Select-Object -ExpandProperty Definition

    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.Arguments = "$arguments"
    $startInfo.RedirectStandardError = $true
    $startInfo.RedirectStandardOutput = $true
    $startInfo.CreateNoWindow = $true
    $startInfo.FileName = $abscommand[0]
    $startInfo.UseShellExecute = $false

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo

    # Set up events.
    $s = Register-ObjectEvent -InputObject $process -EventName ErrorDataReceived -SourceIdentifier processErrorDataReceived -Action {
        $data = $EventArgs.data
        if (-not [string]::IsNullOrEmpty($data))
        {
            WriteTimeStamp
            Write-Host "$data" -ForegroundColor Red
        }
    }

    # Register an Action for Standard Output Data Received Event
    $s = Register-ObjectEvent -InputObject $process -EventName OutputDataReceived -SourceIdentifier processOutputDataReceived -Action {
        $data = $EventArgs.data
        if (-not [string]::IsNullOrEmpty($data))
        {
            #Write-Host "Logging: $data" -ForegroundColor Blue
            #Write-Host "$data"
            #Write-Output $data
            WriteTimeStamp
            Write-Host "$data" 
        }
    }
    $s = $process.Start()
    $process.BeginOutputReadLine()
    $process.BeginErrorReadLine()
    $process.WaitForExit()

    Unregister-Event -SourceIdentifier processOutputDataReceived
    Unregister-Event -SourceIdentifier processErrorDataReceived
}

$first = $args[0]
$rest = $args[1 .. ($args.count-1)]
ShellSvnAsynchronously $first $rest 
