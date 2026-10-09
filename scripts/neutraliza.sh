#!/usr/bin/env bash
# Uso: ./neutraliza.sh "Roadmap ... .md" > ROADMAP.md
# Sustituye el vocabulario del dominio por términos neutros en el export del Claude Doc.
sed -E \
  -e 's/taxi-ledger-mcp/fleet-ledger-mcp/g' \
  -e 's/del taxi/de la flota/g' \
  -e 's/de los taxis/de la flota/g' \
  -e 's/dominio taxi/dominio flota/g' \
  -e 's/casuística de taxis/casuística de la flota/g' \
  -e 's/[Tt]axímetro/contador del vehículo/g' \
  -e 's/taxis/vehículos/g' \
  -e 's/taxi/vehículo/g' \
  -e 's/Uber Fleet Hub/plataforma A/g' \
  -e 's/FreeNow/plataforma B/g' \
  -e 's/Uber/plataforma A/g' \
  -e 's/gestoría/asesoría/g' \
  -e 's/· @[A-Za-z]+$//' \
  "$1"
