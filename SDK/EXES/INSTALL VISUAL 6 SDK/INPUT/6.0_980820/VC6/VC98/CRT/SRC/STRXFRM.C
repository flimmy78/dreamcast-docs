/***
*strxfrm.c - Transform a string using locale information
*
*       Copyright (c) 1988-1998, Microsoft Corporation. All rights reserved.
*
*Purpose:
*       Transform a string using the locale information as set by
*       LC_COLLATE.
*
*******************************************************************************/

#include <cruntime.h>
#include <string.h>

#ifdef _WIN32
#include <windows.h>
#include <stdlib.h>
#include <limits.h>
#include <malloc.h>
#include <locale.h>
#include <setlocal.h>
#include <awint.h>
#include <mtdll.h>
#endif  /* _WIN32 */

/***
*size_t strxfrm() - Transform a string using locale information
*
*Purpose:
*       Transform the string pointer to by _string2 and place the
*       resulting string into the array pointer to by _string1.
*       No more than _count characters are place into the
*       resulting string (including the null).
*
*       The transformation is such that if strcmp() is applied to
*       the two transformed strings, the return value is equal to
*       the result of strcoll() applied to the two original strings.
*       Thus, the conversion must take the locale LC_COLLATE info
*       into account.
*       [ANSI]
*
*       The value of the following expression is the size of the array
*       needed to hold the transformation of the source string:
*
*           1 + strxfrm(NULL,string,0)
*
*       NOTE:  Currently, the C libraries support the "C" locale only.
*       Thus, strxfrm() simply resolves to strncpy()/strlen().
*
*Entry:
*       char *_string1       = result string
*       const char *_string2 = source string
*       size_t _count        = max chars to move
*
*       [If _count is 0, _string1 is permitted to be NULL.]
*
*Exit:
*       Length of the transformed string (not including the terminating
*       null).  If the value returned is >= _count, the contents of the
*       _string1 array are indeterminate.
*
*Exceptions:
*       Non-standard: if OM/API error, return INT_MAX.
*
*******************************************************************************/

size_t __cdecl strxfrm (
        char *_string1,
        const char *_string2,
        size_t _count
        )
{
#ifdef _WIN32
        int dstlen;
        int retval = INT_MAX;   /* NON-ANSI: default if OM or API error */
#if defined (_MT)
        int local_lock_flag;
#endif  /* defined (_MT) */

        if ((__lc_handle[LC_COLLATE] == _CLOCALEHANDLE) &&
            (__lc_codepage == _CLOCALECP)) {
#endif  /* _WIN32 */
            strncpy(_string1, _string2, _count);
            return strlen(_string2);
#ifdef _WIN32
        }

        _lock_locale( local_lock_flag )

#if defined (_MT)
        if ((__lc_handle[LC_COLLATE] == _CLOCALEHANDLE) &&
            (__lc_codepage == _CLOCALECP)) {
            _unlock_locale( local_lock_flag )
            strncpy(_string1, _string2, _count);
            return strlen(_string2);
        }
#endif  /* defined (_MT) */

        /* Inquire size of dst string in BYTES */
        if ( 0 == (dstlen = __crtLCMapStringA( __lc_handle[LC_COLLATE],
                                               LCMAP_SORTKEY,
                                               _string2,
                                               -1,
                                               NULL,
                                               0,
                                               __lc_collate_cp,
                                               TRUE )) )
            goto error_cleanup;

        retval = dstlen;

        /* if not enough room, return amount needed */
        if (dstlen > (int)_count)
            goto error_cleanup;

        /* Map src string to dst string */
        if ( 0 == __crtLCMapStringA( __lc_handle[LC_COLLATE],
                                     LCMAP_SORTKEY,
                                     _string2,
                                     -1,
                                     _string1,
                                     _count,
                                     __lc_collate_cp,
                                     TRUE ) )
            goto error_cleanup;

error_cleanup:
        _unlock_locale( local_lock_flag )
        return (size_t)retval;
#endif  /* _WIN32 */
}
