# onchain-telemetry-hub

A Solidity-based telemetry tool that samples on-chain events, aggregates metrics, and emits gas-aware dashboards for dApp operators.

Topics: solidity, gas, monitoring, tools

Tagline: Measure per-call gas, event latency, and contract health to optimize UX and deployment costs.

## Outline

- Architecture overview
- Local development stack
- Contracts
- Tests
- Deployment
- Extending the telemetry surface

## Quickstart (Hardhat)

1) Install

- Node.js >= 16
- yarn or npm

2) Install dependencies

- npm install

3) Configure environment

- Copy .env.example to .env and set RPC_URLs and private keys as needed

4) Compile

- npx hardhat compile

5) Test

- npm run test

6) Deploy

- npm run deploy (requires env vars for RPC and keys)

## Deployment

- Deploys TelemetryHub with an initial sampling interval
- Sets up admin and operator roles; operator can emit telemetry events

## Notes

- This project focuses on safety: access control, explicit role management, and minimal upgrade risk in a compact contract.
- Gas-conscious telemetry events help build dashboards for operators without leaking excessive on-chain state.
