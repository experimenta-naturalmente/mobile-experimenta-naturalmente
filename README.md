# Configurando o ambiente de desenvolvimento

## 1. Android Studio

- Download do **Android Studio** em [https://developer.android.com/studio](https://developer.android.com/studio).
- Durante a instalação, certifique-se de selecionar os seguintes componentes:
```
   Android SDK Platform
   Android SDK Command-line Tools
   Android SDK Build-Tools
   Android SDK Platform-Tools
   Android Emulator
```
## 2. SDK do Flutter
- Download do SDK do Flutter em [Flutter SDK archive](https://docs.flutter.dev/release/archive?tab=windows).
- Extraia o arquivo para um local qualquer (e.g., `C:\Flutter`).
- Adicione nas variáveis de ambiente do sistema.
    - Abra as variáveis de sistema no menu iniciar (i.e., digitando 'var' e enter).
    - Selecione a variável **Path** em usuários ou sistema, e aperte editar.
    - Adicione o dirétorio do SDK do Flutter concatenando com **\bin** (e.g. `C:\Flutter\bin`).
- Execute `flutter doctor` no terminal para verificar a instalação.

## 3. Escolha um editor

### VS Code (Recomendado)

- Download do VS Code em [https://code.visualstudio.com/](https://code.visualstudio.com/).
- Instale as extensões do Flutter e do Dart no menu à esquerda.
- Use a opção `Dart: Use Recommended Settings` acessando `CTRL + SHIFT + P`.

### Android Studio

- Pode ser mais conveniente já que a IDE é integrada com o emulador android.

## 4. Configurações Finais

- Execute `flutter pub get` para baixar as dependências necessárias.
- Execute `dart run husky install` para inicializar o husky (nossa ferramenta que gerencia git hooks).
- Crie um arquivo `.env` na raiz do projeto para as variáveis de ambiente. Se foi criada corretamente, deve estar sendo ignorado pelo git.
- (Recomendado) Instale o plugin do GitHub Copilot no editor ou IDE escolhida. Alunos da PUCRS têm acesso gratuito a partir do [GitHub Education](https://education.github.com/).

# Executando o projeto

### VS Code

Pode executar o projeto utilizando dispositivo físico ou emulador. Lembre-se que é importante que o aplicativo esteja responsivo e funcional em telas de diversos tamanhos.
- **Smartphone Android:** Desbloqueie o modo desenvolvedor conforme [aqui](https://developer.android.com/studio/debug/dev-options) e habilite USB debugging/depuração USB.
- **Emulador:**
  - Abra o Android Studio.
  - Acesse Virtual Device Manager.
  - Crie um dispositivo virtual (recomendado: **Pixel 7** e **VanillaIceCream**).
  - Inicie o emulador.
- Escolha o dispositivo de execução no menu inferior direito (OBS: Utilizar navegador como dispositivo é apenas para deploy web e não nos serve.).
- Execute o projeto com `flutter run --dart-define-from-file=.env` ou apertando F5.

# Padrões de desenvolvimento

## Conventional Commits
Estamos utilizando o padrão [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) baseado em [@commitlint/config-conventional](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines). 
- Os commits devem seguir `<tipo>(<escopo>): <mensagem>`;
- Escopo é a abreviação da user story com hífen e dois dígitos (e.g., us-01); 
- Mensagens de commit não podem ultrapassar 72 caracteres e devem ser escritas no imperativo; 
- Tipo é conforme abaixo:
```
build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
ci: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
docs: Documentation only changes
feat: A new feature
fix: A bug fix
perf: A code change that improves performance
refactor: A code change that neither fixes a bug nor adds a feature
style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
test: Adding missing tests or correcting existing tests
```

## Merge Requests

O título do merge request deve seguir o mesmo formato acima. Os MRs precisam passar todos os jobs no pipeline e, após isso, podem ser mergeados por um AGES III. É obrigatório submeter o MR no formato definido pelo template.

## Branches

As branches para desenvolvimento devem ser feitas a partir da `develop`. Os nomes de branch devem seguir `<tipo>/<escopo>/<descrição>`, onde a descrição **deve ser breve** e com hífen no lugar dos espaços. Tipo e escopo são definidos conforme dito anteriormente.