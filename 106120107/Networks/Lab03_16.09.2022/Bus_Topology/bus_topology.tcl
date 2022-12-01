set ns [new Simulator]


set nf [ open "out.nam" w]
$ns namtrace-all $nf
set all_trace [open out_bus.tr w]
$ns trace-all $all_trace
$ns color 2 yellow
$ns color 3 Red

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns queue-limit $n0 $n1 50

$ns duplex-link-op $n0 $n1 orient right

set lan [$ns newLan "$n1 $n2 $n3 $n4 $n5" 0.5Mb 10ms LL Queue/DropTail MAC/-802_3 CHANNEL ]

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
$tcp0 set fid_ 3

set sink1 [new Agent/TCPSink]
$ns attach-agent $n5 $sink1
$ns connect $tcp0 $sink1

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.01
$cbr0 attach-agent $tcp0

proc finish {} {
	global ns nf ;
 	$ns flush-trace
 	close $nf
 	
 	exec nam out.nam &
 	exit 0
 	}

$ns at .5 "$cbr0 start" ;
$ns at 3.5 "$cbr0 stop"

$ns at 5 "finish"

$ns run
