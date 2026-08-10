# Config'teki cmd.security flag'ına göre komutu yönlendirir.
# security:1b → command/run (OP/ban filtreleri aktif)
# security:0b → command/run_direct (filtresiz)
execute if data storage eventcore:config cmd{security:1} run function eventcore:command/run with storage eventcore:sys args.data
execute if data storage eventcore:config cmd{security:0} run function eventcore:command/run_direct with storage eventcore:sys args.data
