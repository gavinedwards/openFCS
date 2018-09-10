// Stick Controller
// Test arduino code taken from http://henrysbench.capnfatz.com/henrys-bench/arduino-projects-tips-and-more/arduino-can-bus-module-1st-network-tutorial/

#include <mcp_can.h>
#include <SPI.h>

const int SPI_CS_PIN = 10;

// Build an ID or PGN.

long unsigned int txID = 0x400; 
unsigned char stmp[8] = {0x00, 0x02, 0x00, 0x00, 0x3e, 0xdc, 0xac, 0x08};  // Trying to convert 0.431 to IEEE-754 floating point results in 0x3edcac08

// Construct a MCP_CAN Object and set Chip Select to 10.

MCP_CAN CAN(SPI_CS_PIN);                            

void setup()
{
  Serial.begin(115200);

  while (CAN_OK != CAN.begin(CAN_250KBPS))  // init can bus : baudrate = 250K
  {
    Serial.println("CAN BUS Module Failed to Initialized");
    Serial.println("Retrying....");
    delay(200)
  }
  Serial.println("CAN BUS Shield init ok!");
}


void loop()
{   Serial.println("In loop");

  // send the data:  id = 0x00, Extended Frame, data len = 8, stmp: data buf
  // Extended Frame = 1.

  CAN.sendMsgBuf(txID,1, 8, stmp);    
  delay(25);    // send data every 25mS
}
