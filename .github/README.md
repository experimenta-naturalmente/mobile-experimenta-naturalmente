# CI/CD (GitHub Actions)

Este diretório contém os workflows de integração e build do app Flutter `turismo_rural_frontend`.

## Workflows

| Arquivo | Runner | Dispara em | O que faz |
| --- | --- | --- | --- |
| `workflows/ci.yml` | `ubuntu-latest` | push (main/develop) e pull_request | `flutter analyze` + `flutter test` |
| `workflows/build-android.yml` | `ubuntu-latest` | push (main/develop) e execução manual | Gera APK e AAB (release) e publica como artefatos |
| `workflows/build-ios.yml` | `macos-latest` | push (main/develop) e execução manual | Gera a pasta `ios/`, compila sem assinatura e publica `app-unsigned.ipa` |
| `workflows/build-web.yml` | `ubuntu-latest` | push (main) e execução manual | Builda a imagem Docker da versão web e publica no GHCR (`experimenta-saochico-web`) |

Os builds também podem ser disparados manualmente em **Actions > (workflow) > Run workflow** (`workflow_dispatch`).

## Secrets necessários

Configure em **Settings > Secrets and variables > Actions > New repository secret**.

O app carrega o arquivo `.env` como asset (ver `pubspec.yaml`), mas o `.env` é ignorado pelo Git (`*.env`). Por isso os workflows recriam o `.env` a partir dos secrets abaixo antes de cada build.

| Secret | Obrigatório | Usado em | Descrição |
| --- | --- | --- | --- |
| `API_URL` | Sim | Android, iOS, CI, Web | URL base da API REST (ex.: `https://api.experimentasaochico.com.br/`) |
| `GOOGLE_MAPS_API_KEY` | Sim | Android, iOS, Web | Chave do Google Maps (injetada no manifest Android e no `AppDelegate` iOS) |

> O upload de imagens migrou para o backend próprio (`POST /upload` -> MinIO); os secrets `AWS_*` foram removidos. As credenciais AWS que estavam versionadas no `.env` devem ser **rotacionadas/revogadas**.

## Como instalar o build iOS no iPad SEM conta Apple Developer paga (a partir do Windows)

O GitHub Actions consegue **compilar** o iOS, mas a Apple exige assinatura para instalar em aparelho físico. Sem conta paga, o caminho gratuito é reassinar o `.ipa` não assinado com o seu **Apple ID gratuito** usando o **Sideloadly** (ou AltStore) no seu PC Windows.

Limitações do Apple ID gratuito: a assinatura expira em ~7 dias (é preciso reinstalar) e só funciona nos seus próprios aparelhos.

Passo a passo (Sideloadly):

1. No GitHub, abra **Actions > build-ios > Run workflow** (ou aguarde um push) e, ao terminar, baixe o artefato `app-unsigned-ipa`.
2. No PC Windows, instale o **Sideloadly** (https://sideloadly.io) e o **iTunes** (necessário para os drivers USB da Apple).
3. Conecte o iPad via USB e toque em **Confiar** neste computador.
4. Abra o Sideloadly, selecione o iPad, arraste o arquivo `app-unsigned.ipa` e informe o seu **Apple ID gratuito** (o Sideloadly reassina e registra um App ID temporário automaticamente).
5. Clique em **Start** e aguarde a instalação concluir.
6. No iPad, vá em **Ajustes > Geral > Gerenciamento de VPN e Dispositivo**, toque no seu perfil de desenvolvedor (seu Apple ID) e confie nele.
7. Abra o app. Reinstale a cada ~7 dias (limite da conta gratuita).

Alternativa: **AltStore** + **AltServer** no Windows reinstala automaticamente por Wi-Fi enquanto o PC estiver ligado na mesma rede, reduzindo o incômodo da expiração de 7 dias.

> Para distribuir para outras pessoas (TestFlight/App Store) é obrigatória uma conta Apple Developer paga (US$ 99/ano).
