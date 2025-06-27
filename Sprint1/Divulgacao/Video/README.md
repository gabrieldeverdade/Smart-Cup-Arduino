# 🛠️ Sprint 1 - SmartCup (Wello)

**Trabalho Interdisciplinar V – Sistemas Computacionais | PUC Minas**

## 📌 Objetivo da Sprint

Nesta primeira sprint, o foco foi desenvolver e validar as ideias e o **do copo inteligente**, com o objetivo de medir automaticamente o consumo de água utilizando sensores de fluxo conectados a um microcontrolador. O desafio envolveu a montagem experimental através do **ThinkerCad**: calibração dos sensores, testes de precisão e primeiras decisões sobre a infraestrutura de hardware.

---

## 🔍 Descrição do Projeto

O SmartCup — posteriormente renomeado como **Wello** — é um copo inteligente equipado com um **sensor de fluxo de água** e um **microcontrolador ESP32**, porém até então na Sprint 1 seria um **Arduíno Uno**. A proposta central da Sprint 1 era garantir a coleta precisa do volume de água ingerido por meio de testes de fluxo e a integração básica com o software ThinkerCad.

A iniciativa surge como resposta ao problema da desidratação por esquecimento, substituindo o controle manual de ingestão de água por um sistema embarcado e automatizado, integrável via Bluetooth.

---

## ⚙️ Tecnologias e Componentes

### 🧩 Hardware

- **Arduino Uno** (substituido pelo ESP32 POSTERIORMENTE)
- **Sensor de fluxo YF-S201** (fluxo entre 1–30 L/min)
- **Bateria 18650** recarregável
- **Shield de carregamento com USB**
- **Display LCD (I²C)** (usado nos testes com Arduino Uno)
- Resistores e conexões básicas

---

## 🔬 Calibração e Testes

- Durante os testes com o sensor **YF-S201**, observou-se que:
  - **48 pulsos ≈ 100 ml de água**
  - **1 pulso ≈ 2,08 ± 0,09 ml**
- Os testes atingiram uma **acurácia de ~95,8%**, validando a viabilidade técnica do protótipo.

---

## 📶 Comunicação

- Decidiu-se pelo uso de **Bluetooth Low Energy (BLE)** via protocolo **Nordic UART**, visando:
  - Baixo consumo de energia
  - Compatibilidade com dispositivos móveis
  - Comunicação baseada em eventos (envio apenas quando há mudança no fluxo)

---

## 🧪 Resultados da Sprint

- ✅ Protótipo digital funcional com Arduíno Uno
- ✅ Sistema de medição confiável e preciso
- ✅ Primeira versão experimental
- ✅ Definição do protocolo de comunicação BLE
- ✅ Validação técnica de uso embarcado para ingestão de líquidos

---

## 📁 Arquivos Contidos no Projeto

- **Código**: Código utilizado para testes com arduíno
- **Divulgação**: Vídeo do teste com Arduíno e Slides da apresentação
- **Documentação**: Pasta LateX e PDF contendo o Artigo
