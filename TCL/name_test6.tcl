proc blob {name a b c} {
  namespace eval $name {}
  namespace upvar $name a va b vb c vc
  set va $a
  set vb $b
  set vc $c
  namespace ensemble create -map { 
    set [list ::blobSet $name] 
    sum [list ::blobSum $name] 
    end [list ::blobEnd $name] 
   } -command $name
}
proc blobSet {ns var value} {
   namespace upvar $ns var v 
   set v $value
   return
 }
proc blobSum {ns} {
   namespace upvar $ns a va b vb c vc 
   return [expr {$va + $vb + $vc} ]
 }
proc blobEnd {ns} {
  rename $ns {}
  namespace delete $ns
}

