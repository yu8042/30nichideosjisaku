#include "apilib.h"

unsigned long rand (void)
{
  static unsigned long rand;

  rand *= 1234567;
  rand += 1397;

  return rand;
}

void HariMain(void)
{
	char *buf;
	int win, i, x, y;
	api_initmalloc();
	buf = api_malloc(150 * 100);
	win = api_openwin(buf, 150, 100, -1, "stars2");
	api_boxfilwin(win + 1,  6, 26, 143, 93, 0 /* �� */);
	for (i = 0; i < 50; i++) {
		x = (rand() % 137) +  6;
		y = (rand() %  67) + 26;
		api_point(win + 1, x, y, 3 /* �� */);
	}
	api_refreshwin(win,  6, 26, 144, 94);
	for (;;) {
		if (api_getkey(1) == 0x0a) {
			break; /* Enterならbreak; */
		}
	}
	api_end();
}
