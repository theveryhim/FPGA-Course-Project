#include <stdint.h>

typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32; 

#define XStart 1U
#define YStart 262143U

void scrambler(u8 realPart, u8 imagPart, u16 *dout);
void reset();