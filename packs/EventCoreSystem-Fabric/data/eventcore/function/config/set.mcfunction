# Config değeri setter — raw SNBT değerler için (bool: 1b/0b, int: 5 vb.)
# Kullanım: function eventcore:trigger {args:{type:"config_set",data:{key:"debug.sound",value:0b}}}
$data modify storage eventcore:config $(key) set value $(value)
