# Respostas do Questionário sobre Gerenciamento de Estado

**1. O que significa gerenciamento de estado em uma aplicação Flutter?**
O gerenciamento de estado refere-se a como os dados e as configurações (o estado) de uma aplicação são gerados, modificados, armazenados e refletidos na interface visual. É a "ponte" que cuida para que as atualizações na camada de lógica de negócios se comuniquem corretamente com os componentes visuais, garantindo uma interface reativa que espelha exatamente a condição da aplicação em  um dado momento.

**2. Por que manter o estado diretamente dentro dos widgets pode gerar problemas em aplicações maiores?**
Manter estados puramente dentro de `StatefulWidgets` (usando `setState()`) leva a um problema grave conhecido como "Prop Drilling": uma forte necessidade de repassar propriedades por muitos ancestrais apenas para que um widget lá embaixo na árvore possa acessá-la. Isso gera alto acoplamento (lógica agarrada à UI visual), dificulta bastante a criação de testes e pode causar degradação de processamento através de builds desnecessários e duplicados.

**3. Qual é o papel do método `notifyListeners()` na abordagem Provider?**
A função principal do `notifyListeners()` é alertar aos interessados na classe de estado (seja via `Consumer` ou `context.watch()`) de que variáveis internas dessa classe foram alteradas de alguma forma (como o alternador visual de adicionar e remover favoritos, por exemplo). Assim que os componentes de escuta ("listeners") na árvore recebem esse aviso, o Flutter cuida de pedir que apenas aquelas estruturas visuais específicas efetuem a renderização novamente com o novo valor de forma inteligente.

**4. Qual é a principal diferença conceitual entre Provider e Riverpod?**
A maior diferença estrutural se dá pelo fato de que o `Provider` depende amplamente de contexto e reside estritamente ligado dentro da própria *Widget Tree* — o que pode acabar ocasionando exceções por contextos não disponíveis ("ProviderNotFoundException"). Já o `Riverpod` é projetado para criar instâncias "globais" da aplicação declaradas independentemente da árvore de widgets. Devido a serem acessados forâ da classe e verificados em tempo de compilação, o Riverpod garante completa segurança perante ausências do tipo Null Pointer e resolvem com mais facilidade referências circulares e dados assíncronos.

**5. No padrão BLoC, por que a interface não altera diretamente o estado da aplicação?**
Pela essência fundamental de separação do BLoC, a tela existe puramente com propósito decorativo sob uma estrita regra de reatividade. A UI jamais muta dados próprios; ela reage a "Estados" despachados e, quando demandado, injeta "Eventos" dentro da Stream do seu BLoC equivalente informando uma *"intenção do que necessita que seja feito"*, permitindo que o controlador pegue a tarefa, gere validações externas invisíveis  e jorre do lado de fora os novos resultados de volta a interface. 

**6. Considere o fluxo do padrão BLoC: `Evento -> Bloc -> Novo estado -> Interface`. Qual é a vantagem de organizar o fluxo dessa forma?**
Esta característica garante que o racíocinio obedeça um "Fluxo Unidirecional de Dados". As principais vantagens são o extremo controle de rasteamento e reprodutibilidade (depuração fácil de bugs testando os insumos na exata sequência cronológica efetuada), além de dar poder de total aproveitamento na hora do teste e grande re-aproveitamento através do projeto por manter a mente em que o BLoC é autônomo perante plataformas ou visuais distintos.

**7. Qual estratégia de gerenciamento de estado foi utilizada em sua implementação?**
Em nossa implementação do projeto da lista de produtos e favoritos, adotamos o padrão **Provider**. 

**8. Durante a implementação, quais foram as principais dificuldades encontradas?**
Apesar da implementação do Provider seguir um design de baixo escalonamento e de fácil interpretação inicial através do `ChangeNotifier`, garantir qual a abrangência correta através da árvore costuma acarretar dúvidas pontuais, como alocar a instância de forma ampla no `MultiProvider` no mais alto nível (a raiz da main `MyApp`)  e ter o desafio de identificar através desse layout se o uso estrito do wrapper `Consumer<ProductProvider>` estaria otimizado na AppBar ao construir os contadores, poupando assim comutação inteira de scaffolds.
