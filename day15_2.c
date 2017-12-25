#include <stdio.h>

long gen(long prev, long factor, long filter) {
    long val = (prev * factor) % 2147483647;

    while(val & filter)
        val = (val * factor) % 2147483647;

    return val;
}

int main() {
    long genA = 512, genB = 191;
    long count = 0;

    for(long n=0; n < 5000000; n++) {
        genA = gen(genA, 16807, 3);
        genB = gen(genB, 48271, 7);

        if((genA & 0xffff) == (genB & 0xffff))
            count += 1;
    }

    printf("Part 2: %ld\n", count);

    return 0;
}
