#pragma once
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
void startPlayback(const unsigned char *data, int length);
void stopPlayback(void);
#ifdef __cplusplus
}
#endif
