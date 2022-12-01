BEGIN {
    recieved = 0;
    sent = 0;
}

{
    event = $1
    time = $2
    source = $3
    packet_size = $8;

    if (( event == "r" ) && ( source == "_3_" )) {
        recieved += packet_size;
    }
    if (( event == "s" ) && ( source != "_3_" )) {
        sent += packet_size;
    }
    print time, recieved, sent;
}

END {
    ;
}
