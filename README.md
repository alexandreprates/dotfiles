# Dotfiles

Configurações pessoais para diferentes ambientes de desenvolvimento e sistemas operacionais.

## Estrutura

```
dotfiles/
├── install.sh              # Script principal de instalação
├── flavors/                 # Configurações específicas por ambiente
│   ├── mac/                # macOS
│   ├── cinnamon/           # Linux Desktop (Cinnamon)
│   ├── i3/                 # Linux Desktop (i3)
│   └── ubuntu_server/      # Ubuntu Server
└── oh_my_zsh/              # Temas customizados do Oh My Zsh
```

## Instalação

### Instalação Automática (Recomendada)

Execute o comando abaixo no seu terminal para instalar automaticamente:

```bash
curl -fsSL https://raw.githubusercontent.com/alexandreprates/dotfiles/master/install.sh | bash
```

Este comando irá:
1. Detectar automaticamente seu sistema operacional
2. Baixar o repositório para `$HOME/.dotfiles`
3. Executar o script de configuração apropriado

### Instalação Manual

1. Clone o repositório:
```bash
git clone https://github.com/alexandreprates/dotfiles.git $HOME/.dotfiles
```

2. Execute o script de instalação:
```bash
cd $HOME
$HOME/.dotfiles/install.sh
```

### Forçar um Flavor Específico

Você pode forçar a instalação de um flavor específico:

```bash
$HOME/.dotfiles/install.sh mac          # Força macOS
$HOME/.dotfiles/install.sh i3           # Força i3
$HOME/.dotfiles/install.sh cinnamon     # Força Cinnamon
$HOME/.dotfiles/install.sh ubuntu_server # Força Ubuntu Server
```

## Flavors Disponíveis

### macOS (`mac`)
- Configurações para macOS usando Homebrew
- Inclui aliases, funções e configurações do Zsh
- Instala Go2Dir automaticamente

### Linux Desktop Cinnamon (`cinnamon`)
- Configurações para desktop Linux com Cinnamon
- Inclui configurações do Albert, Plank e outros
- Temas e customizações visuais

### Linux Desktop i3 (`i3`)
- Configurações para i3 window manager
- Scripts para gerenciamento de bateria, brilho, volume
- Configurações do Rofi e Dunst

### Ubuntu Server (`ubuntu_server`)
- Configurações minimalistas para servidor
- Apenas configurações de terminal e shell
- Instalação automática de pacotes via apt

## Como Funciona

O sistema usa symlinks para conectar os arquivos de configuração do repositório aos locais esperados pelo sistema:

- Arquivos em `flavors/{flavor}/home/` são linkados para `$HOME/`
- Arquivos com prefixo `_` se tornam arquivos ocultos (`.`)
- Exemplo: `_zshrc` → `~/.zshrc`

Arquivos existentes são automaticamente backup com extensão `.original`.

## Estrutura dos Flavors

Cada flavor pode conter:

```
flavor_name/
├── configure.sh         # Script de configuração específico
├── packages.txt         # Lista de pacotes para instalar
├── home/               # Arquivos que vão para $HOME/
│   ├── _zshrc          # → ~/.zshrc
│   ├── _bash_aliases   # → ~/.bash_aliases
│   └── _config/        # → ~/.config/
└── etc/                # Arquivos de sistema (requer sudo)
```

## Personalização

1. Fork este repositório
2. Modifique os arquivos em `flavors/` conforme necessário
3. Atualize a URL do repositório no `install.sh` (linha 34 e 112)
4. Commit e push suas alterações

## Requisitos

- **Git** (recomendado) ou **curl/wget** para download
- **Bash** ou **Zsh**
- **unzip** para extração (se Git não estiver disponível)

### macOS
- **Homebrew** para instalação de pacotes

### Linux
- **dialog** para interface de seleção (Cinnamon/i3)
- **apt** para Ubuntu Server

## Comandos Úteis

```bash
# Verificar status do repositório
cd $HOME/.dotfiles && git status

# Atualizar dotfiles
cd $HOME/.dotfiles && git pull

# Reinstalar flavor atual
$HOME/.dotfiles/install.sh

# Ver ajuda
$HOME/.dotfiles/install.sh --help
```

## Troubleshooting

### "Dotfiles directory not found"
Certifique-se de que o repositório está clonado em `$HOME/.dotfiles`

### "Permission denied"
Verifique se os scripts têm permissão de execução:
```bash
chmod +x $HOME/.dotfiles/install.sh
chmod +x $HOME/.dotfiles/flavors/*/configure.sh
```

### Symlinks quebrados
Execute novamente o script de instalação para recriar os symlinks

## Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Add nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request


