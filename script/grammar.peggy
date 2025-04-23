{
    input = input.replaceAll(" ", "");
}

start
  = Sen

Sen
  = "(" s:Sen ")" { return s; }
  / n:neg s:Sen {return [n, s];}
  / q:quant v:var s:Sen { return [q+v, s]; }
  / left:Atom op:binop right:Sen { return [left, op, right]; }
  / Atom

Atom
  = pred:predicateSym "(" terms:Term|1..,","|  ")"  { return [pred, ...terms]; }

Term
	= fun:functionSym "(" terms:Term|1..,","| ")"  { return [fun, ...terms]; }
    / indiv
    / var

predicateSym
  = $([A-Z][A-z]*)
  
functionSym
  = $([a-z]+)

binop
  = '&' / 'v' / '>' / '<>' / '\u2227' {return "&"} / '\u2228' {return "v"} / '\u2192' {return ">"} / '\u2194' {return "<>"}

neg
 = '~' / '\u00AC' {return "~";}

quant
  = 'E' / 'A' / '\u2203' {return "E"} / '\u2200' {return "A"}

indiv
  = $([a-h]+)
  
var
  = $([x-z]+)