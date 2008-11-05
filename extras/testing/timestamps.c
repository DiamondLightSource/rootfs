/* This program is designed to test the resolution of timestamps. */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>
#include <errno.h>
#include <math.h>

#define NS 1000000000


#define TEST_(command, args...) \
    ( { \
        bool __ok__ = (command)(args) != -1; \
        if (!__ok__) \
            perror(#command); \
        __ok__; \
    } )


struct timespec diff_ts(struct timespec ts1, struct timespec ts2)
{
    struct timespec result;
    result.tv_sec = ts1.tv_sec - ts2.tv_sec;
    result.tv_nsec = ts1.tv_nsec - ts2.tv_nsec;
    if (result.tv_nsec < 0)
    {
        result.tv_sec -= 1;
        result.tv_nsec += NS;
    }
    return result;
}

int main(int argc, char **argv)
{
    if (argc != 2)
    {
        printf("Usage: %s <interval>\n\nThe interval is in ms\n", argv[0]);
        return 1;
    }

    double integer;
    double fraction = modf(atof(argv[1]) * 1e-3, &integer);
    struct timespec sleep;
    sleep.tv_sec = (time_t) integer;
    sleep.tv_nsec = (long) (fraction * NS);
    if (fraction >= NS)  // Possible rounding up to whole second.
    {
        sleep.tv_sec += 1;
        sleep.tv_nsec -= NS;
    }
    printf("Interval = %ld.%09ld s\n", sleep.tv_sec, sleep.tv_nsec);

    struct timespec then;
    TEST_(clock_gettime, CLOCK_REALTIME, &then);
    printf("%ld.%09ld\n", then.tv_sec, then.tv_nsec);
    
    while (true)
    {
        struct timespec now;
        if (TEST_(clock_gettime, CLOCK_REALTIME, &now))
        {
            struct timespec delta = diff_ts(now, then);
            then = now;
            printf("%ld.%09ld -> %ld.%09ld\n",
                now.tv_sec, now.tv_nsec, delta.tv_sec, delta.tv_nsec);
        }

        TEST_(nanosleep, &sleep, NULL);
    }
//    return 0;
}
