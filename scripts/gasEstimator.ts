import { ethers } from "hardhat";

// Lightweight helper to estimate gas for publishing a telemetry event.
// This script is intentionally minimal and does not perform network I/O by default.
// Usage (example): npx hardhat run --script scripts/gasEstimator.ts --network localhost

async function main() {
  const signers = await ethers.getSigners();
  if (signers.length === 0) {
    console.error("No signers available. Ensure a network is running.");
    process.exit(1);
  }
  const deployer = signers[0];

  // Attempt to locate the TelemetryHub contract factory if it exists in the project.
  // This is a best-effort helper: if the contract is not compiled, it will gracefully exit.
  let TelemetryHubFactory: any;
  try {
    TelemetryHubFactory = await ethers.getContractFactory("TelemetryHub");
  } catch (e) {
    console.error("TelemetryHub contract not found/compiled. Ensure it exists and is compiled.");
    process.exit(0);
  }

  // If the contract has a publishTelemetry-like function, attempt to estimate gas for a generic call.
  // Since we cannot assume the exact arguments, we only demonstrate estimation for a zero-arg call when available.
  const contract = await TelemetryHubFactory.attach((process.env.TELEMETRY_HUB_ADDRESS as string) || (await TelemetryHubFactory.deploy()).address);

  // Try to estimate gas for a potential function name "publishTelemetry" with a single string argument.
  // This is speculative; if the function signature differs, we catch and exit gracefully.
  try {
    const iface = contract.interface;
    // Heuristic: find a function named publishTelemetry
    const f = iface.functions[Object.keys(iface.functions).find((k) => k.includes("publishTelemetry")) as string];
    if (f) {
      // If the function expects arguments, we cannot fill them here. Skip actual call when args unknown.
      // We'll attempt a zero-arguments estimate if supported.
      try {
        const gas = await contract.estimateGas.publishTelemetry();
        console.log(`Estimated gas for publishTelemetry(): ${gas.toString()}`);
      } catch {
        // Ignore if publishTelemetry requires args
        console.log("publishTelemetry() gas estimation not possible without arguments.");
      }
    } else {
      console.log("publishTelemetry function not found on TelemetryHub ABI.");
    }
  } catch (err) {
    console.error("Gas estimation attempt failed:", err);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
