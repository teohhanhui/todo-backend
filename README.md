# todo-backend (NodeJS)

## Develop

Use the [dev container] provided: [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json)

[dev container]: https://containers.dev/

### Visual Studio Code

Install the [Dev Containers extension] and its prerequisites.

It should automatically detect the dev container:

> Folder contains a Dev Container configuration file. Reopen folder to develop in a container

Choose "Reopen in Container".

[Dev Containers extension]: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

### Dev Container CLI

#### Install

```bash
npm install -g @devcontainers/cli
```

#### Create and run dev container

```bash
devcontainer up --workspace-folder .
```

The program should be accessible at http://localhost:3000

#### Execute shell in dev container

```bash
devcontainer exec --workspace-folder . bash
```
