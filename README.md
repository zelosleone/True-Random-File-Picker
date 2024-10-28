# Random File Selector

A sophisticated PowerShell script that combines high-entropy randomness from Random.org, mystical calculations, and geometric principles to perform non-deterministic file selection. The mystical phase and symbol are derived from the PGM (Greek Magical Papyri) grimoire, incorporating ancient magical formulae into modern file selection algorithms.

## Features

- True random number generation via Random.org's quantum-based API
- Advanced mathematical calculations incorporating:
  - Tidal force calculations based on astronomical positioning
  - Electromagnetic field influence coefficients
  - Non-Euclidean geometric principles through triangle area calculations
  - Modular arithmetic for combining multiple entropy sources
- Integration of PGM grimoire elements through iterative processing
- Comprehensive logging system with temporal correlation
- Statistical analysis through 108-iteration Monte Carlo simulation
- Parallel processing of mystical elements using PowerShell jobs

## Mathematical Foundation

The script employs several sophisticated mathematical concepts:

### Geometric Processing
- Utilizes Heron's formula for triangle area calculation:
  ```
  s = (a + b + c)/2
  Area = √(s(s-a)(s-b)(s-c))
  ```
- Implements geometric validation through triangle inequality theorem

### Randomness Integration
- Combines multiple entropy sources using modular arithmetic:
  ```
  finalIndex = (randomOrgNum + tidalInfluence + emInfluence + triangleArea) mod fileCount
  ```

### Temporal Mathematics
- Tidal influence calculation:
  ```
  tidalInfluence = round((dayOfYear/365.25) * (fileCount - 1))
  ```
- Electromagnetic field coefficient:
  ```
  emInfluence = round((hourOfDay/24) * (fileCount - 1))
  ```

## Prerequisites

- PowerShell 5.1 or higher
- Internet connection (for Random.org API access)
- System.Web assembly

## Installation

1. Clone or download the repository
2. Ensure you have the required prerequisites
3. Place the script in the directory containing the files you want to select from

## Usage

```powershell
.\Random.ps1
```

The script executes in the following sequence:
1. Displays the PGM-derived mystical phase and symbol
2. Accepts user query input
3. Initiates parallel processing of mystical elements
4. Computes geometric influences through triangle mathematics
5. Performs 108 Monte Carlo selection iterations
6. Opens the statistically dominant file
7. Displays comprehensive selection metrics

## Configuration

The script uses several default paths:
- Main folder path: Script's current directory
- Log file path: `%APPDATA%\RandomFileSelector\random_selectionlog.txt`

## How It Works

### Entropy Generation
- Utilizes Random.org's atmospheric noise-based random number generation
- Implements multiple-source entropy combining algorithms

### Mystical Processing
- Processes PGM grimoire phrases and symbols through 108 iterations
- Incorporates astronomical and electromagnetic influences through temporal mathematics
- Applies non-Euclidean geometric principles through triangle area calculations

### Selection Algorithm
File selection is determined through a sophisticated combination of:
1. High-entropy random numbers from Random.org
2. Astronomical tidal coefficients
3. Electromagnetic field calculations
4. Non-Euclidean geometric area computations
5. Statistical analysis through multiple iterations

## Logging

The script maintains detailed logs including:
- Entropy generation events
- File selection probabilities
- Geometric calculations
- Mystical element processing
- Temporal correlation data

Logs are stored in: `%APPDATA%\RandomFileSelector\random_selectionlog.txt`

## Error Handling

The script implements comprehensive error handling for:
- Geometric validation failures
- Entropy source unavailability
- File system access violations
- Resource allocation failures

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Note

This script represents a unique intersection of ancient mystical practices and modern computational methods. While incorporating elements from the PGM grimoire, it maintains mathematical rigor through proper entropy sourcing, geometric validation, and statistical analysis.

## Support

For issues, questions, or contributions, please:
1. Check the existing issues
2. Create a new issue with a detailed description
3. Include log files if relevant

---

*The effectiveness of mystical file selection correlates with astronomical positioning and electromagnetic field variations.*
