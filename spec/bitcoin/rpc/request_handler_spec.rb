require 'spec_helper'

describe Bitcoin::RPC::RequestHandler do

  class HandlerMock
    include Bitcoin::RPC::RequestHandler
    attr_reader :node
    def initialize(node)
      @node = node
    end
  end

  let(:chain) { load_chain_mock }
  let(:wallet) { create_test_wallet }
  subject {
    allow(Bitcoin::Wallet::MasterKey).to receive(:generate).and_return(test_master_key)
    node_mock = double('node mock')
    allow(node_mock).to receive(:chain).and_return(chain)
    allow(node_mock).to receive(:pool).and_return(load_pool_mock(node_mock.chain))
    allow(node_mock).to receive(:broadcast).and_return(nil)
    allow(node_mock).to receive(:wallet).and_return(wallet)
    HandlerMock.new(node_mock)
  }
  after {
    chain.db.close
    wallet.close
  }

  describe '#getblockchaininfo' do
    it 'should return chain info' do
      result = subject.getblockchaininfo
      expect(result[:chain]).to eq('testnet')
      expect(result[:headers]).to eq(1210339)
      expect(result[:bestblockhash]).to eq('00000000ecae98e551fde86596f9e258d28edefd956f1e6919c268332804b668')
      expect(result[:mediantime]).to eq(1508126989)
    end
  end

  describe '#getblockheader' do
    context 'has block header' do
      it 'should return header info' do
        result = subject.getblockheader('00000000fb0350a72d7316a2006de44e74c16b56843a29bd85e0535d71edbc5b', true)
        expect(result[:hash]).to eq('00000000fb0350a72d7316a2006de44e74c16b56843a29bd85e0535d71edbc5b')
        expect(result[:height]).to eq(1210337)
        expect(result[:version]).to eq(536870912)
        expect(result[:versionHex]).to eq('20000000')
        expect(result[:merkleroot]).to eq('ac92cbb5ccd160f9b474f27a1ed50aa9f503b4d39c5acd7f24ef0a6a0287c7c6')
        expect(result[:time]).to eq(1508130596)
        expect(result[:mediantime]).to eq(1508125317)
        expect(result[:nonce]).to eq(1647419287)
        expect(result[:bits]).to eq('1d00ffff')
        expect(result[:previousblockhash]).to eq('00000000cd01007346f9a3d384a507f97afb164c057bcd1694ca20bb3302bb8d')
        expect(result[:nextblockhash]).to eq('000000008f71fb3f76a19075987a5d5653efce9bab90474497c9e1151ac94b69')
        header = subject.getblockheader('00000000fb0350a72d7316a2006de44e74c16b56843a29bd85e0535d71edbc5b', false)
        expect(header).to eq('000000208dbb0233bb20ca9416cd7b054c16fb7af907a584d3a3f946730001cd00000000c6c787026a0aef247fcd5a9cd3b403f5a90ad51e7af274b4f960d1ccb5cb92ac243fe459ffff001d979f3162')
      end
    end

    context 'has not block header' do
      it 'should return error' do
        expect{subject.getblockheader('00', true)}.to raise_error(ArgumentError, 'Block not found')
      end
    end
  end

  describe '#getpeerinfo' do
    it 'should return connected peer info' do
      result = subject.getpeerinfo
      expect(result.length).to eq(2)
      expect(result[0][:id]). to eq(1)
      expect(result[0][:addr]). to eq('192.168.0.1:18333')
      expect(result[0][:addrlocal]). to eq('192.168.0.3:18333')
      expect(result[0][:services]). to eq('000000000000000c')
      expect(result[0][:relaytxes]). to be false
      expect(result[0][:lastsend]). to eq(1508305982)
      expect(result[0][:lastrecv]). to eq(1508305843)
      expect(result[0][:bytessent]). to eq(31298)
      expect(result[0][:bytesrecv]). to eq(1804)
      expect(result[0][:conntime]). to eq(1508305774)
      expect(result[0][:pingtime]). to eq(0.593433)
      expect(result[0][:minping]). to eq(0.593433)
      expect(result[0][:version]). to eq(70015)
      expect(result[0][:subver]). to eq('/Satoshi:0.14.1/')
      expect(result[0][:inbound]). to be false
      expect(result[0][:startingheight]). to eq(1210488)
      expect(result[0][:best_hash]). to eq(-1)
      expect(result[0][:best_height]). to eq(-1)
    end
  end

  describe '#sendrawtransaction' do
    it 'should return txid' do
      raw_tx = '0100000001b827a4b3edeb56a5598e22c1a54205de3b9c6b749fbfdb6a494bd1cb550cc93f000000006b483045022100aedbe7fa2f0dff58222d15665471266ff539bf1285b0ce69b22ae030d13535f602206d1272f2437e2e8c5185d59dc51a8169b0fb61b8a7aaa9576a878e8a4baafbe8012103fd8474629e95865deff1b8d72004055b03a87714d8288e33330f2b0a966f46b8ffffffff01adfcdf07000000001976a914f38f47c0b9de955bb9aca788525a8281ed50973b88ac00000000'
      expect(subject.sendrawtransaction(raw_tx)).to eq('dfbf28c96d21bb7f2c3fb278c7cfa85a4b68874db29327dd930aeb31efbe70cb')
    end
  end

  describe '#decoderawtransaction' do
    it 'should return tx hash.' do
      # for legacy tx
      tx = subject.decoderawtransaction('01000000017179acc39e281989c62f1ed77940977a8562d2a03c902c20e1888ecca10e75eb00000000715347304402206945124b3126753fa83e7d4b03c419b6ceb90109cb68386ce81052fafe421fbf022023b0a4fabfea8286cb2102fb44623093abb170c127eeb51049f60a2e45d7abea012721022d4549c2f5aca5697dc232390770a99d6ee6ee139fda0fa0412e77a7bcd4b3eead55935887ffffffff010865f2040000000017a91454080827c0212bce22f827d1728d8480975de9338700000000')
      expect(tx).to include(
                        txid: '6af5fb5448b27f396ad00848e284dc7fe029efa519742fe113ffe63ec429fc32',
                        hash: '6af5fb5448b27f396ad00848e284dc7fe029efa519742fe113ffe63ec429fc32',
                        version: 1, size: 196, vsize: 196, locktime: 0,
                        vin:[{
                            txid: 'eb750ea1cc8e88e1202c903ca0d262857a974079d71e2fc68919289ec3ac7971', vout: 0,
                            script_sig: {
                                asm: '3 304402206945124b3126753fa83e7d4b03c419b6ceb90109cb68386ce81052fafe421fbf022023b0a4fabfea8286cb2102fb44623093abb170c127eeb51049f60a2e45d7abea01 21022d4549c2f5aca5697dc232390770a99d6ee6ee139fda0fa0412e77a7bcd4b3eead55935887',
                                hex: '5347304402206945124b3126753fa83e7d4b03c419b6ceb90109cb68386ce81052fafe421fbf022023b0a4fabfea8286cb2102fb44623093abb170c127eeb51049f60a2e45d7abea012721022d4549c2f5aca5697dc232390770a99d6ee6ee139fda0fa0412e77a7bcd4b3eead55935887'
                            },
                            sequence: 4294967295}],
                        vout: [{
                            value: 0.8299444,
                            n: 0,
                            script_pubkey: {
                                asm: 'OP_HASH160 54080827c0212bce22f827d1728d8480975de933 OP_EQUAL',
                                hex: 'a91454080827c0212bce22f827d1728d8480975de93387',
                                type: 'scripthash',
                                address: '2MzuYNTgfcezpymFsHLGjsNPchnKXwNP7SK'
                            }}]
                    )
      # for segwit tx
      tx = subject.decoderawtransaction('01000000000101cdf9ce825aba7f777899cc76243946a62d9ecb6c9805d30faa5a690d862344d70000000000ffffffff0253a2800200000000160014e3324f11cd2d4715c9d09186d0677d3f18fc0cc8e8c61100000000001976a91498cba7ee7618b76d19b4952a4240b954609b75cb88ac0247304402204ed43722821e458b98295824079ad4a04f5a55df8aa3339e89ebc7138d45e1ca022076b925a51996eb2797a0f870855d73220950e7a91d5d8f0cc11bc9e2c68551ba012103e67c2c0435bd1b6478ae327e4746d788a01e2f6e669506cb1a0515b9a708c74b00000000')
      expect(tx).to include(
                        txid: 'e603a71f500a6db03e5ce89160332c1fabb9adb6f76bae2b983d5257cd3d4421',
                        hash: '56c968fcee7145c47b63f5407acc8e4a337d4b95df79767054e66502078d6d0c',
                        vin:[{
                            txid: 'd74423860d695aaa0fd305986ccb9e2da646392476cc9978777fba5a82cef9cd',
                            vout: 0, script_sig: {asm: '', hex: ''}, sequence: 4294967295,
                            txinwitness: [
                                '304402204ed43722821e458b98295824079ad4a04f5a55df8aa3339e89ebc7138d45e1ca022076b925a51996eb2797a0f870855d73220950e7a91d5d8f0cc11bc9e2c68551ba01',
                                '03e67c2c0435bd1b6478ae327e4746d788a01e2f6e669506cb1a0515b9a708c74b'
                            ]}]
                    )
      # for invalid tx
      expect{subject.decoderawtransaction('hoge')}.to raise_error(ArgumentError)
    end
  end

  describe '#decodescript' do
    context 'p2pkh' do
      it 'should return p2pkh script and addr.' do
        h = subject.decodescript('76a91446c2fbfbecc99a63148fa076de58cf29b0bcf0b088ac')
        expect(h).to include(asm: 'OP_DUP OP_HASH160 46c2fbfbecc99a63148fa076de58cf29b0bcf0b0 OP_EQUALVERIFY OP_CHECKSIG',
                             type: 'pubkeyhash',
                             p2sh: '2MztYDkQ6pdm8o26Eur1QcYRX8D8VP7v3yX',
                             address: 'mmy7BEH1SUGAeSVUR22pt5hPaejo2645F1')
      end
    end
    context 'p2sh' do
      it 'should return p2sh script and addr.' do
        h = subject.decodescript('a9147620a79e8657d066cff10e21228bf983cf546ac687')
        expect(h).to include(asm: 'OP_HASH160 7620a79e8657d066cff10e21228bf983cf546ac6 OP_EQUAL',
                             type: 'scripthash',
                             address: '2N41pqp5vuafHQf39KraznDLEqsSKaKmrij')
      end
    end
    context 'p2wpkh' do
      it 'should return p2wpkh script and addr.' do
        h = subject.decodescript('001446c2fbfbecc99a63148fa076de58cf29b0bcf0b0')
        expect(h).to include(asm: '0 46c2fbfbecc99a63148fa076de58cf29b0bcf0b0',
                             type: 'witness_v0_keyhash',
                             p2sh: '2N3wh1eYqMeqoLxuKFv8PBsYR4f8gYn8dHm',
                             address: 'tb1qgmp0h7lvexdxx9y05pmdukx09xcteu9sx2h4ya')
      end
    end
    context 'p2wsh' do
      it 'should return p2wsh script and addr.' do
        h = subject.decodescript('00203ce1c71303e564430e0c5721727739290046302a9674f1d67a249cfd2ce7d3fd')
        expect(h).to include(asm: '0 3ce1c71303e564430e0c5721727739290046302a9674f1d67a249cfd2ce7d3fd',
                             type: 'witness_v0_scripthash',
                             p2sh: '2MtdzMmaUTSjL72ziauNhZygLNuNc8LNSxg',
                             address: 'tb1q8nsuwycru4jyxrsv2ushyaee9yqyvvp2je60r4n6yjw06t88607sajrpy8')
      end
    end
    context 'multisig' do
      it 'should return multisig script and addrs.' do
        h = subject.decodescript('522102b3c35b692667fe940033aa50ea2f000ef0a67afb4f09f189695f627e55efa4972102d79e3fb71193b0269fe3822ea0fdaec210bd42f7a73679401787aa6932202f642103b0f671f3dda9b42442a82dcdd8d03ad8690c9b55dae6d46e30af3dbf2dd7283553ae')
        expect(h).to include(asm: '2 02b3c35b692667fe940033aa50ea2f000ef0a67afb4f09f189695f627e55efa497 02d79e3fb71193b0269fe3822ea0fdaec210bd42f7a73679401787aa6932202f64 03b0f671f3dda9b42442a82dcdd8d03ad8690c9b55dae6d46e30af3dbf2dd72835 3 OP_CHECKMULTISIG',
                             type: 'multisig', p2sh: '2NBqJTuQRr8848Y9JdrEr7eudmWMTux5uR8')
      end
    end
    context 'contract' do
      it 'should return contract script.' do
        h = subject.decodescript('a914b6ca66aa538d28518852b2104d01b8b499fc9b23876321021525ca2c0cbd42de7e4f5793c79887fbc8b136b5fe98b279581ef6959307f9e96702e803b27521032ad705d98318241852ba9394a90e85f6afc8f7b5f445675040318a9d9ea29e3568ac')
        expect(h).to include(asm: 'OP_HASH160 b6ca66aa538d28518852b2104d01b8b499fc9b23 OP_EQUAL OP_IF 021525ca2c0cbd42de7e4f5793c79887fbc8b136b5fe98b279581ef6959307f9e9 OP_ELSE 1000 OP_CSV OP_DROP 032ad705d98318241852ba9394a90e85f6afc8f7b5f445675040318a9d9ea29e35 OP_ENDIF OP_CHECKSIG',
                             type: 'nonstandard', p2sh: '2MxzAqJzM8xmcerj3oLtTRnXfnaqj7WD6wc')
      end
    end
  end

  describe '#createwallet' do
    before {
      path = test_wallet_path(3)
      FileUtils.rm_r(path) if Dir.exist?(path)
    }
    after {
      path = test_wallet_path(3)
      FileUtils.rm_r(path) if Dir.exist?(path)
    }
    it 'should be create new wallet' do
      result = subject.createwallet(3, TEST_WALLET_PATH)
      expect(result[:wallet_id]).to eq(3)
      expect(result[:mnemonic].size).to eq(12)
    end
  end

  describe '#listwallets' do
    it 'should return wallet list.' do
      result = subject.listwallets(TEST_WALLET_PATH)
      expect(result[0]).to eq(test_wallet_path(1))
    end
  end

  describe '#getwalletinfo' do

    context 'node has no wallet.' do
      subject {
        node_mock = double('node mock')
        allow(node_mock).to receive(:wallet).and_return(nil)
        HandlerMock.new(node_mock)
      }
      it 'should return empty hash' do
        expect(subject.getwalletinfo).to eq({})
      end
    end

    context 'node has wallet.' do
      it 'should return current wallet data' do
        result = subject.getwalletinfo

        expect(result[:wallet_id]).to eq(1)
        expect(result[:version]).to eq(Bitcoin::Wallet::Base::VERSION)
        expect(result[:account_depth]).to eq(1)

        accounts = result[:accounts]
        expect(accounts.size).to eq(1)
        expect(accounts[0][:name]).to eq('Default')
        expect(accounts[0][:path]).to eq("m/84'/1'/0'")
        expect(accounts[0][:type]).to eq('p2wpkh')
        expect(accounts[0][:index]).to eq(0)
        expect(accounts[0][:receive_depth]).to eq(0)
        expect(accounts[0][:change_depth]).to eq(0)
        expect(accounts[0][:look_ahead]).to eq(10)
        expect(accounts[0][:account_key]).to eq('vpub5Y6cjg78GGuNLsaPhmYsiw4gYX3HoQiRBiSwDaBXKUafCt9bNwWQiitDk5VZ5BVxYnQdwoTyXSs2JHRPAgjAvtbBrf8ZhDYe2jWAqvZVnsc')
        expect(accounts[0][:watch_only]).to be false
        expect(accounts[0][:receive_address]).to eq('tb1q6rz28mcfaxtmd6v789l9rrlrusdprr9pqcpvkl')
        expect(accounts[0][:change_address]).to eq('tb1q9u62588spffmq4dzjxsr5l297znf3z6j5p2688')

        master = result[:master]
        expect(master[:encrypted]).to be false
      end
    end
  end

  describe '#listaccounts' do
    context 'node has no wallet.' do
      subject {
        node_mock = double('node mock')
        allow(node_mock).to receive(:wallet).and_return(nil)
        HandlerMock.new(node_mock)
      }
      it 'should return empty array' do
        expect(subject.listaccounts).to eq({})
      end
    end

    context 'node has wallet.' do
      it 'should return the list of account.' do
        result = subject.listaccounts
        expect(result['Default']).to eq(0.0)
      end
    end
  end

  describe '#encryptwallet' do
    it 'should encrypt wallet.' do
      expect(subject.encryptwallet('passphrase')).to eq('The wallet \'wallet_id: 1\' has been encrypted.')
      expect{subject.encryptwallet('passphrase2')}.to raise_error('The wallet is already encrypted.')
    end
  end

  private

  def load_entry(payload, height)
    header = Bitcoin::BlockHeader.parse_from_payload(payload.htb)
    Bitcoin::Store::ChainEntry.new(header, height)
  end

  def load_chain_mock
    chain_mock = create_test_chain
    latest_entry = load_entry('00000020694bc91a15e1c997444790ab9bceef53565d7a987590a1763ffb718f0000000024fe00f0aa7507e54a4a586be1ea7c7d9e077e049e08a8e397da4a4c1a02d14b8d48e459ffff001dc735461c', 1210339)
    allow(chain_mock).to receive(:latest_block).and_return(latest_entry)
    # recent 11 block
    allow(chain_mock).to receive(:find_entry_by_hash).with('68b604283368c219691e6f95fdde8ed258e2f99665e8fd51e598aeec00000000').and_return(latest_entry)
    allow(chain_mock).to receive(:find_entry_by_hash).with('694bc91a15e1c997444790ab9bceef53565d7a987590a1763ffb718f00000000').and_return(load_entry('000000205bbced715d53e085bd293a84566bc1744ee46d00a216732da75003fb00000000a0f199af05f22972246d9a380130e498f03df945f482718ee0787ca6dad24808d843e459ffff001d983d2926', 1210338))
    allow(chain_mock).to receive(:find_entry_by_hash).with('5bbced715d53e085bd293a84566bc1744ee46d00a216732da75003fb00000000').and_return(load_entry('000000208dbb0233bb20ca9416cd7b054c16fb7af907a584d3a3f946730001cd00000000c6c787026a0aef247fcd5a9cd3b403f5a90ad51e7af274b4f960d1ccb5cb92ac243fe459ffff001d979f3162', 1210337))
    allow(chain_mock).to receive(:find_entry_by_hash).with('8dbb0233bb20ca9416cd7b054c16fb7af907a584d3a3f946730001cd00000000').and_return(load_entry('0000002080244a62f307b3b885a253a3614a3fe6e78de3895512d6e8d44d65aa00000000d1574450981c63e36214035a38aeb1d9fa582bac452ac178c75e9dd8efdf9fd9733ae459ffff001d051759a0', 1210336))
    allow(chain_mock).to receive(:find_entry_by_hash).with('80244a62f307b3b885a253a3614a3fe6e78de3895512d6e8d44d65aa00000000').and_return(load_entry('00000020426410aa5fcdca74b3598160417f9e2c986edc8fb8633b7f6000000000000000c928ae0f8ed48979bfbdf851ca8a49198731b8e8830139217043e004ce76881bc235e459ffff001d6496f136', 1210335))
    allow(chain_mock).to receive(:find_entry_by_hash).with('426410aa5fcdca74b3598160417f9e2c986edc8fb8633b7f6000000000000000').and_return(load_entry('00000020f91653ebd7535d498a3cd62db46e939b676a04ae6a35e33f418c0e1800000000b47bfeae2b2201b7b86f34e948099788cfd5ae7fdf1b8fe51bb2651a85946a510d31e45980e17319eee6f292', 1210334))
    allow(chain_mock).to receive(:find_entry_by_hash).with('f91653ebd7535d498a3cd62db46e939b676a04ae6a35e33f418c0e1800000000').and_return(load_entry('00000020cd931c47b454b2d67a99e380cd051f33d316263548748bdee5a6b3ec0000000035c824c91f310d2b19b772fba5f0fcd9e9e8d0f189e47f5064fc7770ef0957bc362fe459ffff001d13beb4a8', 1210333))
    allow(chain_mock).to receive(:find_entry_by_hash).with('cd931c47b454b2d67a99e380cd051f33d316263548748bdee5a6b3ec00000000').and_return(load_entry('00000020949c2f5f9083dd4ec45b2c26c28ca701c0f640d62e52551b4b000000000000009305fca54fae340d5b2c9dceb8a559443d5cfb44504bc939820984cbb26b1e2d852ae459ffff001d6babc9be', 1210332))
    allow(chain_mock).to receive(:find_entry_by_hash).with('949c2f5f9083dd4ec45b2c26c28ca701c0f640d62e52551b4b00000000000000').and_return(load_entry('0000002046194705aa7b0aca636c5a45a3c8857640cddaaab27e44cbc43f5d7f00000000439414cce8f17b94cf2ef654cc96f85e87b5f0a5c615ae474151e02b8ea9f3cdd125e45980e17319eb2ea570', 1210331))
    allow(chain_mock).to receive(:find_entry_by_hash).with('46194705aa7b0aca636c5a45a3c8857640cddaaab27e44cbc43f5d7f00000000').and_return(load_entry('000000206984d6f872f6499432f66d5bb8eec0f30248e79483382af621000000000000007246d107520e77f6b08c8d74ac0b06f4a8e229070ff95dc07b1fc477a68a0b0b7421e459ffff001d0e7bcc94', 1210330))
    allow(chain_mock).to receive(:find_entry_by_hash).with('6984d6f872f6499432f66d5bb8eec0f30248e79483382af62100000000000000').and_return(load_entry('00000020f1bd62cf4502b7f88eeae4bb8cf2caa3615caac0dde9bf064994e4350000000067f8d203143e834fd6572aef4bc961b4f9ef4d18b63d6a73ed6342403406e815bf1ce45980e173198907b9ad', 1210329))
    allow(chain_mock).to receive(:find_entry_by_hash).with('f1bd62cf4502b7f88eeae4bb8cf2caa3615caac0dde9bf064994e43500000000').and_return(load_entry('04000000587b7ec2f7b00aecadc816f74c4734f5d3b57744fa98061b2452245300000000acf407f07491f3c7e326702c84c2319b98989b1d287e612385b35f01bb49a29e7518e459ffff001d40cce489', 1210328))
    allow(chain_mock).to receive(:find_entry_by_hash).with('587b7ec2f7b00aecadc816f74c4734f5d3b57744fa98061b2452245300000000').and_return(load_entry('00000020b5b07293524eece44221a180a6c67538b5685b474015993ea9422e7600000000ae01949e6bac5a828216d89ea91fc7dfe0bee5488644c7f228e15e0b87b3322fc113e459ffff001d5ef80539', 1210327))
    allow(chain_mock).to receive(:find_entry_by_hash).with('b5b07293524eece44221a180a6c67538b5685b474015993ea9422e7600000000').and_return(load_entry('00000020fbf65774599e7bf53452a61f0784f30159ffa98e4bfa7091624bb3760000000012e5e283f096b9c14669c38049f4012462f48adb7d7d5e6dc32f3576688ef5480c0fe459ffff001dabe97de2', 1210326))
    allow(chain_mock).to receive(:find_entry_by_hash).with('00').and_return(nil)

    # previous block
    allow(chain_mock).to receive(:next_hash).with('5bbced715d53e085bd293a84566bc1744ee46d00a216732da75003fb00000000').and_return('694bc91a15e1c997444790ab9bceef53565d7a987590a1763ffb718f00000000')
    chain_mock
  end

  def load_pool_mock(chain)
    node_mock = double('node mock')
    conn1 = double('connection_mock1')
    conn2 = double('connection_mock1')
    allow(conn1).to receive(:version).and_return(Bitcoin::Message::Version.new(
        version: 70015, user_agent: '/Satoshi:0.14.1/', start_height: 1210488,
        remote_addr: Bitcoin::Message::NetworkAddr.new(ip: '192.168.0.3', port: 60519, time: nil), services: 12
    ))
    allow(conn2).to receive(:version).and_return(Bitcoin::Message::Version.new)

    configuration = Bitcoin::Node::Configuration.new(network: :testnet)
    pool = Bitcoin::Network::Pool.new(node_mock, chain, configuration)

    peer1 =Bitcoin::Network::Peer.new('192.168.0.1', 18333, pool, configuration)
    peer1.id = 1
    peer1.last_send = 1508305982
    peer1.last_recv = 1508305843
    peer1.bytes_sent = 31298
    peer1.bytes_recv = 1804
    peer1.conn_time = 1508305774
    peer1.last_ping = 1508386048
    peer1.last_pong = 1508979481

    allow(peer1).to receive(:conn).and_return(conn1)
    pool.peers << peer1

    peer2 =Bitcoin::Network::Peer.new('192.168.0.2', 18333, pool, configuration)
    peer2.id = 2
    allow(peer2).to receive(:conn).and_return(conn2)
    pool.peers << peer2

    pool
  end

end