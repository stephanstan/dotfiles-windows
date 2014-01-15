$t0 = $(Get-Date)
$tprev = $t0

while (($line = read-host) -cne $flag)
{
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
  $line
}

