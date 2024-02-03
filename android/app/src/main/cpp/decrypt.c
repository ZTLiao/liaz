#include "decrypt.h"

#include <string.h>
#include <stdlib.h>

void decrypt_key(char *encrypt_text, char *decrypt_text, int size) {
  int step = 8;
  int length = size / 8;
  int i, j;
  for (i = 0; i < length; i++) {
	  decrypt_text[i] = 0;
    for (j = 0; j < step; j++) {
      decrypt_text[i] |= encrypt_text[i * step + j] & (128 >> j);
    }
  }
  decrypt_text[length] = '\0';
}