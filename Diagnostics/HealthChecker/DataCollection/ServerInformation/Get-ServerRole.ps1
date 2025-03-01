﻿Function Get-ServerRole {
    param(
        [Parameter(Mandatory = $true)][object]$ExchangeServerObj
    )
    Write-VerboseOutput("Calling: Get-ServerRole")
    $roles = $ExchangeServerObj.ServerRole.ToString()
    Write-VerboseOutput("Roll: " + $roles)
    #Need to change this to like because of Exchange 2010 with AIO with the hub role.
    if ($roles -like "Mailbox, ClientAccess*") {
        return [HealthChecker.ExchangeServerRole]::MultiRole
    } elseif ($roles -eq "Mailbox") {
        return [HealthChecker.ExchangeServerRole]::Mailbox
    } elseif ($roles -eq "Edge") {
        return [HealthChecker.ExchangeServerRole]::Edge
    } elseif ($roles -like "*ClientAccess*") {
        return [HealthChecker.ExchangeServerRole]::ClientAccess
    } else {
        return [HealthChecker.ExchangeServerRole]::None
    }
}
