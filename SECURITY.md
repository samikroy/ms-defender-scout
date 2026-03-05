# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in MS Defender Scout, please **do not** create a public GitHub issue. Instead, please report it responsibly.

### How to Report

1. **Email the maintainers** with:
   - Description of the vulnerability
   - Steps to reproduce (if applicable)
   - Potential impact
   - Suggested fix (if you have one)

2. **Include your GitHub username** so we can credit you (if desired)

3. **Allow reasonable time** for us to investigate and patch before public disclosure

### Responsible Disclosure Guidelines

- **Do not** publicly disclose the vulnerability until a fix is available
- **Do not** access data without permission (test in your own environment)
- **Do not** disrupt service or modify data
- **Do allow** 90 days for vulnerability resolution before public disclosure

## Security Best Practices for Users

### Credential Security

- **Never** commit credentials to git
- **Always** use environment variables for secrets
- **Rotate** Service Principal credentials regularly
- **Use** Azure Key Vault for production deployments
- **Restrict** Service Principal permissions to minimum required

### API Permissions

The tool requires one of these permissions on Microsoft Graph API:
- `ThreatHunting.Read.All` (recommended - least privilege)
- `SecurityEvents.Read.All` (broader access)

**Never grant admin permissions beyond required scope.**

### Data Protection

- Reports may contain sensitive security information
- Restrict report access to authorized personnel
- Use HTTPS/TLS for network transmission
- Encrypt reports at rest if storing in cloud storage
- Consider data retention policies for compliance

### GitHub Actions Security

If using the workflow:
- Use GitHub Secrets for credentials (never hardcode)
- Restrict workflow permissions
- Review logs for sensitive data exposure
- Use branch protection rules
- Enable code scanning in repository settings

## Known Security Limitations

1. **Microsoft Defender License Required**
   - Not available for all Microsoft 365 plans
   - Requires appropriate licensing and permissions

2. **Query Execution Limits**
   - Advanced Hunting enforces rate limits
   - Some queries may timeout on large datasets

3. **Report Contains Security Data**
   - Treat generated reports as sensitive information
   - Implement access controls for HTML reports

4. **Service Principal Access**
   - Compromise of credentials grants security access
   - Rotate credentials regularly

## Security Dependencies

This tool depends on:
- **PowerShell 7+** or **Windows PowerShell 5.1**
- **Microsoft Graph API** (Microsoft-maintained)
- **GitHub Actions** (Microsoft-hosted runners)

We recommend keeping these components updated.

## Compliance

MS Defender Scout respects:
- Microsoft Defender security standards
- Graph API rate limiting and quotas
- GitHub terms of service
- Enterprise security policies

Users are responsible for:
- Compliance with their organization's policies
- Proper licensing for Microsoft products
- Data residency and retention requirements
- Audit trail and logging requirements

## Security Updates

- Critical vulnerabilities: Patched within 7 days
- High severity: Within 30 days
- Medium/Low: In next release cycle

Releases will be tagged with security information when applicable.

## Questions or Concerns?

For security-related questions that are **not** vulnerability reports:
- Open a GitHub issue with the `security` label
- Mark as private if sensitive
- The maintainers will respond promptly

---

**Thank you for helping keep MS Defender Scout secure!** 🔐
