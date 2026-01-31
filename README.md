# Neovim Configuration

## Installation

```bash
git clone https://github.com/rluu/neovim-config.git
cd neovim-config
mkdir -p ~/.config/nvim/
cp nvim/init.lua ~/.config/nvim/
```

## Setup Steps

1. Open Neovim and run `:PlugInstall` to install the new plugins.
2. Restart Neovim. Mason will auto-install LSP servers listed in ensure_installed on first launch. You can check progress with `:Mason`.
3. Open a file in a supported language and the LSP should attach automatically.


## Java Language Server Protocol (LSP) Configuration

Java (jdtls) Details

Java uses nvim-jdtls instead of generic lspconfig. It activates automatically when you open a .java file. It detects the project root by searching upward for gradlew, pom.xml, mvnw, build.gradle, or .git. Each project gets its own workspace data directory under ~/.local/share/nvim/jdtls-workspace/. The config
includes common static import favorites for JUnit, Hamcrest, and Mockito.

