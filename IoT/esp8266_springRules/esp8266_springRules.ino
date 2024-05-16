#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClientSecureBearSSL.h>
#include <ArduinoJson.h>
#include <SPI.h>
#include <MFRC522.h>

const char *ssid = "GlobeAtHome_74a28";
const char *password = "55yZm2Xm";
const char *API_KEY = "AIzaSyBHxD45EKLYHOZM7BVQ7iHyyvBe1wHZ3s0";

#define RST_PIN D2
#define SS_PIN D4
MFRC522 rfid(SS_PIN, RST_PIN);

// Firestore base URL
const char *FIRESTORE_BASE_URL = "https://firestore.googleapis.com/v1/projects/project-pawis/databases/(default)/documents";

void setup()
{
  Serial.begin(115200);
  SPI.begin();
  rfid.PCD_Init();

  WiFi.begin(ssid, password);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
}

void loop()
{
  if (!rfid.PICC_IsNewCardPresent() || !rfid.PICC_ReadCardSerial())
  {
    return;
  }

  String rfidTag = "";
  for (byte i = 0; i < rfid.uid.size; i++)
  {
    rfidTag += String(rfid.uid.uidByte[i], HEX);
  }
  rfid.PICC_HaltA();

  Serial.print("RFID Tag: ");
  Serial.println(rfidTag);

  String userId = getUserIdFromRFID(rfidTag);

  if (userId != "")
  {
    int currentPoints = getCurrentPoints(userId);
    if (currentPoints != -1)
    {
      updateUserPoints(userId, currentPoints + 1);
    }
  }

  if (Serial.available() > 0) {
    String data = Serial.readStringUntil('\n'); // Read data until newline character
    if (data.startsWith("POINTS:")) {
      // Extract the points data from the received string
      int receivedPoints = data.substring(7).toInt();
      
    }
  }
}

String getUserIdFromRFID(String rfidTag)
{
  if (WiFi.status() == WL_CONNECTED)
  {
    std::unique_ptr<BearSSL::WiFiClientSecure> client(new BearSSL::WiFiClientSecure);
    client->setInsecure(); // Disable SSL certificate verification

    HTTPClient http;
    String url = String(FIRESTORE_BASE_URL) + ":runQuery?key=" + API_KEY;
    http.begin(*client, url);
    http.addHeader("Content-Type", "application/json");

    // Create the query JSON
    StaticJsonDocument<512> doc;
    doc["structuredQuery"]["from"][0]["collectionId"] = "rfidDetails";
    doc["structuredQuery"]["where"]["fieldFilter"]["field"]["fieldPath"] = "rfidUID";
    doc["structuredQuery"]["where"]["fieldFilter"]["op"] = "EQUAL";
    doc["structuredQuery"]["where"]["fieldFilter"]["value"]["stringValue"] = rfidTag;

    String requestBody;
    serializeJson(doc, requestBody);

    int httpResponseCode = http.POST(requestBody);

    if (httpResponseCode == 200)
    {
      String response = http.getString();
      Serial.println(response);
      StaticJsonDocument<2048> responseDoc;
      deserializeJson(responseDoc, response);

      // Check if the response contains any documents
      if (responseDoc.is<JsonArray>() && responseDoc.size() > 0 && !responseDoc[0]["document"].isNull())
      {
        // Extract document name
        String documentName = responseDoc[0]["document"]["name"].as<String>();
        Serial.println("Document Name: " + documentName);

        // Extract document ID from the name field
        int lastSlashIndex = documentName.lastIndexOf('/');
        String userId = documentName.substring(lastSlashIndex + 1);
        Serial.println("Document ID: " + userId);

        http.end();
        return userId;
      }
      else
      {
        Serial.println("No matching document found.");
        http.end();
        return "";
      }
    }
    else
    {
      Serial.print("Error getting document: ");
      Serial.println(httpResponseCode);
      http.end();
      return "";
    }
  }
  else
  {
    Serial.println("WiFi Disconnected");
    return "";
  }
}



int getCurrentPoints(String userId)
{
  if (WiFi.status() == WL_CONNECTED)
  {
    std::unique_ptr<BearSSL::WiFiClientSecure> client(new BearSSL::WiFiClientSecure);
    client->setInsecure(); // Disable SSL certificate verification

    HTTPClient http;
    String url = String(FIRESTORE_BASE_URL) + "/userPoints/" + userId + "?key=" + API_KEY;
    http.begin(*client, url);
    int httpResponseCode = http.GET();

    if (httpResponseCode == 200)
    {
      String response = http.getString();
      StaticJsonDocument<512> doc;
      deserializeJson(doc, response);

      int points = doc["fields"]["points"]["integerValue"];
      http.end();
      return points;
    }
    else
    {
      Serial.print("Error getting points: ");
      Serial.println(httpResponseCode);
      http.end();
      return -1;
    }
  }
  else
  {
    Serial.println("WiFi Disconnected");
    return -1;
  }
}

void updateUserPoints(String userId, int newPoints)
{
  if (WiFi.status() == WL_CONNECTED)
  {
    std::unique_ptr<BearSSL::WiFiClientSecure> client(new BearSSL::WiFiClientSecure);
    client->setInsecure(); // Disable SSL certificate verification

    HTTPClient http;
    String url = String(FIRESTORE_BASE_URL) + "/userPoints/" + userId + "?key=" + API_KEY;
    http.begin(*client, url);
    http.addHeader("Content-Type", "application/json");

    StaticJsonDocument<200> doc;
    doc["fields"]["points"]["integerValue"] = newPoints;

    String requestBody;
    serializeJson(doc, requestBody);

    int httpResponseCode = http.PATCH(requestBody); // Use PATCH to update an existing document

    if (httpResponseCode == 200)
    {
      String response = http.getString();
      Serial.println(httpResponseCode);
      Serial.println(response);
    }
    else
    {
      Serial.print("Error updating points: ");
      Serial.println(httpResponseCode);
    }

    http.end();
  }
  else
  {
    Serial.println("WiFi Disconnected");
  }
}