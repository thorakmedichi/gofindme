# Setup

Install [Node](https://nodejs.org/en)

Install [npx](https://github.com/npm/npx#readme)

`npm install -g npx`


Install [PNPM](https://pnpm.io/installation)

`npm install -g pnpm`


Install [Lerna](https://lerna.js.org/docs/getting-started)

`npm install --g lerna`


# Adding libraries to the packages or apps

ie `pnpm add --filter @gofindme/components react`


# Lerna commands
[Commands](https://lerna.js.org/docs/api-reference/commands)

`lerna add <package>[@version] [--dev] [--exact] [--peer]`

# Resources

[Lerna: Getting started](https://lerna.js.org/docs/getting-started)
[Lerna: Example repo](https://github.com/lerna/getting-started-example/blob/main/packages/header/rollup.config.js)
[Remix: Best monorepo guide](https://blog.nrwl.io/setup-a-monorepo-with-pnpm-workspaces-and-speed-it-up-with-nx-bc5d97258a7e)
[Remix: Setting up a monorepo](https://blog.nrwl.io/setup-a-monorepo-with-pnpm-workspaces-and-speed-it-up-with-nx-bc5d97258a7e)
[Typescript monorepo setup](https://medium.com/@NiGhTTraX/how-to-set-up-a-typescript-monorepo-with-lerna-c6acda7d4559)


# Notes

- Yarn does not work with Remix. Chose PNPM over NPM as it is safer and uses less HD space for modules.


# Questions

- Should I use rollup instead of just tsc?
- 
