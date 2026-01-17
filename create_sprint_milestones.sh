#!/bin/bash

# Calculate dates (starting from today)
BASE_DATE="2026-01-17"

# Sprint 0: 1 week
SPRINT_0_END=$(date -d "$BASE_DATE + 7 days" +%Y-%m-%d)

# Sprint 1: 2 weeks (after Sprint 0)
SPRINT_1_END=$(date -d "$BASE_DATE + 21 days" +%Y-%m-%d)

# Sprint 2: 2 weeks
SPRINT_2_END=$(date -d "$BASE_DATE + 35 days" +%Y-%m-%d)

# Sprint 3: 2 weeks
SPRINT_3_END=$(date -d "$BASE_DATE + 49 days" +%Y-%m-%d)

# Sprint 4: 2 weeks
SPRINT_4_END=$(date -d "$BASE_DATE + 63 days" +%Y-%m-%d)

# Sprint 5: 1 week
SPRINT_5_END=$(date -d "$BASE_DATE + 70 days" +%Y-%m-%d)

# Sprint 6: 1 week
SPRINT_6_END=$(date -d "$BASE_DATE + 77 days" +%Y-%m-%d)

echo "Creating Sprint Milestones..."

# Delete existing Sprint 1 milestone to recreate with proper name
gh api -X DELETE repos/arbgjr/satra/milestones/1 2>/dev/null || true

# Sprint 0
gh api repos/arbgjr/satra/milestones -f title="Sprint 0 - Infrastructure & Setup" \
  -f description="Preparar repositório, CI/CD e ambiente de desenvolvimento" \
  -f due_on="${SPRINT_0_END}T23:59:59Z" -f state=open
echo "✓ Sprint 0 created (due: $SPRINT_0_END)"

# Sprint 1
gh api repos/arbgjr/satra/milestones -f title="Sprint 1 - Data Ingestion" \
  -f description="Implementar ingestão de dados da Alpha Vantage com cache" \
  -f due_on="${SPRINT_1_END}T23:59:59Z" -f state=open
echo "✓ Sprint 1 created (due: $SPRINT_1_END)"

# Sprint 2
gh api repos/arbgjr/satra/milestones -f title="Sprint 2 - Volatility Metrics" \
  -f description="Implementar cálculo de ATR e Desvio Padrão" \
  -f due_on="${SPRINT_2_END}T23:59:59Z" -f state=open
echo "✓ Sprint 2 created (due: $SPRINT_2_END)"

# Sprint 3
gh api repos/arbgjr/satra/milestones -f title="Sprint 3 - Alert System" \
  -f description="Implementar motor de alertas e avaliação de regras" \
  -f due_on="${SPRINT_3_END}T23:59:59Z" -f state=open
echo "✓ Sprint 3 created (due: $SPRINT_3_END)"

# Sprint 4
gh api repos/arbgjr/satra/milestones -f title="Sprint 4 - Dashboard UI" \
  -f description="Implementar interface de usuário e dashboard" \
  -f due_on="${SPRINT_4_END}T23:59:59Z" -f state=open
echo "✓ Sprint 4 created (due: $SPRINT_4_END)"

# Sprint 5
gh api repos/arbgjr/satra/milestones -f title="Sprint 5 - Notifications" \
  -f description="Implementar notificações multi-canal (Email, Push, SMS, Telegram)" \
  -f due_on="${SPRINT_5_END}T23:59:59Z" -f state=open
echo "✓ Sprint 5 created (due: $SPRINT_5_END)"

# Sprint 6
gh api repos/arbgjr/satra/milestones -f title="Sprint 6 - Polish & QA" \
  -f description="Polimento, testes E2E, testes de carga e preparação para produção" \
  -f due_on="${SPRINT_6_END}T23:59:59Z" -f state=open
echo "✓ Sprint 6 created (due: $SPRINT_6_END)"

echo ""
echo "All sprint milestones created!"
echo ""
gh api repos/arbgjr/satra/milestones --jq '.[] | "\(.number): \(.title) (due: \(.due_on))"'
