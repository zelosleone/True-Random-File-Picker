Add-Type -AssemblyName System.Web

# Important sentence and symbol
$importantSentence = "αιη αιωι ηωιαη αη ιω ωη αιηουευωαι εαι υο ιαω ιωη οαυ αεη υωυω χαβραχ φλιεσ κηρφι νυρω φωχω βωχ :7 הכפף לי כל הדיימונים, למען ישמעו לי כל דיימון, בין בשמים או ברוח או בארץ או מתחת לארץ או ביבשה או במים, וכל קסם ונגע אשר מאת האלוהים."

$importantSymbol = @"
=#:
 :##:
   :**:
 :-. :##:
=@@@-  :##:
 =*=     :**:
           :*#:
           .*#:
 =+=     .*#:
=@@@-  .*#:
 :=: .*#:
   .*#:
 .*#:
=#:
"@

# Set paths
$mainFolderPath = $PSScriptRoot
$logFilePath = Join-Path -Path $env:APPDATA -ChildPath "RandomFileSelector\random_selectionlog.txt"

# Ensure log directory exists
$logDirectory = Split-Path -Path $logFilePath -Parent
if (-not (Test-Path -Path $logDirectory)) {
    New-Item -ItemType Directory -Path $logDirectory | Out-Null
}

# Function to write log
function Write-Log {
    param([string]$message)
    Add-Content -Path $logFilePath -Value ("$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): {0}" -f $message)
}

# Function to get a single random number from Random.org
function Get-RandomOrgNumber {
    param ([int]$min, [int]$max)
    
    $apiUrl = "https://www.random.org/integers/?num=1&min=$min&max=$([System.Web.HttpUtility]::UrlEncode($max))&col=1&base=10&format=plain&rnd=new"
    
    try {
        $response = Invoke-RestMethod -Uri $apiUrl -Method Get
        Write-Log ("Got random number from Random.org: {0}" -f $response)
        return [int]$response
    } catch {
        Write-Log ("Error accessing Random.org: {0}" -f $_.Exception.Message)
        throw
    }
}

# Function to process the sentence and symbol using Random.org
function Process-ImportantData {
    param([string]$data)
    $charArray = $data.ToCharArray()
    $shuffledArray = New-Object char[] $charArray.Length
    
    # Fetch random index for each character
    for ($i = 0; $i -lt $charArray.Length; $i++) {
        $randomIndex = Get-RandomOrgNumber -min 0 -max ($charArray.Length - 1)
        $shuffledArray[$i] = $charArray[$randomIndex]
    }
    
    return -join $shuffledArray
}

# Function to recite and process the data multiple times
function Recite-And-Process-Data {
    param([string]$data, [int]$count)
    for ($i = 1; $i -le $count; $i++) {
        Write-Log ("Recitation {0}: {1}" -f $i, $data)
        $data = Process-ImportantData -data $data
    }
    return $data
}

# Function to draw a triangle and perform trigonometry
function Draw-Triangle-And-Calculate {
    param ([int]$sideA, [int]$sideB, [int]$sideC)

    # Check if it's a valid triangle (using -lt instead of <)
    if ($sideA + $sideB -lt $sideC -or $sideA + $sideC -lt $sideB -or $sideB + $sideC -lt $sideA) {
        Write-Log "Invalid triangle sides. Cannot form a triangle."
        return 0  # Return 0 if invalid triangle
    }

    # Calculate area using Heron's formula
    $s = ($sideA + $sideB + $sideC) / 2
    $area = [math]::Sqrt($s * ($s - $sideA) * ($s - $sideB) * ($s - $sideC))

    # Log results
    Write-Log ("Triangle calculated with sides: $sideA, $sideB, $sideC")
    Write-Log ("Area: {0:F2}" -f $area)

    return [math]::Round($area) # Return rounded area
}

# Function to select a single random file using combined randomness and triangle area
function Select-RandomFile {
    param ([System.IO.FileInfo[]]$files, [int]$triangleArea)

    # Get a random number from Random.org
    $randomOrgIndex = Get-RandomOrgNumber -min 0 -max ($files.Count - 1)

    # Calculate mystical influences (simplified for this example)
    $tidalInfluence = [math]::Round((Get-Date).DayOfYear / 365.25 * ($files.Count - 1))
    $emInfluence = [math]::Round((Get-Date).Hour / 24 * ($files.Count - 1))

    # Combine influences and triangle area to create a final index
    $finalIndex = ($randomOrgIndex + $tidalInfluence + $emInfluence + $triangleArea) % $files.Count

    return $files[$finalIndex]
}

# Function to get the most frequent file using combined randomness and triangle area
function Get-MostFrequentFile {
    param ([int]$runCount = 108, [int]$triangleArea)
    $fileCounts = @{}

    # Loop to get random files based on combined randomness and triangle area
    for ($i = 0; $i -lt $runCount; $i++) {
        $selectedFile = Select-RandomFile -files $allFiles -triangleArea $triangleArea
        $filePath = $selectedFile.FullName

        if ($fileCounts.ContainsKey($filePath)) {
            $fileCounts[$filePath]++
        } else {
            $fileCounts[$filePath] = 1
        }
        Write-Log ("Selected file using combined randomness and triangle area: {0}" -f $filePath)
    }

    # Sort the files based on the number of times they were selected
    $sortedCounts = $fileCounts.GetEnumerator() | Sort-Object -Property Value -Descending
    $maxCount = $sortedCounts[0].Value
    $mostFrequentFiles = $sortedCounts | Where-Object { $_.Value -eq $maxCount }

    # If multiple files have the same maximum count, select one at random using Random.org
    if ($mostFrequentFiles.Count -gt 1) {
        $randomIndex = Get-RandomOrgNumber -min 0 -max ($mostFrequentFiles.Count - 1)
        $mostFrequentFile = $mostFrequentFiles[$randomIndex]
    } else {
        $mostFrequentFile = $mostFrequentFiles[0]
    }

    $percentage = ($mostFrequentFile.Value / $runCount) * 100
    return @{
        File = $mostFrequentFile.Key
        Count = $mostFrequentFile.Value
        Percentage = $percentage
    }
}

# Display important phase and symbol
Write-Host "Important Phase:"
Write-Host $importantSymbol
Write-Host "Important Sentence:"
Write-Host $importantSentence

# Prompt for question
$question = Read-Host -Prompt "What's your question?"

# Start processing the important sentence and symbol in the background
$processTask = Start-Job -ScriptBlock {
    param($importantSentence, $importantSymbol, $logFilePath)
    
    # Import required assembly in the job context
    Add-Type -AssemblyName System.Web
    
    # Define functions within the job's scope
    ${function:Get-RandomOrgNumber} = ${using:function:Get-RandomOrgNumber}
    ${function:Process-ImportantData} = ${using:function:Process-ImportantData}
    ${function:Recite-And-Process-Data} = ${using:function:Recite-And-Process-Data}
    ${function:Write-Log} = ${using:function:Write-Log}
    
    $importantSentence = Recite-And-Process-Data -data $importantSentence -count 108
    $importantSymbol = Recite-And-Process-Data -data $importantSymbol -count 108
    
    Write-Log ("Important Sentence (after processing): {0}" -f $importantSentence)
    Write-Log ("Important Symbol (after processing): {0}" -f $importantSymbol)
    
    return @($importantSentence, $importantSymbol)
} -ArgumentList $importantSentence, $importantSymbol, $logFilePath

# Get all files
$allFiles = Get-ChildItem -Path $mainFolderPath -Recurse -File

# Check for files
if ($allFiles.Count -eq 0) {
    Write-Host "No files found."
    Write-Log "No files found."
    exit
}

# Get file count
$fileCount = $allFiles.Count

# Get 3 random numbers for the triangle
$triangleSideA = Get-RandomOrgNumber -min 1 -max 10 
$triangleSideB = Get-RandomOrgNumber -min 1 -max 10
$triangleSideC = Get-RandomOrgNumber -min 1 -max 10

# Draw triangle and calculate area, handle invalid triangles
$triangleArea = Draw-Triangle-And-Calculate -sideA $triangleSideA -sideB $triangleSideB -sideC $triangleSideC

# If the triangle is invalid, use a default area of 1
if ($triangleArea -eq 0) {
    $triangleArea = 1
    Write-Log "Invalid triangle, using default area of 1 for file selection."
}

# Get the most frequent file using combined randomness and triangle area
$result = Get-MostFrequentFile -runCount 108 -triangleArea $triangleArea

# Open the file
Start-Process -FilePath $result.File

# Log results
Write-Log ("Most frequent file: {0}" -f $result.File)
Write-Log ("Selected {0} times out of 108 runs ({1:F2}%)" -f $result.Count, $result.Percentage)

# Wait for the background job to finish and retrieve results
$processedData = Receive-Job -Job $processTask -Wait
Remove-Job -Job $processTask

Write-Log ("Important Sentence: {0} was processed during question phase." -f $processedData[0])
Write-Log ("Important Symbol: {0} was processed during question phase." -f $processedData[1])

# Display results
Write-Host ("Most frequent file: {0}" -f (Split-Path -Leaf $result.File))
Write-Host ("Selected {0} times out of 108 runs ({1:F2}%)" -f $result.Count, $result.Percentage)
Write-Host ("Total number of files: {0}" -f $fileCount)
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 