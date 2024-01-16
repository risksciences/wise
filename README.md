# MacOS Install:

In MacOS, in addition to Conda, we need to have two more dependencies.
Xquartz is required to run GUI parts of Eclipse Sumo. Also, Homebrew is required
to manage FOX, a framework in which Sumo GUI apps are developed.
It is important to mention that FOX is not available via Conda, and that is why
we need Homebrew to install it.

Follow these steps:
1. Install Miniconda: https://docs.conda.io/projects/miniconda/en/latest/
2. Install XQuartz: https://www.xquartz.org/
3. Install Homebrew: https://github.com/Homebrew/brew/releases/download/4.2.3/Homebrew-4.2.3.pkg
4. Copy-paste this command into your terminal:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/risksciences/wise/macos/install.sh)"`
