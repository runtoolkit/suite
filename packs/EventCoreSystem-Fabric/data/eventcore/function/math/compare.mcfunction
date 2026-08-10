# Skor aralık eşleşmesi. 1 = eşleşti, 0 = eşleşmedi.
# Kullanım: {name:"foo",obj:"my_obj",range:"1..10"}
# range örnekleri: "5" "..10" "1.." "0"
$execute if score $(name) $(obj) matches $(range) run return 1
return 0
