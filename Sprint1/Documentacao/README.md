# 🚀 Sprint 2 - Smart Cup

**Projeto Interdisciplinar V - Sistemas Computacionais | PUC Minas**

Esta sprint teve como foco a validação do conceito técnico e o desenvolvimento inicial do protótipo do **Smart Cup**, um copo inteligente capaz de medir e monitorar o consumo de água em tempo real, integrando-se a um aplicativo mobile via Bluetooth.

---

## ✅ Entregas da Sprint

- Desenvolvimento do protótipo funcional com **Arduino Uno** e **sensor de fluxo YF-S401**
- Início do desenvolvimento do aplicativo mobile com **Flutter**
- Protótipo visual da interface no **Figma**
- Testes iniciais de conectividade e fluxo de dados
- Documento no formato SBC atualizado com:
  - Descrição da implementação
  - Resultados preliminares
  - Dificuldades enfrentadas
  - Propostas de solução

---

## 🔍 Principais Atividades Realizadas

### 🛠️ Hardware

- Montagem de circuito com Arduino Uno, sensor de fluxo, display LCD e resistores
- Testes de leitura de volume com base em pulsos convertidos para mililitros
- Identificação de ruídos e necessidade de filtro por média móvel
- Avaliação qualitativa de acurácia usando um copo medidor como referência
- Refatoração de material utilizado (Mudança para o ESP32)

### 📱 Aplicativo

- Estruturação de telas principais: boas-vindas, cadastro, dados pessoais e dashboard
- Prototipação em Figma com foco em usabilidade
- Codificação inicial das telas usando Flutter
- Testes iniciais de conexão via **Bluetooth (Flutter Blue Plus)**

### ⚙️ Integração e Planejamento

- Troca da abordagem Wi-Fi para Bluetooth por melhor adequação ao uso móvel
- Estudo de integração com Samsung Health (em andamento)
- Planejamento da modelagem física do copo com espaço para componentes
- Solicitação de uso de impressora 3D da PUC Minas para o protótipo final

---

## ⚠️ Dificuldades Enfrentadas

- **Conversão de pulsos em volume**: Necessidade de calibração manual
- **Ruído no sensor**: Instabilidade em baixos volumes mitigada com filtro de média
- **Conectividade**: Mudança de Wi-Fi para Bluetooth devido a limitações técnicas
- **Modelagem física**: Adaptação do design de copo para garrafa, visando espaço interno

---

## 📈 Resultados Preliminares

- Medições precisas a partir de 100ml de água ingerida
- Comunicação bem-sucedida entre hardware e dispositivo via comunicação serial
- Interface mobile iniciada e estruturada para futura integração com dados reais
- Validação técnica do conceito como base para as próximas sprints

---

## 👥 Integrantes

- Andre Santos Alves
- Bernardo D'Ávila Rodrigues Bartholomeu
- Gabriel Azevedo Fernandes
- Luis Henrique Dusanek Guedes
- Pedro Henrique Moreira

---

## 👨‍🏫 Professores Orientadores

- Matheus Alcântara Souza
- Rafael Henriques Nogueira Diniz
