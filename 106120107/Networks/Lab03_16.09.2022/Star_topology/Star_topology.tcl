set ns [new Simulator]

set nf [open out.nam w]
$ns namtrace-all $nf
set all_trace [open out_star.tr w]
$ns trace-all $all_trace
$ns color 2 yellow
$ns color 3 Red

proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam out.nam &
    exit0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n0 shape square

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail
$ns duplex-link $n0 $n5 1Mb 10ms DropTail

set tcp0 [new Agent/TCP]
$tcp0 set class_ 1
$ns attach-agent $n1 $tcp0
$tcp0 set fid_ 3

set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0



set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.01
$cbr0 attach-agent $tcp0


set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n4 $tcp1
$tcp1 set fid_ 2

set sink1 [new Agent/TCPSink]
$ns attach-agent $n5 $sink1
$ns connect $tcp1 $sink1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.01
$cbr1 attach-agent $tcp1


$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

$ns at 1.5 "$cbr1 start"
$ns at 4.0 "$cbr1 stop"

$ns at 5.0 "finish"

$ns run
