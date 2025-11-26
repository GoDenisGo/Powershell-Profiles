Write-Host('Customised PowerShell behaviour written by @GoDenisGo on GitHub.')
Write-Host('E-Mail officialdeniskras@gmail.com for complaints.')

Write-Host('November 2025, No writes reserved.')

# EasterEggs contains unimportant script functions. Should only run once a session.
function EasterEggs {
    # Halloween message.
    if ($(Get-Date -Format "M") -eq "31 October") {
        Write-Host("`n👻👻👻Spooky ghosts have come to carry you away!👻👻👻")
        Write-Host("Boo! Happy Halloween!")
    }

    # Christmas message.
    if ($(Get-Date -Format "M") -eq "25 December") {
        Write-Host("`n🎅☃️☃️☃️Hohoho! Have a Happy Christmas!🎅☃️☃️☃️")
    }

    # New-year's eve message.
    if ($(Get-Date -Format "M") -eq "31 December") {
        Write-Host("`n🎆🎆🎆It's new year's eve! Have a happy new year!🎆🎆🎆")
    }
}

EasterEggs

# Function "prompt" is the entry-point for the terminal when it uses a profile.
function prompt {
    # Initialise variables.
    # Front and Back Colours:
    $FrontColourOrange = $($PSStyle.Foreground.FromRgb(255, 153, 51))
    $BackColourOrange = $($PSStyle.Background.FromRgb(255, 153, 51))

    $CurrentFolder = Split-Path -Path $pwd -Leaf
    # Current user accessing the prompt.
    $CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent().Name.Split("\")[1];
    # Test for Admin / Elevated privilages. Value is boolean.
    $IsAdmin = `
    (New-Object Security.Principal.WindowsPrincipal `
    ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

    # Only show if user is in an elevated shell.
    if ($IsAdmin) {
        # Write-Host("`u{E0B6}") -ForegroundColor DarkRed -NoNewline
        Write-Host("`u{E0C5}") -ForegroundColor DarkRed -NoNewline
        Write-Host ('🩻 admin') -BackgroundColor DarkRed -ForegroundColor Black -NoNewline
        Write-Host ("`u{E0B0}") -ForegroundColor DarkRed -NoNewline 
    }

    # Show the current working directory of the prompt.
    # Checks if current directory is also a git repo and prints orange if it's true.
    if ($IsAdmin) {
        Write-Host("`u{E0D4}") -ForegroundColor Green -NoNewline
    } else {
        Write-Host("`u{E0C5}") -ForegroundColor Green -NoNewline
    }
    Write-Host ('📁 ' + $CurrentFolder) -BackgroundColor Green -ForegroundColor Black -NoNewline
    $isrepo = Test-IsGitRepository
    if ($isrepo) {
        Write-Host ("$BackColourOrange`u{E0B0}${`e[0m]}") -ForegroundColor Green -NoNewline # Right arrow
        Write-Host ("$BackColourOrange`u{e0a0}${`e[0m}") -ForegroundColor Black -NoNewline
        Write-Host ("$FrontColourOrange`u{E0B0}${`e[0m}") -BackgroundColor 5 -NoNewline # Right arrow
    } else {
        Write-Host ("`u{E0B0}") -BackgroundColor 5 -ForegroundColor Green -NoNewline # Right arrow
    }

    # Show the current user.
    Write-Host ('😇 ' + $CmdPromptUser) -BackgroundColor 5 -ForegroundColor Black -NoNewline
    Write-Host ("`u{E0B0}") -ForegroundColor 5 -NoNewline

    return " "
}

# Check if the current directory is a Git repository
function Test-IsGitRepository {
    # Function paramaters can be initialised with default values.
    param(
        [string]$Path = (Get-Location)
    )

    if (Test-Path -Path (Join-Path $Path ".git")) {
        return $true
    } else {
        return $false
    }
}

# For future reference:
# We can choose Rgb colours using the $PSStyle.Background.FromRgb(123, 255, 0) variable/ function.
# As in the, "$($PSStyle.Background.FromRgb(123, 255, 0))PowerShell$($PSStyle.Reset)", example.
# This example paints the BackgroundColor of the word "PowerShell" in the colour Beige.
# $PSStyle is a variable which lists some good options.
#
# Escape sequences start with a freeform backtick and an e ("`e").
# "`e[104mHello!`e[0m" highlights the word "Hello!" in light blue. `e[0m resets the escape sequence.
#
# PS 7.4 added some methods for converting $PSStyle members to escape codes.
# 
# TypeName: System.Management.Automation.PSStyle (must be imported first)
#
# Name                               MemberType Definition
# ----                               ---------- ----------
# Equals                             Method     static bool Equals(System.Object objA, System.Object objB)
# MapBackgroundColorToEscapeSequence Method     static string MapBackgroundColorToEscapeSequence(System.ConsoleColor bac…
# MapColorPairToEscapeSequence       Method     static string MapColorPairToEscapeSequence(System.ConsoleColor foregroun…
# MapForegroundColorToEscapeSequence Method     static string MapForegroundColorToEscapeSequence(System.ConsoleColor for…
# ReferenceEquals                    Method     static bool ReferenceEquals(System.Object objA, System.Object objB)
#
# TODO: REFACTOR EVERYTHING TO BE BETTER. Build string first, then print it. This can make the code more modular.
