# Pesquisas do Projeto - Sistema de Alertas B3

Este diretório contém pesquisas de domínio realizadas para o projeto de Sistema de Alertas de Volatilidade para ativos da B3.

## Índice de Pesquisas

### 📊 Métricas de Volatilidade
**Data:** 2026-01-17
**Pesquisador:** @domain-researcher

- **Resumo Executivo (MD):** [`volatility-metrics-summary.md`](./volatility-metrics-summary.md)
- **Dados Completos (YAML):** [`volatility-metrics-research.yml`](./volatility-metrics-research.yml)
- **No Corpus RAG:** `.agentic_sdlc/corpus/research/volatility-metrics-b3.yml`

**Principais Achados:**
- ATR (Average True Range) é a métrica ideal para tier gratuito
- Alpha Vantage fornece ATR e Bollinger Bands pré-calculados gratuitamente
- Bollinger Squeeze é estratégia comprovada para detectar breakouts
- Volatilidade Implícita é inviável para free tier (requer dados de opções pagos)

**Recomendações:**
1. **Free Tier:** ATR(14) + Desvio Padrão Histórico (30 dias)
2. **Premium Tier:** + Bollinger Bands + Beta vs Ibovespa
3. **Futuro:** Volatilidade Implícita (apenas se houver demanda validada)

**Prioridades de Implementação:**
1. ATR(14) - 2-3 dias
2. Desvio Padrão - 1-2 dias
3. Bollinger Bands - 3-4 dias
4. Beta - 2-3 dias
5. Vol Implícita - 5-7 dias (opcional)

---

## Como Usar Este Diretório

### Para Desenvolvedores

```bash
# Ver resumo visual
cat volatility-metrics-summary.md

# Processar dados estruturados
python3 -c "import yaml; print(yaml.safe_load(open('volatility-metrics-research.yml')))"

# Consultar via RAG
python3 ../../.claude/skills/rag-query/scripts/query_corpus.py \
  --keywords "volatilidade" "ATR" "B3" \
  --sources "research" \
  --limit 5
```

### Para Product Owners

- **Decisões de Produto:** Use `volatility-metrics-summary.md` seção "Recomendações"
- **Roadmap:** Seção "Plano de Implementação" com estimativas
- **Justificativas:** Seção "Por que é ideal para FREE/PREMIUM TIER"

### Para QA/Validação

- **Referências Oficiais:** Seção "Referências Principais"
- **Fórmulas de Validação:** Cada métrica tem seção "Cálculo" detalhada
- **Dados de Teste:** Validar contra dados oficiais da B3

---

## Estrutura de Arquivos

```
research/
├── README.md                           # Este arquivo
├── volatility-metrics-summary.md       # Resumo visual (markdown)
├── volatility-metrics-research.yml     # Dados estruturados (YAML)
└── [futuras-pesquisas]/
```

---

## Próximas Pesquisas Planejadas

- [ ] **Fontes de Dados Gratuitas:** Deep dive em BrAPI vs Alpha Vantage vs Twelve Data
- [ ] **Thresholds de Alertas:** Análise de percentis históricos para mercado brasileiro
- [ ] **Estratégias de Trading:** Backtesting de Bollinger Squeeze em ativos B3
- [ ] **Latência de APIs:** Medição real de delay em diferentes horários
- [ ] **Custos de Dados Pagos:** Análise de custo/benefício de APIs premium

---

**Última Atualização:** 2026-01-17
**Mantido por:** @domain-researcher
