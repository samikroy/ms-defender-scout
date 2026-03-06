# Microsoft Defender Scout

🛡️ **Automated Security Assessment & KQL Query Generation for Microsoft Defender**

---

## ⚙️ Features

| Feature | Description |
|---------|-------------|
| 🤖 **GitHub Copilot Agent** | Custom agent for intelligent KQL query generation in VS Code & GitHub web |
| 🔍 **Advanced Hunting Automation** | Runs customizable security checks via Microsoft Graph API |
| 📋 **Real-Time Console Logs** | Easy-to-read PowerShell output with color-coded results |
| 📄 **Styled HTML Report** | Professional assessment report for sharing |
| 🔐 **Secure Authentication** | Uses Azure Service Principal with Microsoft Graph API |
| 🧰 **Plug-and-Play** | Just configure secrets, add queries, and run |

## 🔍 Report Snapshot

<img width="1236" height="750" alt="image" src="https://github.com/user-attachments/assets/09aa505a-6ef8-4488-a691-f7c963e9703a" />


## 🔍 What This Tool Does

Generates comprehensive security assessment reports using Advanced Hunting queries across all Microsoft Defender products:
- Microsoft Defender for Endpoint
- Microsoft Defender for Cloud Apps
- Microsoft Defender for Identity
- Microsoft Defender for Office 365
- Microsoft Defender XDR

---

## 📁 Repository Structure

```
.
├── .github/
│   ├── agents/
│   │   └── Defender Scout KQL agent.md  # 🤖 GitHub Copilot Agent
│   └── workflows/
│       └── generate-report.yml          # GitHub Actions workflow
├── scripts/
│   ├── generate-ms-defender-scout-report.ps1  # Main report generator
│   └── kql-queries.txt                        # Advanced Hunting queries library
├── ms-defender-scout-report.html        # Sample generated report
├── KQL-EXAMPLES.md                      # 20+ example KQL queries
├── LICENSE                               # MIT License
└── README.md                             # You're reading it
```

---

## 🤖 GitHub Copilot Agent - Your KQL Assistant

---

The **Defender Scout KQL Agent** is a specialized GitHub Copilot Agent that works in both **VS Code** and **GitHub web interface**!

### ✨ Quick Start (No Setup Required!)

**In VS Code:**
1. Open GitHub Copilot Chat: `Ctrl+Shift+I` (Windows/Linux) or `Cmd+Shift+I` (Mac)
2. Start chatting with the agent:

```
@workspace Generate a KQL query to find devices with critical vulnerabilities

@workspace Create a threat hunting query for PowerShell downloads

@workspace Validate this query: DeviceInfo | where OSPlatform == "Windows"

@workspace Optimize my query for better performance

@workspace Show me devices that haven't updated in 30 days
```

**On GitHub Web:**
- Comment on issues or pull requests
- Use the same `@workspace` commands to get KQL queries generated instantly!

### 💡 What the Agent Can Do

| Capability | Description |
|------------|-------------|
| **Generate KQL Queries** | Natural language → Production-ready queries |
| **Validate Syntax** | Check queries for errors and issues |
| **Optimize Performance** | Improve query speed and efficiency |
| **Explain Queries** | Get plain English explanations |
| **Threat Hunting** | Security-focused query generation |
| **Best Practices** | Built-in Microsoft Defender security patterns |

### 🎯 Pre-loaded Conversation Starters

The agent comes with 8 quick-start prompts:
- Generate Device Query
- Threat Hunting
- Vulnerability Check
- Alert Analysis
- Email Security
- Query Optimization
- Explain Query
- Identity Attacks

### 📖 Example Queries the Agent Generates

**Find devices with outdated software:**
```kql
DeviceInfo 
| where Timestamp > ago(1d)
| where OSPlatform == "Windows"
| where OSBuild < "19045"  // Windows 10 22H2
| project DeviceName, OSVersion, OSBuild, LastSeen
| order by LastSeen desc
```

**Detect PowerShell download attempts:**
```kql
DeviceProcessEvents 
| where Timestamp > ago(24h)
| where FileName =~ "powershell.exe"
| where ProcessCommandLine has_any ("DownloadString", "WebClient", "IEX")
| project Timestamp, DeviceName, AccountName, ProcessCommandLine
| order by Timestamp desc
| take 100
```

---

## 📊 Automated Security Reports

---

### ⚙️ How it Works

```
Define KQL Queries → Authenticate via Graph API → Run Advanced Hunting → Generate HTML Report
```

The report generator:
1. Authenticates using Service Principal credentials
2. Reads KQL queries from `scripts/kql-queries.txt`
3. Executes each query against Microsoft Graph Advanced Hunting API
4. Formats results into a styled HTML report
5. Displays summary in console with color-coded status

### 🔐 Prerequisites

**Service Principal Setup:**

The solution requires a Service Principal with **SecurityEvents.Read.All** or **ThreatHunting.Read.All** permissions in Microsoft Graph API.

1. **Register an Azure AD application:**
   ```powershell
   az ad app create --display-name "MS Defender Scout"
   ```

2. **Create a service principal:**
   ```powershell
   az ad sp create --id <app-id>
   ```

3. **Assign Microsoft Graph API permissions:**
   - Go to Azure Portal → Azure Active Directory → App registrations
   - Select your app → API permissions → Add permission
   - Choose Microsoft Graph → Application permissions
   - Add: `SecurityEvents.Read.All` or `ThreatHunting.Read.All`
   - Grant admin consent

4. **Create a client secret:**
   - Go to Certificates & secrets → New client secret
   - Save the secret value securely

### ⚙️ How to Run

**Option 1: GitHub Actions (Recommended)**

1. **Clone this repository**
   ```bash
   git clone https://github.com/samikroy/ms-defender-scout.git
   cd ms-defender-scout
   ```

2. **Configure Repository Secrets**
   
   Go to: `Settings → Secrets and variables → Actions → New repository secret`
   
   Add these secrets:
   - `AZURE_CLIENT_ID` - Your Service Principal Application (client) ID
   - `AZURE_CLIENT_SECRET` - Your Service Principal client secret
   - `AZURE_TENANT_ID` - Your Azure AD Tenant ID

3. **Review the Workflow Schedule**
   
   Check: `.github/workflows/generate-report.yml`
   
   Default schedule: Runs weekly on Monday at 6 AM UTC
   
   Modify the cron expression to change frequency:
   ```yaml
   schedule:
     - cron: '0 6 * * 1'  # Every Monday at 6 AM UTC
   ```

4. **Run the Workflow**
   
   - Go to Actions tab
   - Select "Generate MS Defender Scout Report"
   - Click "Run workflow"
   - Download the HTML report from artifacts

**Option 2: Run Locally**

1. **Set environment variables:**
   ```powershell
   $env:AZURE_CLIENT_ID = "your-client-id"
   $env:AZURE_CLIENT_SECRET = "your-client-secret"
   $env:AZURE_TENANT_ID = "your-tenant-id"
   ```

2. **Run the script:**
   ```powershell
   .\scripts\generate-ms-defender-scout-report.ps1
   ```

3. **View the report:**
   ```powershell
   .\ms-defender-scout-report.html
   ```

---

## 📝 Customizing Queries

---

Edit `scripts/kql-queries.txt` to add your own Advanced Hunting queries.

**Format:** `Query Title >> KQL Query`

**Example:**
```
Device Inventory >> DeviceInfo | summarize Count=count() by DeviceName, OSPlatform | sort by Count desc
```

### Available Microsoft Defender Tables

Advanced Hunting supports these tables:
- **Device tables**: DeviceInfo, DeviceNetworkInfo, DeviceProcessEvents, DeviceNetworkEvents, DeviceFileEvents, DeviceRegistryEvents, DeviceLogonEvents, DeviceImageLoadEvents, DeviceEvents
- **Email tables**: EmailEvents, EmailAttachmentInfo, EmailUrlInfo, EmailPostDeliveryEvents
- **Identity tables**: IdentityLogonEvents, IdentityQueryEvents, IdentityDirectoryEvents
- **Alert tables**: AlertInfo, AlertEvidence
- **Cloud App tables**: CloudAppEvents
- **Vulnerability tables**: DeviceTvmSoftwareVulnerabilities, DeviceTvmSecureConfigurationAssessment

See [Advanced Hunting schema documentation](https://learn.microsoft.com/en-us/microsoft-365/security/defender/advanced-hunting-schema-tables) for complete details.

---

## 📚 Documentation & Resources

### Learning Resources
- **[GitHub Copilot Agent](.github/agents/Defender%20Scout%20KQL%20agent.md)** - VS Code agent configuration for KQL query generation
- **[KQL Examples](KQL-EXAMPLES.md)** - 20+ ready-to-use queries for common security scenarios
- [KQL Quick Reference](https://learn.microsoft.com/en-us/kusto/query/kql-quick-reference) - Microsoft official docs
- [Advanced Hunting Best Practices](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-best-practices) - Optimization guide
- [Microsoft Defender Schema](https://learn.microsoft.com/en-us/microsoft-365/security/defender/advanced-hunting-schema-tables) - Complete table reference

---

## 🔒 Security Best Practices

---

- Never commit secrets to the repository
- Use GitHub Secrets or Azure Key Vault for credentials
- Rotate Service Principal secrets regularly
- Apply principle of least privilege for API permissions
- Review and audit query results regularly

---

## 🧰 Troubleshooting

| Issue | Solution |
|-------|----------|
| **Authentication fails** | Verify Service Principal credentials and API permissions |
| **Query returns no data** | Check if your tenant has data in the queried tables |
| **Permission denied** | Ensure admin consent is granted for Graph API permissions |
| **Workflow fails** | Check GitHub Actions logs for detailed error messages |
| **Agent not responding** | Ensure GitHub Copilot extension is installed and enabled in VS Code |

---

## 🤝 Contributing

Have ideas for improvements? Contributions are welcome!

- **Issues**: [Report bugs or request features](https://github.com/samikroy/ms-defender-scout/issues)
- **Pull Requests**: Submit improvements or new query templates
- **Questions**: Open a GitHub issue for support

---

## 📜 License

MIT License - © 2026 Samik Roy

See [LICENSE](LICENSE) for details.

---

**⭐ Star this repo if you find it useful!**
