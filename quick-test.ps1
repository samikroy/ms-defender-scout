# quick-test.ps1
# Quick test script for MS Defender Scout

$ErrorActionPreference = 'Stop'

Write-Host "🚀 MS Defender Scout - Quick Test" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

# Check if credentials are set
$credentialsSet = $true

if ([string]::IsNullOrEmpty($env:AZURE_CLIENT_ID)) {
    Write-Host "❌ AZURE_CLIENT_ID not set" -ForegroundColor Red
    $credentialsSet = $false
}

if ([string]::IsNullOrEmpty($env:AZURE_CLIENT_SECRET)) {
    Write-Host "❌ AZURE_CLIENT_SECRET not set" -ForegroundColor Red
    $credentialsSet = $false
}

if ([string]::IsNullOrEmpty($env:AZURE_TENANT_ID)) {
    Write-Host "❌ AZURE_TENANT_ID not set" -ForegroundColor Red
    $credentialsSet = $false
}

if (-not $credentialsSet) {
    Write-Host ""
    Write-Host "💡 Credentials not configured. Would you like to set them now?" -ForegroundColor Yellow
    $response = Read-Host "Run setup-credentials.ps1? (Y/N)"
    
    if ($response -eq "Y" -or $response -eq "y") {
        .\setup-credentials.ps1
    } else {
        Write-Host "❌ Cannot proceed without credentials" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ Credentials configured" -ForegroundColor Green
Write-Host ""

# Test with a simple query first
Write-Host "🧪 Running a simple test query first..." -ForegroundColor Cyan
Write-Host ""

# Create a test query file
$testQuery = "Device Count Test >> DeviceInfo | summarize TotalDevices = dcount(DeviceId)"
$testQueryFile = "./scripts/kql-queries-test.txt"

# Backup original queries
$originalQueries = Get-Content "./scripts/kql-queries.txt"
$testQuery | Set-Content $testQueryFile

# Temporarily replace queries with test query
Copy-Item "./scripts/kql-queries.txt" "./scripts/kql-queries.backup.txt"
$testQuery | Set-Content "./scripts/kql-queries.txt"

try {
    # Run the script with test query
    Write-Host "Running test query..." -ForegroundColor Yellow
    .\scripts\generate-ms-defender-scout-report.ps1
    
    Write-Host ""
    Write-Host "✅ Test successful!" -ForegroundColor Green
    Write-Host ""
    
    # Ask if user wants to run full report
    $runFull = Read-Host "Test passed! Run full report with all 20 queries? (Y/N)"
    
    if ($runFull -eq "Y" -or $runFull -eq "y") {
        Write-Host ""
        Write-Host "🔄 Restoring original queries and running full report..." -ForegroundColor Cyan
        
        # Restore original queries
        $originalQueries | Set-Content "./scripts/kql-queries.txt"
        
        # Run full report
        .\scripts\generate-ms-defender-scout-report.ps1
        
        Write-Host ""
        Write-Host "✅ Full report generated!" -ForegroundColor Green
        Write-Host ""
        Write-Host "📄 Opening report in browser..." -ForegroundColor Cyan
        Start-Process "ms-defender-scout-report.html"
    } else {
        Write-Host ""
        Write-Host "ℹ️ Test report generated. Run full report later with:" -ForegroundColor Cyan
        Write-Host "   .\scripts\generate-ms-defender-scout-report.ps1" -ForegroundColor White
    }
    
} catch {
    Write-Host ""
    Write-Host "❌ Test failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 Troubleshooting tips:" -ForegroundColor Yellow
    Write-Host "   1. Verify your Service Principal has Graph API permissions" -ForegroundColor White
    Write-Host "   2. Ensure admin consent has been granted" -ForegroundColor White
    Write-Host "   3. Check if you have Defender data in your tenant" -ForegroundColor White
    Write-Host "   4. Review TESTING.md for detailed troubleshooting" -ForegroundColor White
    
} finally {
    # Always restore original queries
    if (Test-Path "./scripts/kql-queries.backup.txt") {
        $originalQueries | Set-Content "./scripts/kql-queries.txt"
        Remove-Item "./scripts/kql-queries.backup.txt" -ErrorAction SilentlyContinue
    }
    
    # Clean up test file
    Remove-Item $testQueryFile -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "🎉 Quick test complete!" -ForegroundColor Green
