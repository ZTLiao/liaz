//
//  decrypt.c
//  Runner
//
//  Created by 廖泽涛 on 2024/2/5.
//

#include "decrypt.h"

#include <string.h>
#include <stdlib.h>

extern "C" __attribute__((visibility("default"))) __attribute__((used))
void decrypt_key(char *encrypt_text, char *decrypt_text, int size) {
    int step = 8;
    int length = size / step;
    int i, j;
    for (i = 0; i < length; i++) {
        decrypt_text[i] = 0;
        for (j = 0; j < step; j++) {
            decrypt_text[i] |= encrypt_text[i * step + j] & (128 >> j);
        }
    }
    decrypt_text[length] = '\0';
}
