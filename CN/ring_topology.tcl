set ns [new Simulator]
$ns rtproto DV

set nf [open out.nam w]
$ns namtrace-all $nf
set all_trace [open out_ring.tr w]
$ns trace-all $all_trace
$ns color 2 yellow
$ns color 3 Red

proc finish {} {
        global ns nf
        $ns flush-trace
        close $nf
        exec nam out.nam
        exit 0
        }

#Creating Nodes
for {set i 0} {$i<7} {incr i} {
set n($i) [$ns node]
}

#Creating Links
for {set i 0} {$i<7} {incr i} {
$ns duplex-link $n($i) $n([expr ($i+1)%7]) 512Kb 5ms DropTail
}

$ns duplex-link-op $n(0) $n(1) queuePos 1
$ns duplex-link-op $n(0) $n(6) queuePos 1

#Creating UDP agent and attching to node 0
set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0
$udp0 set fid_ 2

#Creating Null agent and attaching to node 3
set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0

$ns connect $udp0 $null0


#Creating a CBR agent and attaching it to udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1024
$cbr0 set interval_ 0.01
$cbr0 attach-agent $udp0

$ns rtmodel-at 1.2 down $n(2) $n(3)
$ns rtmodel-at 3.0 up $n(2) $n(3)

$ns at 0.03 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

$ns at 6.0 "finish"
$ns run
