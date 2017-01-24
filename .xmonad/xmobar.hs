-- xmobar config born from Vic Fryzel
-- http://github.com/vicfryzel/xmonad-config
-- heavily altered by me (Nozomu Okuda)

-- for weather code, check
-- http://aviationweather.gov/static/adds/metars/stations.txt
Config {
    font = "xft:Hack:size=8:antialias=true",
    bgColor = "#000000",
    fgColor = "#ffffff",
    position = Top,
    hideOnStart = False,
    persistent = True,
    lowerOnStart = True,
    pickBroadest = False,
    allDesktops = True,
    commands = [
        Run Weather "KPVU" ["-t","<tempF>F <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
        Run MultiCpu ["-t","Cpu: <total0> <total1> <total2> <total3>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10,
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Swap ["-t","Swap: <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Network "em1" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Date "%a %b %_d %l:%M" "date" 10,
        Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %multicpu%   %memory%   %swap%   %em1%   <fc=#FFFFCC>%date%</fc>   %KPVU%"
}
