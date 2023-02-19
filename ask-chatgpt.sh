#!/bin/bash

#export API_KEY="sk-XXXXXXXXXXXXXXXXXXXx..."

curl https://api.openai.com/v1/completions \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $API_KEY" \
  -d '{
  "model": "text-davinci-003",
  "prompt": "Say this is a test",
  "max_tokens": 7,
  "temperature": 0

}' | jq -r '.choices | .[] | .text'
