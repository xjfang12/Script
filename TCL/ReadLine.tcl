set fid [open "| du /usr " r]
chan configure $fid -blocking 0
chan event $fine readable [list ReadLine $fid]

proc ReadLine {fid} {
  global done
  if {[catch {gets $fid line} len] || [chan eof $fid]} {
    catch {close $fid}
    puts stderr "Channel closed"
    set done 1
    return
  } elseif {$len >= 0} { 
    puts "Read line: $line"
  }
}

vwait done
