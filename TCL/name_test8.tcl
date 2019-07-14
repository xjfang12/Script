namespace eval example {
  proc foo {args} {puts foo::$args}
  proc bar {args} {puts bar::$args}
  proc set {var args} {
    upvar 1 $var v
    set v {expand} $args
  }
  proc setClass {var args} {
    variable $var 
    set $var {expand} $args
  }
}
