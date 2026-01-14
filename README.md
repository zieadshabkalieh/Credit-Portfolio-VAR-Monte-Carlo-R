# Credit Portfolio VaR Simulation (Monte Carlo) in R

Monte Carlo simulation engine in **R** to model **credit portfolio losses** using **PD / LGD / EAD** inputs and estimate **Value-at-Risk (VaR)** at multiple confidence levels (e.g., 95% and 99%) from the simulated loss distribution.

This project generates a loss distribution by repeatedly simulating default events and loss severities, then extracts VaR as a high quantile (percentile) of losses — consistent with VaR estimation via Monte Carlo and percentile/quantile selection described in academic risk frameworks.

---

## Table of Contents
- [Overview](#overview)
- [Model Inputs](#model-inputs)
- [Methodology](#methodology)
- [Repository Structure](#repository-structure)
- [How to Run](#how-to-run)
- [Outputs](#outputs)
- [How to Customize](#how-to-customize)
- [Notes & Assumptions](#notes--assumptions)
- [Cite / Attribution](#cite--attribution)
- [License](#license)

---

## Overview
The goal is to estimate **portfolio tail risk** by simulating many possible credit-loss outcomes and computing:
- **Loss distribution** (histogram / density)
- **VaR at confidence level α** (e.g., α = 0.95, 0.99)

**VaR(α)** answers:
> “What is the maximum expected loss that will not be exceeded with probability α over the chosen horizon?”

---

## Model Inputs
For each obligor (loan/exposure) in the portfolio:
- **PD**: Probability of Default
- **LGD**: Loss Given Default
- **EAD**: Exposure at Default

Optional / advanced extensions (future work):
- Correlated defaults (copula, Cholesky correlation matrix)
- Stochastic PD / stochastic LGD (beta distributions, macro-factor model)

---

## Methodology
1. **Initialize** portfolio exposures and risk parameters (PD, LGD, EAD).
2. **Simulate** defaults for each obligor using a Bernoulli trial:
   - Default ~ Binomial(1, PD)
3. **Accumulate losses**:
   - If default occurs: Loss += EAD × LGD
4. **Repeat** the simulation many times (e.g., 10,000 runs) to obtain a **loss distribution**.
5. **Estimate VaR**:
   - Sort simulated losses and select the **α-quantile** (percentile).
   - Example: VaR(0.99) is the 99th percentile of simulated losses.

This follows the standard Monte Carlo VaR idea: generate many outcomes and compute a tail quantile from the resulting loss distribution.

---

## Repository Structure
Recommended layout:

