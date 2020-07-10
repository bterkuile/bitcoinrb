require 'spec_helper'

describe Bitcoin::Message::BlockTxn do

  describe '#parse_from_payload' do
    subject {
      Bitcoin::Message::BlockTxn.parse_from_payload('ca8fb932735c229005040eeefed540f36dfab54c68acd92e54ad69c20000000005010000000348bff409521a2b6df897395ed10f45e6b65f0f7ba27d3267d8224b57aed9b005030000006b483045022100a93928985b5fcac79e41747ab6d430689e9cb57944e2e4a192e7f11b565932fc022021b7709e9212f9c367d02da30b3f5b77b5c7c61986bd9b647a259ab659288f55012103b64e32e5f62e03701428fb1e3151e9a57f149c67708f6164a235c8199fe17cc2ffffffff3799187d9aeae85a91816fea98476bcee5d937884f10bdaa313bf38b16a943a5020000006b483045022100ffe6ab6b9055f26b4a40bca06c417f1e0edd5c1d83766246f8501490e194035b022040b1793e7441855511312aca8938e03c031f2d86a70f1498d7f2f4c3666d6afb012103b64e32e5f62e03701428fb1e3151e9a57f149c67708f6164a235c8199fe17cc2ffffffffc411a8dab81309bee99ed4a9f6e12d24815f36bcde44fc170902c0830a1193a9030000006b483045022100b94d5be7b1910ea3a9c3f7a8f31a7f084d928f89a6b168ef8b417ba25f65df60022007625c7449f9654795c4aecfda5bccdb8301ba96b9d79531c83b447145c80319012103b64e32e5f62e03701428fb1e3151e9a57f149c67708f6164a235c8199fe17cc2ffffffff0550c30000000000001976a914b67c959f7c168d790bbcbd58cb0bdee15e9e51a088ac50c30000000000001976a914b67c959f7c168d790bbcbd58cb0bdee15e9e51a088aca0860100000000001976a91413d35ad337dd80a055757e5ea0a45b59fee3060c88ac007a5005000000001976a91413d35ad337dd80a055757e5ea0a45b59fee3060c88ac0000000000000000026a0000000000010000000254f06e611b3d7637cce6085e5b2b0d9d29862bad59fb8dde7141cccf4537e39401000000fde40300473044022032da08e93459054b602eaffa804811170ca4ca34726de6f82691c6df7b76d65a02201347af08425ec2183fb4c8eba251fe2b4d9fdd56c4c7a8e98802216f4c940bd801473044022045dd992b90b7425cb105890a6e6cd34733c27603346d93166043966de857831002203adebcefbcc0189f3d523ecb7787d74cb2a8049437f25776df0f62e9e44a24980147304402205ef2bbadee85b74e69ee12f824ad770c9d7cf916c5ddae231291fb8ac45226f3022046e6f8d990d99806ad783a66bc0425d24f87694d87608c51f9efc4cc9ecbd9be01483045022100b603234134f74677de09ff1850038894a0fa1a584f50bdde1288b2e9f2bb462902207a47092343f2b2ab58dd08cac670e310603efc4bf6dcf24de6f6635617325a6301483045022100df589106e2cb3c10bb7ca2c874881e9d73a58d5ee4fefe67e0f55c4ab2b5f4af0220167a1920912f576b51eab3301aee52d6d77de6271b7c0482d717559ddf5fe8a4014830450221009853a22429d8217a35e4ee0f8813ebcc809d0d1f090a6e7516c0f3b3d5efe3aa022079df777ebf17dae85520ef4a14b3468e4e70b2b6fdca254d99d1991e6bd64a9a01483045022100fdbf9e1ace4ebf4622f3a77def98223d05af09a0c8df952f9d6b04e195e48a0e02203ccd923d2cc3ab849a82b172eb352ad60f9db4ca8adf18517856e5906cf34efc01483045022100a59eee9e301f31156a1ed52f8c13ded5351e8bebf95cd9e68b8b35d0b711c3fb02201fe7c06bf85a9ad1c0b6e2618cafda0fa7d91f236b62db7e151925744d041e2f014d9b015821021effdf18b93b4fe1133b1db861ecca6063c6739da3ec37faed78a9049c04d6e521039f0ec095f35a7be9e1ea5c87d67f26162d14b8a1315b45d019b499e7c7a25a2021020237276ac589a4103975fee8a7fc95def5a05f499f76fccd07310ad37f05dfad21027033aa382ac656de1d5dd7d85225d32c14c7345756d6d07f86eae9d82d74dbed21020393cb40e7fe97772698e5ace6e726c0c01ad25359ac9863c6a7bad7fb28d5322102d2a2eab9bb0f4410493d43ee8c0ad984458f36115cc2317813711b107dbd3192210267fb52df3c41b9de1e3ba5f19e87e2e33572a0fe06de808a4dbae1f31d2741ac210245c828c6f2af5b6d422b9bdfba932ae3bfabf59ecc0e767e2a08d0885a46f40f2102da907afb9869b1e9d55e673c1a2a727cbf98614f38f6cd348f683f5e1f4796c92102e1d680dfeaa157b31bd0dcc7d0f53081f53051284afab8472c6b518da2dd6d5f210227c9f50e7bef4a64c06c0061ab956b7e68a3a8ca7d9aa2b5946e0836e53fc79d2103653f0c36a042b59316f77332bae703e4af02a6fa23766e728241128a7c0859b65cae4f414d4c0640c64d22d5896151cea50be9e97c26d9467865d982140df44b58cd8ada067004000000fde1030047304402201ffe54928d32bfac02ccf7766180b0c494916f48857871f0aaa3e3579ee6778802207a2b3517c738ece1f8a6c57e0cc10bed86b2d6cdd530470fc7ce237fb069a01d0147304402203c167b4638c1451aab7586274d600ad69da55199d4b1cb1ab882cd68a8dd46c002200c1c573e9070b4e7e1d7921e8b8de133d834c02485497a21472d9c9341c04b9401473044022005d212352189f15c16b9ec74dc50d6915ad393875aea513cf0d01c7055f98886022044ea489e1a37216cfd23e07c278d40de911e7b54bb908d82d1ab485982909d8a0147304402204a0b58f9e5402a179216a73c1f82c122aae8183221a2bd51089ef6a65dc4105702202a28fed756d09020e1dd0183c9c0916acdfc06fe65faf756a0a1394d27a6fe34014830450221009a4ec3f90d6165967c206962e5ccc5f06c508ca84aaa7691ef50786e00e526370220193019d083248bca3cc9ac279177a90bbb3774aaf9c71280e5b24fd30c9acdca0147304402200a6bea4bbec1cfdcd764c4853f496ef2be7b9f76e0c85d9ad9019ccded06a63f0220314dcf8f916d833c9b0690d25d4fe49626ab5407641ee39ed20b7111e8b4868701483045022100a2b0490a250464279990f43a8813b0d580cc2b5dbf1f66532be8c9d2d2bfb344022029b5c342a8c85a255005cdf6a20bf26653e087e81ca54c1675d861dda4cf6eb001473044022061f452485613a3ef626cd83cab84ac2f093c087f2c83c18b16078e100f0b47a00220255657ec3aff71a1c5adbb4cb285403fd88f5ce5b180e518b4d6cd35b59932b6014d9b0158210244fd32f86e5f7da8a1257fa11b582f65a777a80c0f9a38631bc9091a6b9a8e3721032b2690c7a9dfd21fa8a4cb27805bd0a22715f08a64e424e40bb1fa7cfbff392f2103bc10bcb266ffadfdaaac7f9442b05b8484cd4da791f4731e9c258f8739c79b2921037b68818ae80c7b664442698a4a0770f1cf08eee844d3343c3c683a3d2e5511642102b01100e69a30ab6566a27434b4ef42bd822711474928de4e3237b6dc19c3069d210316f8f6e5803ef8aac8990309efecb4e91ea343580dc38f39002dc4086711670521036fa22efed38ea580449eee44013cc1a4a0213de20c85addab91f99d4aa36709521031b1aa435b022c4b18b607a2142294f3c8f71612409b64b55155ce2e9b50f7c402103b2fa1afd34790604b3baa3b1e7f5ca6e070cc6d5d10d596c57f9a1e04771d3662103813fcbec71c32dd78bd239c85747bd39322b2887ab349bbd088216ee073eee5321022f855d955932b271d294be1f4561a86282d9990ebfbcede5b6c4133fd10377ac2102aa3daaffcb4afb869ba0da34a4bed7baff3cb5dce784c76f785a16b216f91b975cae4f414d4c0240420f00000000001976a914258833938c24cd90d66c8eaf298ef345007cde6088ac9fb608000000000017a914fc0526bbcaf63f3a8eca9b625726c2536e1386a887000000000100000002c73922a4fbba37f7187c6dbf51eb0a7aec0d58970352939ff1b455584ee58c1a000000006b48304502210082442f6d0c85b12a763dd14f56d9d19bb285008563845da49bab722fe5c3b5d902201459c1a6ce8fb6a22dc847cbceaa787c08dfc1c0a75d522ce9eef565b374c384012102fc4de30aafbc7ea2c65722a2e843711ecb687017f957ebf4ccbd077dfcdc47ddffffffffffe2f3d91ffdf117a3907ae9830d0196c0726ac2cff8093575fd1df57b848072000000006b483045022100a29ad563de417154151bde618824994524ff4682c00a12888e032f67b8ffb5d5022025e149e2ebe933d38886b141b1b7e2980e63226b23729cf8ce83343fd415fb1c012102fc4de30aafbc7ea2c65722a2e843711ecb687017f957ebf4ccbd077dfcdc47ddffffffff0358020000000000001976a9140a19a64be18e637918b7cab96171dc2fe113610d88ac00000000000000000b6a09434302150060e620a058020000000000001976a9143f1eaa9220750b05cb6ac452f0a571dc707ae22f88ac000000000100000003bda24b0223e9fdb26c052d8833bfdf7af99b720b400402f2411b9a2294608a43010000006a473044022069d7edc38691a7a733d4dd7f81c92bd11f0f9fecc73c9544c24fd52e82f8027c022023b132b6723190393ae6bc4b5eb2186b63481443eb85b10a856285b90403f3b601210330730a109e15d40ba5d4ca358e298e49431c7f9a6e2985e87bacc021e479fe51feffffff14543a52ff419a57d1e6da635edce6e6f86e71ae472ef74897dbc80838423844000000006a473044022036f9a11e04ff85307862c5afec546874b3fd24824727a7505524b95147d4983a0220284d91cb5b29a6638d46a085fdac42d04ada05088187fd06d9b231ce2657b2af012103ada2e955ec4cbbf3c9393f6b55c3e91d138e3f9229ac52febf70b6ca396f1b40feffffffc4502e7af349ba91fa98be17c8f2230b6b177a0cdf3170054178cf69d8b8993f000000006a473044022061699a1c5570151585b4479fc76b72054c9b8373cbcf46a874b972602830e2e40220599834a1fbb481c99afcf2a1e66a6e8ccca8671ac1f57ed0a2ac692377c5e9f0012103e01e3f526b265dcd96770703e8fea93be29d1daa268d8394a515a83f048fc083feffffff023c3313000000000017a914e3ef292a8b9fbbf7d62ee0e2b353855013e31fd687f0791b00000000001976a91440bb537c818c2e646ec5e470d6f8a59c8d96a74288ac2fb50d000100000001677274602db90c30abf663da46d90606e602884c325a14a15fbe943fe8d970a6010000006b483045022100e76199f83d8a09134f554167e496d0f728685741a28882873b8814ed88d5dfdf0220488733bed50a41cfc29e3a4421e4699cd39ec7f9f8b305786f6fb0b0ba05a1c20121030fd8a8061d77a58695bd1d5aa192c7e595447ad3367cd11fc38514df45962ca8feffffff021b938d46000000001976a9140f40d58a69e60c42eec18283a098fb032924295a88acdaf713000000000017a9141b6d83400e5064b61c6bb4bde797fe3bf3518547872fb50d00'.htb)
    }
    it 'should be parsed.' do
      expect(subject.block_transactions.block_hash).to eq('ca8fb932735c229005040eeefed540f36dfab54c68acd92e54ad69c200000000')
      expect(subject.block_transactions.transactions.size).to eq(5)
      expect(subject.block_transactions.transactions[0].txid).to eq('20ef51c519405697987a2fcc2ac29a2226b750524b272443a5c17858bafc2932')
      expect(subject.block_transactions.transactions[1].txid).to eq('4372f2bf6e86d42f767e8ae4e4ec9eebece4bffa3f77427ed0a08f7bdb069464')
      expect(subject.block_transactions.transactions[2].txid).to eq('a0eb1f2b6b4e2d2557685d9d3b83e9ede1809940b9c62429a85a73d3177a1dfe')
      expect(subject.block_transactions.transactions[3].txid).to eq('015357249cb4d6fcf44fa9b043f503361d63fbe27dadcdf3e2f00db95fe0da9c')
      expect(subject.block_transactions.transactions[4].txid).to eq('c2e546b944d5a70d853b74818cced4f416ece64d3fb0b9fb2c0977ff74968f77')
      expect(subject.to_hex).to eq('ca8fb932735c229005040eeefed540f36dfab54c68acd92e54ad69c20000000005010000000348bff409521a2b6df897395ed10f45e6b65f0f7ba27d3267d8224b57aed9b005030000006b483045022100a93928985b5fcac79e41747ab6d430689e9cb57944e2e4a192e7f11b565932fc022021b7709e9212f9c367d02da30b3f5b77b5c7c61986bd9b647a259ab659288f55012103b64e32e5f62e03701428fb1e3151e9a57f149c67708f6164a235c8199fe17cc2ffffffff3799187d9aeae85a91816fea98476bcee5d937884f10bdaa313bf38b16a943a5020000006b483045022100ffe6ab6b9055f26b4a40bca06c417f1e0edd5c1d83766246f8501490e194035b022040b1793e7441855511312aca8938e03c031f2d86a70f1498d7f2f4c3666d6afb012103b64e32e5f62e03701428fb1e3151e9a57f149c67708f6164a235c8199fe17cc2ffffffffc411a8dab81309bee99ed4a9f6e12d24815f36bcde44fc170902c0830a1193a9030000006b483045022100b94d5be7b1910ea3a9c3f7a8f31a7f084d928f89a6b168ef8b417ba25f65df60022007625c7449f9654795c4aecfda5bccdb8301ba96b9d79531c83b447145c80319012103b64e32e5f62e03701428fb1e3151e9a57f149c67708f6164a235c8199fe17cc2ffffffff0550c30000000000001976a914b67c959f7c168d790bbcbd58cb0bdee15e9e51a088ac50c30000000000001976a914b67c959f7c168d790bbcbd58cb0bdee15e9e51a088aca0860100000000001976a91413d35ad337dd80a055757e5ea0a45b59fee3060c88ac007a5005000000001976a91413d35ad337dd80a055757e5ea0a45b59fee3060c88ac0000000000000000026a0000000000010000000254f06e611b3d7637cce6085e5b2b0d9d29862bad59fb8dde7141cccf4537e39401000000fde40300473044022032da08e93459054b602eaffa804811170ca4ca34726de6f82691c6df7b76d65a02201347af08425ec2183fb4c8eba251fe2b4d9fdd56c4c7a8e98802216f4c940bd801473044022045dd992b90b7425cb105890a6e6cd34733c27603346d93166043966de857831002203adebcefbcc0189f3d523ecb7787d74cb2a8049437f25776df0f62e9e44a24980147304402205ef2bbadee85b74e69ee12f824ad770c9d7cf916c5ddae231291fb8ac45226f3022046e6f8d990d99806ad783a66bc0425d24f87694d87608c51f9efc4cc9ecbd9be01483045022100b603234134f74677de09ff1850038894a0fa1a584f50bdde1288b2e9f2bb462902207a47092343f2b2ab58dd08cac670e310603efc4bf6dcf24de6f6635617325a6301483045022100df589106e2cb3c10bb7ca2c874881e9d73a58d5ee4fefe67e0f55c4ab2b5f4af0220167a1920912f576b51eab3301aee52d6d77de6271b7c0482d717559ddf5fe8a4014830450221009853a22429d8217a35e4ee0f8813ebcc809d0d1f090a6e7516c0f3b3d5efe3aa022079df777ebf17dae85520ef4a14b3468e4e70b2b6fdca254d99d1991e6bd64a9a01483045022100fdbf9e1ace4ebf4622f3a77def98223d05af09a0c8df952f9d6b04e195e48a0e02203ccd923d2cc3ab849a82b172eb352ad60f9db4ca8adf18517856e5906cf34efc01483045022100a59eee9e301f31156a1ed52f8c13ded5351e8bebf95cd9e68b8b35d0b711c3fb02201fe7c06bf85a9ad1c0b6e2618cafda0fa7d91f236b62db7e151925744d041e2f014d9b015821021effdf18b93b4fe1133b1db861ecca6063c6739da3ec37faed78a9049c04d6e521039f0ec095f35a7be9e1ea5c87d67f26162d14b8a1315b45d019b499e7c7a25a2021020237276ac589a4103975fee8a7fc95def5a05f499f76fccd07310ad37f05dfad21027033aa382ac656de1d5dd7d85225d32c14c7345756d6d07f86eae9d82d74dbed21020393cb40e7fe97772698e5ace6e726c0c01ad25359ac9863c6a7bad7fb28d5322102d2a2eab9bb0f4410493d43ee8c0ad984458f36115cc2317813711b107dbd3192210267fb52df3c41b9de1e3ba5f19e87e2e33572a0fe06de808a4dbae1f31d2741ac210245c828c6f2af5b6d422b9bdfba932ae3bfabf59ecc0e767e2a08d0885a46f40f2102da907afb9869b1e9d55e673c1a2a727cbf98614f38f6cd348f683f5e1f4796c92102e1d680dfeaa157b31bd0dcc7d0f53081f53051284afab8472c6b518da2dd6d5f210227c9f50e7bef4a64c06c0061ab956b7e68a3a8ca7d9aa2b5946e0836e53fc79d2103653f0c36a042b59316f77332bae703e4af02a6fa23766e728241128a7c0859b65cae4f414d4c0640c64d22d5896151cea50be9e97c26d9467865d982140df44b58cd8ada067004000000fde1030047304402201ffe54928d32bfac02ccf7766180b0c494916f48857871f0aaa3e3579ee6778802207a2b3517c738ece1f8a6c57e0cc10bed86b2d6cdd530470fc7ce237fb069a01d0147304402203c167b4638c1451aab7586274d600ad69da55199d4b1cb1ab882cd68a8dd46c002200c1c573e9070b4e7e1d7921e8b8de133d834c02485497a21472d9c9341c04b9401473044022005d212352189f15c16b9ec74dc50d6915ad393875aea513cf0d01c7055f98886022044ea489e1a37216cfd23e07c278d40de911e7b54bb908d82d1ab485982909d8a0147304402204a0b58f9e5402a179216a73c1f82c122aae8183221a2bd51089ef6a65dc4105702202a28fed756d09020e1dd0183c9c0916acdfc06fe65faf756a0a1394d27a6fe34014830450221009a4ec3f90d6165967c206962e5ccc5f06c508ca84aaa7691ef50786e00e526370220193019d083248bca3cc9ac279177a90bbb3774aaf9c71280e5b24fd30c9acdca0147304402200a6bea4bbec1cfdcd764c4853f496ef2be7b9f76e0c85d9ad9019ccded06a63f0220314dcf8f916d833c9b0690d25d4fe49626ab5407641ee39ed20b7111e8b4868701483045022100a2b0490a250464279990f43a8813b0d580cc2b5dbf1f66532be8c9d2d2bfb344022029b5c342a8c85a255005cdf6a20bf26653e087e81ca54c1675d861dda4cf6eb001473044022061f452485613a3ef626cd83cab84ac2f093c087f2c83c18b16078e100f0b47a00220255657ec3aff71a1c5adbb4cb285403fd88f5ce5b180e518b4d6cd35b59932b6014d9b0158210244fd32f86e5f7da8a1257fa11b582f65a777a80c0f9a38631bc9091a6b9a8e3721032b2690c7a9dfd21fa8a4cb27805bd0a22715f08a64e424e40bb1fa7cfbff392f2103bc10bcb266ffadfdaaac7f9442b05b8484cd4da791f4731e9c258f8739c79b2921037b68818ae80c7b664442698a4a0770f1cf08eee844d3343c3c683a3d2e5511642102b01100e69a30ab6566a27434b4ef42bd822711474928de4e3237b6dc19c3069d210316f8f6e5803ef8aac8990309efecb4e91ea343580dc38f39002dc4086711670521036fa22efed38ea580449eee44013cc1a4a0213de20c85addab91f99d4aa36709521031b1aa435b022c4b18b607a2142294f3c8f71612409b64b55155ce2e9b50f7c402103b2fa1afd34790604b3baa3b1e7f5ca6e070cc6d5d10d596c57f9a1e04771d3662103813fcbec71c32dd78bd239c85747bd39322b2887ab349bbd088216ee073eee5321022f855d955932b271d294be1f4561a86282d9990ebfbcede5b6c4133fd10377ac2102aa3daaffcb4afb869ba0da34a4bed7baff3cb5dce784c76f785a16b216f91b975cae4f414d4c0240420f00000000001976a914258833938c24cd90d66c8eaf298ef345007cde6088ac9fb608000000000017a914fc0526bbcaf63f3a8eca9b625726c2536e1386a887000000000100000002c73922a4fbba37f7187c6dbf51eb0a7aec0d58970352939ff1b455584ee58c1a000000006b48304502210082442f6d0c85b12a763dd14f56d9d19bb285008563845da49bab722fe5c3b5d902201459c1a6ce8fb6a22dc847cbceaa787c08dfc1c0a75d522ce9eef565b374c384012102fc4de30aafbc7ea2c65722a2e843711ecb687017f957ebf4ccbd077dfcdc47ddffffffffffe2f3d91ffdf117a3907ae9830d0196c0726ac2cff8093575fd1df57b848072000000006b483045022100a29ad563de417154151bde618824994524ff4682c00a12888e032f67b8ffb5d5022025e149e2ebe933d38886b141b1b7e2980e63226b23729cf8ce83343fd415fb1c012102fc4de30aafbc7ea2c65722a2e843711ecb687017f957ebf4ccbd077dfcdc47ddffffffff0358020000000000001976a9140a19a64be18e637918b7cab96171dc2fe113610d88ac00000000000000000b6a09434302150060e620a058020000000000001976a9143f1eaa9220750b05cb6ac452f0a571dc707ae22f88ac000000000100000003bda24b0223e9fdb26c052d8833bfdf7af99b720b400402f2411b9a2294608a43010000006a473044022069d7edc38691a7a733d4dd7f81c92bd11f0f9fecc73c9544c24fd52e82f8027c022023b132b6723190393ae6bc4b5eb2186b63481443eb85b10a856285b90403f3b601210330730a109e15d40ba5d4ca358e298e49431c7f9a6e2985e87bacc021e479fe51feffffff14543a52ff419a57d1e6da635edce6e6f86e71ae472ef74897dbc80838423844000000006a473044022036f9a11e04ff85307862c5afec546874b3fd24824727a7505524b95147d4983a0220284d91cb5b29a6638d46a085fdac42d04ada05088187fd06d9b231ce2657b2af012103ada2e955ec4cbbf3c9393f6b55c3e91d138e3f9229ac52febf70b6ca396f1b40feffffffc4502e7af349ba91fa98be17c8f2230b6b177a0cdf3170054178cf69d8b8993f000000006a473044022061699a1c5570151585b4479fc76b72054c9b8373cbcf46a874b972602830e2e40220599834a1fbb481c99afcf2a1e66a6e8ccca8671ac1f57ed0a2ac692377c5e9f0012103e01e3f526b265dcd96770703e8fea93be29d1daa268d8394a515a83f048fc083feffffff023c3313000000000017a914e3ef292a8b9fbbf7d62ee0e2b353855013e31fd687f0791b00000000001976a91440bb537c818c2e646ec5e470d6f8a59c8d96a74288ac2fb50d000100000001677274602db90c30abf663da46d90606e602884c325a14a15fbe943fe8d970a6010000006b483045022100e76199f83d8a09134f554167e496d0f728685741a28882873b8814ed88d5dfdf0220488733bed50a41cfc29e3a4421e4699cd39ec7f9f8b305786f6fb0b0ba05a1c20121030fd8a8061d77a58695bd1d5aa192c7e595447ad3367cd11fc38514df45962ca8feffffff021b938d46000000001976a9140f40d58a69e60c42eec18283a098fb032924295a88acdaf713000000000017a9141b6d83400e5064b61c6bb4bde797fe3bf3518547872fb50d00')
    end
  end

end