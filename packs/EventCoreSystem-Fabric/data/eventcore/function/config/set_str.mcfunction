# Config değeri setter — string değerler için (prefix, renk adları vb.)
# Kullanım: function eventcore:trigger {args:{type:"config_set_str",data:{key:"broadcast.prefix",value:"[OLAY]"}}}
$data modify storage eventcore:config $(key) set value "$(value)"
