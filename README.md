# rf_advantageonlineshopping
Este projeto contém testes automatizados de cenários web e API para o site [Advantage Online Shopping](https://advantageonlineshopping.com/#/). Os testes foram escritos utilizando o **Robot Framework** e seguem as melhores práticas de automação.

# Projeto de Automação - Advantage Online Shopping

Este projeto contém testes automatizados de cenários web e API para o site [Advantage Online Shopping](https://advantageonlineshopping.com/#/). Os testes foram escritos utilizando o **Robot Framework** e seguem as melhores práticas de automação.

## Requisitos

Para executar os testes, você precisará instalar as seguintes ferramentas:

- [Python 3.x](https://www.python.org/downloads/)
- [Robot Framework](https://robotframework.org/)
- [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/)
- [RequestsLibrary](https://github.com/MarketSquare/robotframework-requests)
- [ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver/downloads) (ou o driver de navegador correspondente ao que você utilizará)
- [Git](https://git-scm.com/) (para clonar o projeto)

## Instalação

### 1. Clonar o repositório:

```bash
git clone https://github.com/jjocara/rf_advantageonlineshopping.git
cd rf_advantageonlineshopping

### 2. Instalar as dependências:

pip install -r requirements.txt

Configurar o ChromeDriver

## Execução dos Testes
### Testes Web
Para executar os testes web:
robot tests/web_tests.robot

### Testes de API
Para executar os testes de API:
robot tests/api_tests.robot


## Dependências
O arquivo requirements.txt contém todas as bibliotecas necessárias para a execução dos testes:
robotframework==6.0
robotframework-seleniumlibrary==6.0.0
robotframework-requests==0.9.3
selenium==4.10.0

