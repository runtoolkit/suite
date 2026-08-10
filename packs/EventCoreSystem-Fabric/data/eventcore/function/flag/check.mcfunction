# Flag 1b mi? 1 = true, 0 = false/yok. Kullanım: {name:"my_flag"}
$execute if data storage eventcore:flags {$(name):1} run return 1
return 0
