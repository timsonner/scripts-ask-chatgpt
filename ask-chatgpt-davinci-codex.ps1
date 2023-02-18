$apiKey = 'sk-XXXXXXXX....'

$model = 'davinci-codex'
$temperature = 0.7
$maxTokens = 60

$prompt = Read-Host "Enter a prompt"

$body = @{
    prompt = $prompt
    max_tokens = $maxTokens
    temperature = $temperature
} | ConvertTo-Json

$response = Invoke-WebRequest `
    -Method POST `
    -Uri "https://api.openai.com/v1/engines/$model/completions" `
    -Headers @{
        'Content-Type' = 'application/json'
        'Authorization' = "Bearer $apiKey"
    } `
    -Body $body `
    -UseBasicParsing

$json = $response.Content | ConvertFrom-Json
$json.choices.text | ForEach-Object { $_ -replace '\r\n','`r`n' } | Out-String
