

validator (String? val , int min , int max ){

if (val!.length < min) {
 return "at least $min characters";
}
if (val.length > max ) {
   return "cant be more than $max characters";
}
}