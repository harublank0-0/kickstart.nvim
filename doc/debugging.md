# Backend debugging: Next.js, AdonisJS, Node.js

The debugger pauses your backend inside handlers, controllers, middleware, and services. Inspect variables, request data, call stacks, and values returned by database queries. `debugger;` works on the backend too when a debugger is attached; editor breakpoints avoid changing source code.

## Start and attach

1. Open Neovim in the app directory (where its package.json lives).
2. Start ONE server in your terminal using an inspect command below.
3. Open a JS/TS/JSX/TSX file. Set a breakpoint with `Space b`.
4. Press `F5` or `Space d c`; select the Node.js backend configuration if prompted.
5. Enter the inspector port printed by Node (not the HTTP port, such as 3000).
6. Send the request / load the page that executes that backend code.

### Next.js — standard dev command

```sh
pnpm exec next dev --inspect
```

Usually inspector port 9229; use the actual `Debugger listening on ws://127.0.0.1:PORT/...` output.

### Yamjep — preserve its custom dev wrapper

```sh
NODE_OPTIONS='--inspect=0' pnpm dev
```

Port 0 assigns free inspector ports so pnpm, the wrapper, and Next's child server do not collide. Attach to the Next.js application server's inspector port, not pnpm's or the wrapper's. The app server's debugger line normally appears near its startup output. If unsure, visit `http://127.0.0.1:PORT/json/list` to inspect that target's title.

The wrapper currently does not forward `pnpm dev --inspect`. Restarting with random inspector ports requires detaching and attaching to the new port.

### AdonisJS

```sh
node ace --inspect serve --hmr
```

Usually inspector port 9229. For projects using the older watcher workflow, use `--watch` in place of `--hmr`.

### Plain Node.js

```sh
node --inspect server.js
# Pause before startup code executes:
node --inspect-brk server.js
```

## Controls

| Key | Action |
|---|---|
| `Space b` | Toggle breakpoint on current line |
| `Space B` | Conditional breakpoint, e.g. `user.id === 42` |
| `F5` / `Space d c` | Attach / continue |
| `F2` / `Space d n` | Step over a call |
| `F1` / `Space d i` | Step into a call |
| `F3` / `Space d o` | Step out of the current function |
| `Space d e` | Inspect expression under cursor or visual selection |
| `F7` | Toggle variables / watches / call-stack UI |
| `Space d q` | Detach and leave the server running |

The UI opens when you attach. Expand variables in Scopes, add expressions to Watches, and select Stack frames to inspect their locals. Requests can time out while the backend is paused.

## TypeScript and frontend code

Source maps are enabled. Next.js and AdonisJS development tooling supplies the mapping back to TS source. For your own compiled TypeScript, enable `sourceMap` in tsconfig and keep the matching emitted JavaScript and maps.

This configuration attaches to Node.js. Client-side React event handlers still run in the browser: use browser DevTools and `debugger;` there. Node-based Next.js route handlers, server actions, and server rendering can be debugged here.

If a breakpoint never pauses: trigger its code path, check that you attached to the app server, confirm the working directory and source maps, and check `:DapShowLog`. Check adapter installation with `:Mason` (js-debug-adapter).

Sources: [Next.js debugging](https://nextjs.org/docs/app/guides/debugging), [AdonisJS debugging](https://docs.adonisjs.com/guides/basics/debugging).
