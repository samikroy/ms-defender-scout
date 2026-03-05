# Contributing to MS Defender Scout

First off, thank you for considering contributing to MS Defender Scout! It's people like you that make this tool such a great resource for the security community.

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to the maintainers.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps which reproduce the problem**
* **Provide specific examples to demonstrate the steps**
* **Describe the behavior you observed after following the steps**
* **Explain which behavior you expected to see instead and why**
* **Include screenshots and animated GIFs if possible**
* **Include your environment details** (PowerShell version, OS, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a step-by-step description of the suggested enhancement**
* **Provide specific examples to demonstrate the steps**
* **Describe the current behavior and explain the expected behavior**
* **Explain why this enhancement would be useful**

### Pull Requests

* Follow the [PowerShell Style Guide](https://learn.microsoft.com/en-us/powershell/scripting/community/contributing/powershell-style-guide)
* Document new code based on the [Microsoft Learn style guide](https://learn.microsoft.com/en-us/contribute/content/style-quick-start)
* End all files with a newline
* Avoid platform-dependent code
* Use meaningful commit messages

## Development Setup

1. **Fork the repository**
   ```bash
   git clone https://github.com/your-username/ms-defender-scout.git
   cd ms-defender-scout
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - For **queries**: Add to `scripts/kql-queries.txt` in format `Title >> Query`
   - For **scripts**: Maintain PowerShell style guide compliance
   - For **agent**: Update `.github/agents/Defender Scout KQL agent.md`

4. **Test your changes locally**
   ```powershell
   # For scripts:
   $env:AZURE_CLIENT_ID = "your-client-id"
   $env:AZURE_CLIENT_SECRET = "your-client-secret"
   $env:AZURE_TENANT_ID = "your-tenant-id"
   .\scripts\generate-ms-defender-scout-report.ps1
   
   # For queries: Verify format "Title >> Query"
   ```

5. **Commit your changes**
   ```bash
   git commit -m "feat: Add PowerShell download detection query"
   ```

6. **Push to your fork and submit a pull request**
   ```bash
   git push origin feature/your-feature-name
   ```

## PR Requirements

All pull requests should:

- [ ] Follow the code style guide
- [ ] Include a clear description of changes
- [ ] Reference any related issues
- [ ] Pass basic validation (no syntax errors)
- [ ] Include examples for new features
- [ ] Update documentation if needed

## Types of Contributions

### 🎯 KQL Query Contributions

The easiest way to contribute! Add threat hunting queries to `scripts/kql-queries.txt`:

**Format:**
```
Query Title >> KQL Query Code
```

**Example:**
```
Powerpoint Downloads >> DeviceProcessEvents | where FileName =~ "powershell.exe" | where ProcessCommandLine has "DownloadString"
```

**Guidelines:**
- Include queries that address real security scenarios
- Test the query in Advanced Hunting before submitting
- Add comment explaining what the query detects
- Start with `where Timestamp > ago(7d)` for efficiency

### 🤖 Agent Prompt Contributions

Enhance the GitHub Copilot Agent by adding quick-reply prompts or improving KQL guidance in `.github/agents/Defender Scout KQL agent.md`

### 🐛 Bug Reports & Fixes

- Test thoroughly before submitting
- Include reproduction steps
- Provide error messages and logs

### 📚 Documentation

- Improve README clarity
- Add troubleshooting guides
- Create quick-start tutorials
- Translate to other languages

### 🔧 Feature Requests

- Suggest new automation capabilities
- Propose integration ideas
- Recommend reporting enhancements

## Styleguides

### PowerShell Code Style

```powershell
# Use descriptive names
$variableNamesAreCamelCase
$FunctionNamesArePascalCase

# Use comment-based help
<#
.SYNOPSIS
Brief description

.DESCRIPTION
Detailed description

.PARAMETER ParameterName
Description of parameter

.EXAMPLE
Example usage
#>

# Error handling
$ErrorActionPreference = 'Stop'
try {
    # Code
} catch {
    Write-Error "Clear error message: $_"
}
```

### KQL Query Style

```kql
// Clear title and purpose
// Detect suspicious PowerShell downloads

DeviceProcessEvents
| where Timestamp > ago(7d)           // Always include time filter
| where FileName =~ "powershell.exe"  // Filter early
| where ProcessCommandLine has_any (  // Use meaningful conditions
    "DownloadString",
    "IEX"
)
| project                             // Select relevant columns only
    Timestamp,
    DeviceName,
    AccountName,
    ProcessCommandLine
| order by Timestamp desc             // Sort by most useful field
| take 100                            // Limit results appropriately
```

## Recognition

Contributors will be recognized in:
- Release notes
- GitHub contributors page
- Query template author attribution

## Questions?

- Check existing issues and discussions
- Read the [README](README.md)
- Review [KQL-EXAMPLES.md](KQL-EXAMPLES.md)
- Open a discussion for broader questions

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to MS Defender Scout!** 🛡️
