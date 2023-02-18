$apiKey = "sk-XXXXXXXX..."
$prompt = Read-Host -Prompt ("Enter a prompt")
$RequestBody = @{
    prompt = $prompt
    model = "text-davinci-003"
    temperature= 1.0
    max_tokens= 4000
}

$Header =@{ Authorization = "Bearer $($apiKey) " }
$RequestBody=$RequestBody | ConvertTo-Json

$RestMethodParameter=@{
    Method='Post'
    Uri ='https://api.openai.com/v1/completions'
    body=$RequestBody
    Headers=$Header
    ContentType='application/json'
}


(Invoke-RestMethod @RestMethodParameter).choices[0].text