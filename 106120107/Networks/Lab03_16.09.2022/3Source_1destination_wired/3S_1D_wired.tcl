set ns [new Simulator]
$ns rtproto DV

set tr [ open "out_wired.tr" w]
$ns trace-all $tr

set ftr [ open "out.nam" w]
$ns namtrace-all $ftr
$ns color 2 yellow
$ns color 3 Red

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n1 $n0 2Mb 4ms DropTail
$ns duplex-link $n2 $n0 2Mb 4ms DropTail
$ns duplex-link $n3 $n0 2Mb 4ms DropTail

$ns duplex-link-op $n1 $n0 orient up
$ns duplex-link-op $n2 $n0 orient left-down
$ns duplex-link-op $n3 $n0 orient right-down

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
$tcp1 set fid_ 2

set tcp2 [new Agent/TCP]
$ns attach-agent $n2 $tcp2
$tcp2 set fid_ 3

set tcp3 [new Agent/TCP]
$ns attach-agent $n3 $tcp3

set sink1 [new Agent/TCPSink]
$ns attach-agent $n0 $sink1
$ns connect $tcp1 $sink1
set sink2 [new Agent/TCPSink]
$ns attach-agent $n0 $sink2
$ns connect $tcp2 $sink2
set sink3 [new Agent/TCPSink]
$ns attach-agent $n0 $sink3
$ns connect $tcp3 $sink3

set cbr1 [new Application/Traffic/CBR]
set cbr2 [new Application/Traffic/CBR]
set cbr3 [new Application/Traffic/CBR]

$cbr1 attach-agent $tcp1
$cbr2 attach-agent $tcp2
$cbr3 attach-agent $tcp3
 
proc finish {} {
	global ns tr ftr ;
 	$ns flush-trace
 	close $tr
 	close $ftr
 	exec nam out.nam &
 	exit 0
}
  
$ns at .5 "$cbr1 start" ;
$ns at 1.0 "$cbr2 start" 
$ns at 1.25 "$cbr3 start" 

$ns at 3.5 "$cbr1 stop"
$ns at 4.0 "$cbr2 stop"
$ns at 4.25 "$cbr3 stop"

$ns at 5 "finish"

$ns run
