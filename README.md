# Bronte

[![Bitcoin](https://img.shields.io/badge/bitcoin-FF9900?logo=bitcoin&logoColor=white)](https://twentyone.world)
[![Sui](https://img.shields.io/badge/sui-4DA2FF?logo=sui&logoColor=white)](https://sui.io)
[![Top](https://img.shields.io/github/languages/top/krutt/bronte)](https://github.com/krutt/bronte)
[![Languages](https://img.shields.io/github/languages/count/krutt/bronte)](https://github.com/krutt/bronte)
[![Size](https://img.shields.io/github/repo-size/krutt/bronte)](https://github.com/krutt/bronte)
[![Last commit](https://img.shields.io/github/last-commit/krutt/bronte/master)](https://github.com/krutt/bronte)

![Bronte Banner](static/bronte-banner.svg)

## Introduction

Bronte, Thunder; Bestower in Gaelic, is a set of [MoveVM](https://medium.com/@bucketprotocol/a-deep-dive-into-the-pros-and-cons-of-evm-solana-and-move-blockchains-879a4d942ee4) programs written for the atomic swapping assets between [Bitcoin](https://twentyone.world) with stable assets.
for the SUI Resource-Oriented Architecture. 

## Prerequisites

* posix terminal
* python (3.9 and up)

## Getting started

This project makes use of the combination of [aesir](https://pypi.org/project/aesir) and [acqua](https://pypi.org/project/acqua)
command line tools for development environment setup as well as the
[sui move](https://formulae.brew.sh/formula/sui) compiler.

```sh
pip install aesir
pip install acqua
# and
brew install sui  # Linux, WSL or macOS
# or
choco install sui  # Windows
```

## Contributions

Deploy local SUI validator as such with `acqua` command.

```
acqua deploy --devnet
aesir deploy --duo  # cluster consisting of two LND nodes
```

Publish `bronte` on to the local `devnet` environment.

```sh
tbd;
```

Generate locked asset on the SUI ROA.

```sh
tbd;
```

### Run tests

```sh
$ sui move test
> ...
```

## Move Blockchain State

![blockchain-state](static/move-blockchain-state.png)

<center>
Figure 1: Move Blockchain State by Greg Shen, Bucket Protocol.
</center>

## Acknowledgements

1. [SOV Tejo](https://www.f0nt.com/release/sov-tejo) typeface by [Worawut Thanawatanawich](https://facebook.com/worawut.thanawatanawanich)
2. [Boltz - Non-custodial Bitcoin Bridge](https://boltz.exchange)
3. [Adam Bor](https://github.com/adambor) from [Atomiq](https://atomiq.exchange)
4. [Greg Shen](https://tw.linkedin.com/in/greg-shen-b43527252) from [Bucket Protocol](https://medium.com/@bucketprotocol)

## License

This project is licensed under the terms of the MIT license.
