set ns [new Simulator]

set val(x) 500
set val(y) 500
set val(chan) Channel/WirelessChannel ;
set val(prop) Propagation/TwoRayGround ;

set val(netif) Phy/WirelessPhy ;
set val(mac) Mac/802_11 ;
set val(ifq) Queue/DropTail/PriQueue ;
set val(ll) LL ;
set val(ant) Antenna/OmniAntenna ;
set val(ifqlen) 200 ;
set val(nn) 4 ;
set val(rp) AODV ;
set val(x) 500 ;
set val(y) 400 ;
set val(stop) 10.0 ;

set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

set namfile [open 2.nam w]
$ns namtrace-all-wireless $namfile $val(x) $val(y)

set tracefile [open 2.tr w]
$ns trace-all $tracefile

create-god $val(nn)

$ns node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace OFF \
-movementTrace ON


set n1 [$ns node]
$n1 color black

$n1 set X_ 200
$n1 set Y_ 100
$n1 set Z_ 0

set n2 [$ns node]
$n2 color black

$n2 set X_ 200
$n2 set Y_ 300
$n2 set Z_ 0

set n3 [$ns node]
$n3 color black

$n3 set X_ 100
$n3 set Y_ 300
$n3 set Z_ 0

set n4 [$ns node]
$n4 color black

$n4 set X_ 100
$n4 set Y_ 100
$n4 set Z_ 0
$ns at 0.1 "$n1 color blue"
$ns at 0.1 "$n2 color red"
$ns at 0.1 "$n3 color green"
$ns at 0.1 "$n4 color yellow"
$ns at 0.1 "$n1 label N1"
$ns at 0.1 "$n2 label N2"
$ns at 0.1 "$n3 label N3"
$ns at 0.1 "$n4 label N4"
$ns initial_node_pos $n1 30
$ns initial_node_pos $n2 30
$ns initial_node_pos $n3 30
$ns initial_node_pos $n4 30

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
 
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

set udp2 [new Agent/UDP]
$ns attach-agent $n2 $udp2
 
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2

set udp3 [new Agent/UDP]
$ns attach-agent $n3 $udp3
 
set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $udp3

set null0 [new Agent/Null]
$ns attach-agent $n4 $null0
$ns connect $udp1 $null0
$ns connect $udp2 $null0
$ns connect $udp3 $null0 

$ns at 1.0 "$cbr1 start"
$ns at 8.0 "$cbr1 stop"

$ns at 2.0 "$cbr2 start"
$ns at 7.0 "$cbr2 stop"

$ns at 2.5 "$cbr3 start"
$ns at 9.0 "$cbr3 stop"
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "stop"
$ns at 10.01 "puts \"end simulation\" ; $ns halt"

proc stop {} {
global namfile tracefile ns
$ns flush-trace
close $namfile
close $tracefile
exec nam 2.nam &
}

$ns run
