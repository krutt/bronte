#[test_only]
module bronte::bronte_tests {
    use sui::coin::{Self, Coin};
    use sui::sui::SUI;
    use sui::test_scenario::{Self, Scenario};

    use bronte::bronte::{HoldInvoice, Self};

    // test constants
    const ALICE: address = @0xA;
    const BOB: address = @0xB;

    // fixtures
    fun test_coin(scenario: &mut Scenario): Coin<SUI> {
        coin::mint_for_testing<SUI>(42, scenario.ctx())
    }

    // tests
    #[test]
    fun test_hold_claim_by_alice() {
        let mut scenario = test_scenario::begin(ALICE);
        let bolt11: vector<u8> = b"lnbcrt";
        let coin = test_coin(&mut scenario);
        let pre_image = b"its-a-secret-to-everybody";
        let invoice = bronte::hold(coin, bolt11, pre_image, scenario.ctx());
        let claimed = invoice.claim(pre_image);
        claimed.burn_for_testing();
        scenario.end();
    }

    #[test]
    fun test_hold_by_alice_and_claim_by_bob() {
        let mut scenario = test_scenario::begin(ALICE);
        let bolt11: vector<u8> = b"lnbcrt";
        let coin = test_coin(&mut scenario);
        let pre_image = b"its-a-secret-to-everybody";
        let invoice = bronte::hold(coin, bolt11, pre_image, scenario.ctx());
        scenario.next_tx(BOB);
        let claimed = invoice.claim(pre_image);
        claimed.burn_for_testing();
        scenario.end();
    }

    #[test]
    #[expected_failure(abort_code = bronte::EPreImageHashMismatch)]
    fun test_claim_pre_image_hash_mismatch() {
        let mut scenario = test_scenario::begin(ALICE);
        let coin = test_coin(&mut scenario);
        let bolt11: vector<u8> = b"lnbcrt";
        let pre_image = b"its-a-secret-to-everybody";
        let incorrect_pre_image = b"this-pre-image-is-invalid";
        let invoice = bronte::hold(coin, bolt11, pre_image, scenario.ctx());
        let claimed = invoice.claim(incorrect_pre_image);
        claimed.burn_for_testing();
        abort 1337
    }
}
