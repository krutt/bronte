/// Copyright (c) Krutt collective.
/// SPDX-License-Identifier: Apache-2.0
/// @title bronte
/// @note Holds and claims for BOLT11 atomic swaps
#[allow(unused_field)]
module bronte::bronte {
    use std::hash::sha2_256 as sha256;
    use std::string::{substring, utf8};
    use sui::event;
    use sui::dynamic_object_field as ofield;

    // structs
    public struct AtomicSwap has copy, store, drop {}
    public struct HoldInvoice<phantom T: key + store> has key, store {
        id: UID,
        bolt11: vector<u8>,
        pre_image_hash: vector<u8>,
    }

    // error codes
    const EPreImageHashMismatch: u64 = 0;

    public fun hold<T: key + store>(
        obj: T,
        bolt11: vector<u8>,
        pre_image: vector<u8>,
        ctx: &mut TxContext,
    ): (HoldInvoice<T>) {
        assert!(substring(&utf8(bolt11), 0, 6) == utf8(b"lnbcrt"));
        let pre_image_hash: vector<u8> = sha256(pre_image);
        let mut invoice = HoldInvoice {
            id: object::new(ctx),
            bolt11: bolt11,
            pre_image_hash: pre_image_hash,
        };
        event::emit(AtomicSwapCreated {
            swap_id: object::id(&invoice),
            bolt11: bolt11,
            pre_image_hash: pre_image_hash,
            creator: tx_context::sender(ctx),
            item_id: object::id(&obj)
        });
        ofield::add(&mut invoice.id, AtomicSwap {}, obj);
        invoice
    }

    public fun claim<T: key + store>(mut invoice: HoldInvoice<T>, pre_image: vector<u8>): T {
        let pre_image_hash: vector<u8> = sha256(pre_image);
        assert!(invoice.pre_image_hash == pre_image_hash, EPreImageHashMismatch);
        let obj = ofield::remove<AtomicSwap, T>(&mut invoice.id, AtomicSwap {});
        event::emit(AtomicSwapDestroyed { swap_id: object::id(&invoice) });
        let HoldInvoice { id, bolt11: _, pre_image_hash: _ } = invoice;
        object::delete(id);
        obj
    }

    public struct AtomicSwapCreated has copy, drop {
        swap_id: ID,
        bolt11: vector<u8>,
        pre_image_hash: vector<u8>,
        creator: address,
        item_id: ID,
    }
    public struct AtomicSwapDestroyed has copy, drop { swap_id: ID }
}
