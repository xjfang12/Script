package provide testp 1.0
proc whoAmI {} {
   return "global command"
   }
namespace eval ns {
	proc whoAmI {} {
		return "namespace command"
	}
}

