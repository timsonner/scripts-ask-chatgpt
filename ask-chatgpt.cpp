#include <curl/curl.h> // include the curl library for making HTTP requests
#include <iostream> // include the iostream library for console I/O
#include <string> // include the string library for manipulating strings

using std::string;
using std::endl;
using std::cin;
using std::cout;
using std::cerr;

int main() {
    CURL* curl = curl_easy_init(); // initialize a curl session
    if (curl) { // check if curl session was successfully initialized

        const char* header_type = "Content-Type: application/json"; // set HTTP request header to specify JSON content
        const char* auth_token = "Authorization: Bearer sk-XXXXXXXXXXXXXXXXXXXXXXX"; // set OpenAI authentication token
        // const string model_id = "text-davinci-003"; // set the OpenAI model ID (commented out)
        const string model_id = "gpt-3.5-turbo"; // set the OpenAI model ID
      
        string message_content = "test"; // set default message content
        string tokens = "20"; // set the number of tokens to generate
      
        cout << "Prompt: "; // display a prompt for user input
        cin >> message_content; // read user input into message_content variable

        struct curl_slist* headers = NULL; // initialize a curl_slist object to hold the HTTP headers
        headers = curl_slist_append(headers, header_type); // add the header_type to the list of headers
        headers = curl_slist_append(headers, auth_token); // add the auth_token to the list of headers

        // construct the JSON request body as a string
        string json_data = "{\"model\":\"" + model_id + "\",\"tokens\":\"" + tokens + "\",\"messages\":[{\"role\":\"user\",\"content\":\"" + message_content + "\"}]}";

        curl_easy_setopt(curl, CURLOPT_URL, "https://api.openai.com/v1/chat/completions"); // set the URL to send the HTTP request to
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, json_data.c_str()); // set the request body to the JSON data
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers); // set the HTTP headers to use in the request

        CURLcode res = curl_easy_perform(curl); // perform the HTTP request and get the response

        if (res != CURLE_OK) { // check if the request was successful
            cerr << "curl_easy_perform() failed: " << curl_easy_strerror(res) << endl; // display an error message if the request failed
        }

        curl_slist_free_all(headers); // free the list of HTTP headers
        curl_easy_cleanup(curl); // cleanup the curl session
    }
    return 0; // return 0 to indicate successful program execution
}
