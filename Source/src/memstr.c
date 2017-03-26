#include <stdint.h>
#include <stddef.h>


#define EOS '\0'

int memcmp
(
    const void * s1,        /* array 1 */
    const void * s2,        /* array 2 */
    size_t       n      /* size of memory to compare */
)
{
    const unsigned char *p1;
    const unsigned char *p2;

    /* size of memory is zero */

    if (n == 0)
        return (0);

    /* compare array 2 into array 1 */

    p1 = s1;
    p2 = s2;

    while (*p1++ == *p2++) {
        if (--n == 0)
            return (0);
    }

    return ((*--p1) - (*--p2));
}


void * memset
(                                                            
    void * buf,          /* pointer to buffer              */
    int    ch,            /* char with which to fill buffer */
    size_t nbytes       /* number of bytes to fill        */
)                                                            
{
    char * bufc = (char *) buf;
    long * pBuf;
    char * bufend = bufc + nbytes;
    char * buftmp;
    long val;

    if (nbytes < 2 * sizeof(long) - 1)
        goto byte_fill;

    /*
     * Start on necessary alignment. This loop advances buf
     * at most sizeof(long) - 1 bytes.
     */

    while ((long)bufc & (sizeof(long) - 1)) {
        *bufc++ = (char) ch;
    }

    /* write sizeof(long) bytes at a time */
    val = (unsigned char)ch;  /* memset() wants the cast */
    val |= (val << 8);
    val |= (val << 16);

    /* Find the last long word boundary at or before bufend */
    buftmp = (char *)((long)bufend & ~(sizeof(long) - 1));

    pBuf = (long *)bufc;

    /* fill 4 bytes (8 bytes for LP64) at a time; don't exceed buf endpoint */

    do {
        /* Assert: buftmp and pBuf are sizeof(long) aligned */
        /* Assert: buftmp - (char*)pBuf >= sizeof (long) */
        *pBuf++ = val;
    } while ((char *)pBuf != buftmp);

    bufc = (char *)pBuf;

    /* fill remaining bytes one at a time */

byte_fill:
    while (bufc != bufend) {
        *bufc++ = (char) ch;
    }
}



size_t strlen
(   
    const char * s        /* string */
)
{
    const char *save = s + 1;
    
    while (*s++ != EOS)
        ;

    return (s - save);
}

void *memcpy 
(                                                                   
    void       * destination,   /* pointer to destination buffer */ 
    const void * source,        /* pointer to source buffer      */ 
    size_t       nbytes         /* number of bytes to copy       */ 
)                                                                   
{
    char * src = (char *) source;
    char * dst = (char *) destination;
    char * dstend;
    long * srcl;
    long * dstl;
    char * dsttmp;

    if ((size_t)(dst - src) >= nbytes) {
        /* forward copy */

        dstend = dst + nbytes;

        /*
         * Do a byte copy if nbytes is too small for amount of blind
         * copying, or if the source and destination alignments do not match.
         */

        if (nbytes < (2 * sizeof (long) - 1) ||
            (((long)dst ^ (long)src) & (sizeof (long) - 1)))
            goto byte_copy_fwd;

        /* if odd-aligned copy byte */

        while ((long)dst & (sizeof (long) - 1))
            *dst++ = *src++;

        srcl = (long *) src;
        dstl = (long *) dst;

        /*
             * dsttmp is highest sizeof(long) aligned address no greater than
             * dstend
             */

        dsttmp = (char *)((size_t)dstend & ~(sizeof(long) - 1));

        do {
            *dstl++ = *srcl++;
        } while ((char *)dstl != dsttmp);

        dst = (char *)dstl;
        src      = (char *)srcl;

byte_copy_fwd:
        while (dst != dstend)
            *dst++ = *src++;
    } else {
        /* backward copy */
        dstend = dst;
        dst += nbytes;
        src += nbytes;

        /* do byte copy if less than ten or alignment mismatch */

        if (nbytes < (2 * sizeof(long) - 1) ||
            (((long)dst ^ (long)src) & (sizeof(long) - 1)))
            goto byte_copy_bwd;

        /* if odd-aligned copy byte */

        while ((long)dst & (sizeof(long) - 1))
            *--dst = *--src;

        srcl = (long *) src;
        dstl = (long *) dst;

        /*
         * dsttmp is the smallest sizeof(long) aligned address
         * no less than dstend;
         */

        dsttmp = (char *)(((size_t)dstend + sizeof(long) - 1) &
                          ~(sizeof(long) - 1));
        do {
            *--dstl = *--srcl;
        } while ((char *)dstl != dsttmp);

        dst = (char *)dstl;
        src = (char *)srcl;

byte_copy_bwd:
        while (dst != dstend)
            *--dst = *--src;
    }
}


void *pvPortMalloc(size_t size)
{




}

void vPortFree(void *ptr)
{


}
