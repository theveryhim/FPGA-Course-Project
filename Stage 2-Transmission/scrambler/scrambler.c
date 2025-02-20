#include <stdio.h>
#include "scrambler.h"

static u32 x, y;

static void resetState() {
    x = XStart;
    y = YStart;
}

static u8 calculateZ(void) {
    return ((x & 0x1) + (y & 0x1)) % 2;
}

static u8 calculateZPrime(void) {
    return (((y >> 15) & 0x1) + ((y >> 14) & 0x1) + ((y >> 13) & 0x1) + ((y >> 12) & 0x1) +
            ((y >> 11) & 0x1) + ((y >> 10) & 0x1) + ((y >> 9) & 0x1) + ((y >> 8) & 0x1) +
            ((y >> 6) & 0x1) + ((y >> 5) & 0x1) + ((x >> 15) & 0x1) + ((x >> 6) & 0x1) +
            ((x >> 4) & 0x1)) % 2;
}

static u8 calculateR(void) {
    u8 z = calculateZ();
    u8 zPrime = calculateZPrime();
    zPrime <<= 1;
    return z + zPrime;
}

static void updateXY(void) {
    u8 xAdd = (((x) & 0x1) + ((x >> 7) & 0x1)) % 2;
    u8 yAdd = (((y) & 0x1) + ((y >> 5) & 0x1) + ((y >> 7) & 0x1) + ((y >> 10) & 0x1)) % 2;

    x >>= 1;
    y >>= 1;
    x = (xAdd << 17) | x;
    y = (yAdd << 17) | y;
}

void scramble(u8 realPart, u8 imagPart, u16 *dout) {
    u8 r = calculateR();
    printf("x = %d, y = %d\n", x, y);
    printf("r = %d\n", r);

    u16 realPart2 = realPart;
    u16 imagPart2 = imagPart;

    switch (r) {
    case 0:
        *dout = (imagPart2 << 8) | realPart2;
        break;
    case 1:
        *dout = (realPart2 << 8) | ((~imagPart2 + 1) & 0xFF);
        break;
    case 2:
        *dout = (((~imagPart2 + 1) & 0xFF) << 8) | ((~realPart2 + 1) & 0xFF);
        break;
    case 3:
        *dout = (((~realPart2 + 1) & 0xFF) << 8) | (imagPart2 & 0xFF);
        break;
    default:
        *dout = (imagPart2 << 8) | realPart2;
        break;
    }

    updateXY();
}

void reset() {
    resetState();
}
