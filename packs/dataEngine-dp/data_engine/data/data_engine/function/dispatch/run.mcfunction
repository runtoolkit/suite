# dataEngine — Dispatch/Run
# data_api:public delay sistemiyle aynı pattern:
#   queue[0]'ı al → çalıştır → sil → tekrar kontrol et.
# data_engine:private dispatch.queue  string listesi

execute if data storage data_engine:private dispatch.queue[0] \
    run function data_engine:dispatch/tick
