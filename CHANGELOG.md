# Changelog

All notable changes to MS Defender Scout will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-05

### ✨ Initial Release

**MS Defender Scout v1.0.0 is now available!**

This is the official public release of MS Defender Scout - an automated security assessment tool for Microsoft Defender XDR.

### Added

#### Core Features
- 🤖 **GitHub Copilot Integration**: Custom KQL agent for intelligent query generation
- 🔍 **Advanced Hunting Automation**: Automated threat hunting via Microsoft Graph API
- 📊 **Automated Report Generation**: Professional HTML reports with query results
- 🔐 **Secure Authentication**: Service Principal support with Microsoft Graph API
- 🧰 **Plug-and-Play Design**: Minimal configuration required

#### Automation
- ✅ GitHub Actions workflow for scheduled execution
- ✅ Manual trigger support (`workflow_dispatch`)
- ✅ Artifact upload and retention (90 days)
- ✅ Environment variable configuration
- ✅ Error handling and validation

#### Pre-built Queries (20 Total)
- **Device Management** (4 queries)
  - Device Inventory by Operating System
  - Active Devices in Last 24 Hours
  - Devices by Onboarding Status
  - File Integrity Monitoring

- **Alert Analysis** (5 queries)
  - Alert Summary by Severity
  - Recent High Severity Alerts
  - Alert Trend by Category
  - Top Affected Devices by Alerts
  - Malware Detections in Last 7 Days

- **Vulnerability Assessment** (3 queries)
  - Vulnerability Assessment by Severity
  - Top 10 Vulnerable Software Products
  - Devices with Critical Vulnerabilities

- **Configuration & Compliance** (1 query)
  - Security Recommendations by Priority

- **Threat Hunting** (3 queries)
  - Suspicious Process Executions
  - Network Connections to External IPs
  - Failed Logon Attempts by Device

- **Identity Security** (2 queries)
  - Identity Risk Events
  - [Community contributed]

- **Email & Cloud Security** (2 queries)
  - Email Threats Summary
  - Phishing Email Detection
  - Cloud App Activity by User

#### Documentation
- 📖 Comprehensive README with setup instructions
- 📋 Troubleshooting guide
- 🎯 KQL examples (20+ queries)
- 🤖 GitHub Copilot Agent documentation
- 🔒 Security best practices guide
- 📄 Contributing guidelines
- 📜 Code of Conduct
- 🛡️ Security policy

#### Infrastructure
- `.github/workflows/generate-report.yml` for CI/CD
- `.gitignore` with security-focused rules
- MIT License
- Issue and PR templates

### Features (Detailed)

**Report Generation**
```
✅ Outputs styled HTML report
✅ Color-coded query status
✅ Results formatting (tables with DataTypes)
✅ Console progress indicators
✅ Real-time query execution logs
```

**Query System**
```
✅ 20 pre-built security queries
✅ Custom query support (edit kql-queries.txt)
✅ Query title and description
✅ Format: "Title >> KQL Query"
✅ Performance optimized (time filters, aggregation)
```

**Copilot Agent**
```
✅ KQL query generation from natural language
✅ Query validation and optimization
✅ Query explanation capabilities
✅ 8 quick-start prompts
✅ Best practices guidance
```

**Security**
```
✅ No hardcoded credentials
✅ Environment variable configuration
✅ GitHub Secrets support
✅ Service Principal authentication
✅ Microsoft Graph API encryption
```

### Supported Environments
- PowerShell 7+ (recommended)
- Windows PowerShell 5.1
- Linux/macOS (with PowerShell 7+)
- GitHub Actions (Ubuntu latest)
- Azure Service Principal authentication

### Requirements
- Microsoft Defender XDR license
- Azure Service Principal (ThreatHunting.Read.All or SecurityEvents.Read.All)
- Microsoft Graph API access
- PowerShell 5.1+

### Known Limitations
- Requires paid Microsoft Defender license
- Advanced Hunting rate limit: 15 requests per minute
- Query timeout: 10 minutes per query
- Maximum result rows: Limited by Microsoft Graph API
- Microsoft Defender tables only (no third-party integration)

### GitHub Copilot Agent
- **File**: `.github/agents/Defender Scout KQL agent.md`
- **Capabilities**: Query generation, validation, optimization, explanation
- **Access**: VS Code (`@workspace` commands) + GitHub web interface
- **No setup required**: Works out of the box

### Community
- 🤝 Open to all security professionals
- 🎯 Focus on practical threat hunting
- 📚 Query library is community-driven
- 🔄 Regular security updates
- ✨ Recognition for contributors

---

## Roadmap

### Planned for v1.1
- [ ] Multi-tenant support
- [ ] Compliance reporting templates (PCI, SOC2, HIPAA)
- [ ] Slack/Teams notifications
- [ ] Advanced filtering UI

### Planned for v1.2
- [ ] Trend analysis dashboard
- [ ] Anomaly detection
- [ ] Risk scoring engine
- [ ] Integration with ServiceNow

### Planned for Future
- [ ] Web-based dashboard
- [ ] Cloud app integration (AWS, GCP)
- [ ] Machine learning threat detection
- [ ] Commercial support tier

---

## Support

- 📖 Read the [README](README.md)
- 🎯 Check [KQL-EXAMPLES.md](KQL-EXAMPLES.md)
- 🤝 Visit [Contributing Guidelines](CONTRIBUTING.md)
- 🐛 Report issues on GitHub
- 💬 Start a discussion for questions

---

## Contributors

Thank you to all contributors who make this project possible!

Initial development by [@samikroy](https://github.com/samikroy)

---

[1.0.0]: https://github.com/samikroy/ms-defender-scout/releases/tag/v1.0.0
