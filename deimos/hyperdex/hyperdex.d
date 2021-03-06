/* Copyright (c) 2012, Cornell University
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright notice,
 *       this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of HyperDex nor the names of its contributors may be
 *       used to endorse or promote products derived from this software without
 *       specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */


/**
 * This file includes enums and constants that are used throughout HyperDex.
 */
module deimos.hyperdex.hyperdex;

public:
extern(C):
nothrow:

enum hyperdatatype
{
    /* Primitive types */
    HYPERDATATYPE_GENERIC   = 9216,
    HYPERDATATYPE_STRING    = 9217,
    HYPERDATATYPE_INT64     = 9218,
    HYPERDATATYPE_FLOAT     = 9219,

    /* List types */
    HYPERDATATYPE_LIST_GENERIC = 9280,
    HYPERDATATYPE_LIST_STRING  = 9281,
    HYPERDATATYPE_LIST_INT64   = 9282,
    HYPERDATATYPE_LIST_FLOAT   = 9283,

    /* Set types */
    HYPERDATATYPE_SET_GENERIC = 9344,
    HYPERDATATYPE_SET_STRING  = 9345,
    HYPERDATATYPE_SET_INT64   = 9346,
    HYPERDATATYPE_SET_FLOAT   = 9347,

    /* Map types */
    HYPERDATATYPE_MAP_GENERIC        = 9408,
    HYPERDATATYPE_MAP_STRING_KEYONLY = 9416,
    HYPERDATATYPE_MAP_STRING_STRING  = 9417,
    HYPERDATATYPE_MAP_STRING_INT64   = 9418,
    HYPERDATATYPE_MAP_STRING_FLOAT   = 9419,
    HYPERDATATYPE_MAP_INT64_KEYONLY  = 9424,
    HYPERDATATYPE_MAP_INT64_STRING   = 9425,
    HYPERDATATYPE_MAP_INT64_INT64    = 9426,
    HYPERDATATYPE_MAP_INT64_FLOAT    = 9427,
    HYPERDATATYPE_MAP_FLOAT_KEYONLY  = 9432,
    HYPERDATATYPE_MAP_FLOAT_STRING   = 9433,
    HYPERDATATYPE_MAP_FLOAT_INT64    = 9434,
    HYPERDATATYPE_MAP_FLOAT_FLOAT    = 9435,

    // Returned if the server acts up
    HYPERDATATYPE_GARBAGE   = 9727
}

/* Predicate occupies [9728, 9856) */
enum hyperpredicate
{
    HYPERPREDICATE_FAIL          = 9728,
    HYPERPREDICATE_EQUALS        = 9729,
    HYPERPREDICATE_LESS_EQUAL    = 9730,
    HYPERPREDICATE_GREATER_EQUAL = 9731
}

/* Datatype occupies [9216, 9728)
 * The chosen constants are significant as they allow properties of the datatype
 * to be determined with simple mask operations.  See datatypes/coercion.{h,cc}
 * for more information.
 */

auto containerType(T)(T x) { return x & 9664; }
auto containerElem(T)(T x) { return x & 9223; }
auto containerVal(T)(T x) { return x & 9223; }
auto containerKey(T)(T x) { return ((x & 56) >> 3) | (x & 9216); }
auto isPrimitive(T)(T x) { return containerType(x) == hyperdatatype.HYPERDATATYPE_GENERIC; }
auto createContainer(T1, T2)(T1 c, T2 e) { return cast(hyperdatatype)((c) | (e & 7)); }
auto createContainer2(T1, T2, T3)(T1 c, T2 k, T3 v) { return cast(hyperdatatype)((C) | ((K & 7) << 3) | (V & 7)); }
