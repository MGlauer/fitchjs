{
    input = input.replaceAll(" ", "");
	function flatten(sen, more){
    	let op = undefined;
        if(more.length == 0) return sen;
        let res = [sen];
        for(let i=0; i<more.length; i+=1){
       		if(!op){op = more[i][0];};
        	if(op != more[i][0]){
            	throw "Different operators on same level";
            }
            res.push(more[i][1])
        }
        let r = res[res.length-1]
        for(let i=res.length-2; i>=0; i--){
        	r = [res[i], op, r]
        }
        return r
    }
}

start
  = Sen

Sen
  = q:quant v:var s:PSen { return [q+v, s]; }
  / left:PSen more:((binop PSen)*) { return flatten(left, more); }

PSen
 = n:neg s:PSen {return [n, s];}
 / "(" left:Sen ")" {return left;}
 / Atom
 
Atom
  = pred:predicateSym par:("(" terms:Term|1..,","|  ")")?  { if(!par) return pred; return [pred, ...terms]; }
  / '#' 
  / '\u22A5' {return "#"}

Term
	= fun:functionSym "(" terms:Term|1..,","| ")"  { return [fun, ...terms]; }
    / indiv
    / var

predicateSym
  = $([A-uw-z][A-uw-z]*)
  
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