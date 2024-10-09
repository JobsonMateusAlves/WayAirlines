# WayAirlines
![iOS version](https://img.shields.io/badge/iOS-15\+-blue) ![Swift version](https://img.shields.io/badge/Swift-v5.9-orange)

## Visão geral do projeto
WayAirlines é uma aplicação desenvolvida auxiliar na gestão e acompanhamento dos voos. A principal funcionalidade é uma lista completa de voos, onde o usuário pode filtrar entre as seguintes categorias: voos concluídos, cancelados, em andamento, e a realizar.

Além disso, o sistema oferece uma funcionalidade que destaca de forma intuitiva o próximo voo a ser realizado, permitindo ao usuário visualizar facilmente as informações essenciais e se preparar para a próxima viagem.

## Tecnologias Utilizadas
- Linguagem: Swift 
- Framework: UIKit 
- Abordegem: ViewCode para construção de layout.
- Arquitetura: Clean Architecture e MVVM com Coordinators

## Decisões Tecnicas

As decisões tomadas no desenvolvimento deste projeto de teste foram pensadas para simular um projeto profissional.

Abordagem:

Opto pela Utilização do ViewCode para garantir maior controle sobre a construção da interface e facilitação da manutenção e personalização do layout programaticamente. Além disso, em um projeto profissional onde há vários profissionais essa abordagem evita conflitos em arquivos .storyboard e .xibs.

 
Arquitetura:

Optei pela utilização da Clean Architecture para garantir um codigo organizado, escalável e testável.

O padrão MVVM permite uma melhor organização da camada de apresentação possibilitando remover da Controller as responsabilidades como gerenciamento de estados e comunicação com a camada de lógica de negócios.

O padrão Coordinators permite que a resposabilidade da navegação seja delegada para os coordinators, que gerenciam o fluxo de navegação de forma independente.

Serviço:

Foi criado um provider ja preparado para a utilização em requisições reais mas, como solicitado, o app utiliza as informações do arquivo flights.json. Para isso foi criado um MockURLSession que é responsavel pela leitura do arquivo e é passado como dependencia para o Provider que utiliza esta classe como se fosse um URLSession comum.
