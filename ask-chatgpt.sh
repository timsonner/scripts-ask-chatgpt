#!/bin/bash

read -p "Enter the prompt: " prompt

#export API_KEY="sk-XXXXXXXXXXXXXXXXXXXx..."

curl https://api.openai.com/v1/completions \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
  \"model\": \"text-davinci-003\",
  \"prompt\": \"$prompt\",
  \"max_tokens\": 4000,
  \"temperature\": 1

}" | jq -r '.choices | .[] | .text'

