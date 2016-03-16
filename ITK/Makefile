.PHONY: all
all: help

.PHONY: help
help:
	@echo '**********************************************************************************************'
	@echo ''
	@echo 'Hei ITK! :)'
	@echo 'I fila ../config/billig.yml kan dere endre `billig_message_no` og'
	@echo '`billig_message_en` til meldingene som skal komme når billig er nede'
	@echo ''
	@echo '`billig_offline` sier om billig er online eller offline. Om den er true er det offline'
	@echo 'Denne makefila har funksjonene `take_offline` og `take_online` for å gjøre dette mer sømløst'
	@echo ''
	@echo '**********************************************************************************************'

.PHONY: take_online
take_online:
	sed -i.bak s/'billig_offline: true'/'billig_offline: false'/g ../config/billig.yml
	touch ../tmp/restart.txt

.PHONY: take_offline
take_offline:
	sed -i.bak s/'billig_offline: false'/'billig_offline: true'/g ../config/billig.yml
	touch ../tmp/restart.txt
