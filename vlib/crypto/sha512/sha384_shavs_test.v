// These tests are derived from the Secure Hash Algorithm Validation System
// test vectors contained in:
// https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Algorithm-Validation-Program/documents/shs/shabytetestvectors.zip
//
// For SHA384, the test vectors come from:
//     SHA384ShortMsg.rsp
import crypto.sha512
import encoding.hex

// This structure deals with short message tests
struct SHA384TestCase {
	name    string
	message string
	digest  string
}

// short message test cases
const short_cases = [
	SHA384TestCase{
		name:    'test case 0'
		message: ''
		digest:  '38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b'
	},
	SHA384TestCase{
		name:    'test case 1'
		message: 'c5'
		digest:  'b52b72da75d0666379e20f9b4a79c33a329a01f06a2fb7865c9062a28c1de860ba432edfd86b4cb1cb8a75b46076e3b1'
	},
	SHA384TestCase{
		name:    'test case 2'
		message: '6ece'
		digest:  '53d4773da50d8be4145d8f3a7098ff3691a554a29ae6f652cc7121eb8bc96fd2210e06ae2fa2a36c4b3b3497341e70f0'
	},
	SHA384TestCase{
		name:    'test case 3'
		message: '1fa4d5'
		digest:  'e4ca4663dff189541cd026dcc056626419028774666f5b379b99f4887c7237bdbd3bea46d5388be0efc2d4b7989ab2c4'
	},
	SHA384TestCase{
		name:    'test case 4'
		message: '50e3853d'
		digest:  '936a3c3991716ba4c413bc03de20f5ce1c63703b3a5bdb6ab558c9ff70d537e46eb4a15d9f2c85e68d8678de5682695e'
	},
	SHA384TestCase{
		name:    'test case 5'
		message: '4b5fab61e0'
		digest:  'fb390aa5b70b068a54d6d5127df6a6227becc4d6f891fd3f6068b917a883c9b66f318fddb6384d10be8c7af0d3132f03'
	},
	SHA384TestCase{
		name:    'test case 6'
		message: 'dad95a4b4d37'
		digest:  '3a2b40f453925bc3ce17d640757ee0e899390b4a8d984d0297c1bae6b60b9f2603bf71c323fd171011372335e5702e40'
	},
	SHA384TestCase{
		name:    'test case 7'
		message: '121835fe3700b7'
		digest:  '7bd06a94acba7beb3c5a9b9e8769c3da6691c482d78b1e5c7619b36630eba4e596d11c410a4c87006f4716b6f17bb9a0'
	},
	SHA384TestCase{
		name:    'test case 8'
		message: 'de60275bdafce4b1'
		digest:  'a3d861d866c1362423eb21c6bec8e44b74ce993c55baa2b6640567560ebecdaeda07183dbbbd95e0f522caee5ddbdaf0'
	},
	SHA384TestCase{
		name:    'test case 9'
		message: '8d45a55d5ce1f928e6'
		digest:  'de76683575a050e2eb5ef95ee201f82416478a1d14bf3d96d1fd4efd52b1a28fed8dfee1830070001dc102a21f761d20'
	},
	SHA384TestCase{
		name:    'test case 10'
		message: '5c7dde9b3894d73cefe1'
		digest:  'f31b22115fa7178e78223e06aae870547ab93c6eb3c3910b0ee16e6106db55935d6c0eb820132a2078ece1067efc81c3'
	},
	SHA384TestCase{
		name:    'test case 11'
		message: '967fa34c07e4945a77051a'
		digest:  'f8f24d81c4f8f23ecb42d76ed5d2b34c9cbc1f0a97234d1114804b5999759f3131c741d5768cc928163503c5f55f594b'
	},
	SHA384TestCase{
		name:    'test case 12'
		message: '2209112ee779bf6d95711105'
		digest:  '09c54bf533a26c7447caa5783db2ec7ef5e55752da7f2a2c4e360982a94ec1ca2cb6a157d34eed28de978b4145e17ebc'
	},
	SHA384TestCase{
		name:    'test case 13'
		message: '20442e1c3f3c88919c39978b78'
		digest:  '50bc95b036e0f54d833032a80d45c2ac38b3d29e9c7f72a2eb14781e9241d2a4b8e8dba6ee6f4c9e46a758d5712dbd39'
	},
	SHA384TestCase{
		name:    'test case 14'
		message: '4d43702be4f0530319555d7f1a33'
		digest:  '83c8f0bb762801eb26cc5115abebb657c18ff811de500b32b7a568a220a287e900b6c75224fe7429169fbd534cb588e1'
	},
	SHA384TestCase{
		name:    'test case 15'
		message: '5e2a79a544af85f150f7a9d209fd44'
		digest:  '8051ebc9cabb052cabe07e4023e2140808b77d25b07b96d2e3c22393f71b116c1a1e41bf62e57f73ff67871da7c93cf9'
	},
	SHA384TestCase{
		name:    'test case 16'
		message: 'e1bb967b5d379a4aa39050274d09bd93'
		digest:  '3b04f96965ad2fbabd4df25d5d8c95589d069c312ee48539090b2d7b495d2446c31eb2b8f8ffb3012bdce065323d9f48'
	},
	SHA384TestCase{
		name:    'test case 17'
		message: 'bb84a014cd17cc232c98ae8b0709917e9d'
		digest:  '85227ae057f2082adf178cae996449100b6a3119e4c415a99e25be6ef20ba8c0eae818d60f71c5c83ff2d4c59aa75263'
	},
	SHA384TestCase{
		name:    'test case 18'
		message: 'c3411a0592f1f4fa698815238997db356418'
		digest:  '233ac44170d9f452a1a0231622030b15c104ff8ecaa3fccdb9e9e5031fd5b4220186a8edd032849c8b93dc183a5c8627'
	},
	SHA384TestCase{
		name:    'test case 19'
		message: 'e831b739e8eb9f787f63c0bb071ddcc9f44cab'
		digest:  '91722d4b7aecc211bb8a5480c6855f3b71be4647e1dde0380c23afaa03f45c642606a24506e0317bf51506a483de28ac'
	},
	SHA384TestCase{
		name:    'test case 20'
		message: 'b8a7bbccde46e85f1223237d9353b78c3b19727b'
		digest:  '28ba69dc05e6e29de91924114d6c9fc7612f6d2a68b07fa001df059bcf98f7aa85389caeb966eaa299c79fe1fd1e40e3'
	},
	SHA384TestCase{
		name:    'test case 21'
		message: 'cf391b8aabec6f81288c8b7b92843be23d2e847574'
		digest:  '121e5ef697df491a53d7bae121416aa653d759a37db9d0b993031b18a0ef160ed98842a291e1ba2cea8b998bc5eee0b1'
	},
	SHA384TestCase{
		name:    'test case 22'
		message: '9d65d88bffed764c286f34894f991600d1a67d622382'
		digest:  '84b6e0d6a45329daf47a793418ed5dbde01336b4b9468bb69e5da61c42b691e6794e6ed0e8fb1b8e7d4cd3cbaadc520a'
	},
	SHA384TestCase{
		name:    'test case 23'
		message: 'bab6ea46fb717f73f0628132a2b96be383774f1e5d8b6d'
		digest:  'e969aca1b50e928cad29a0d756457f6de8d7a4e589fd41e53a1e758c3b20f9b81b36bf098a49102fbf869651ca9a98b5'
	},
	SHA384TestCase{
		name:    'test case 24'
		message: '8853b00e869764adb527a07b073c85a24e6c208ba47eef4e'
		digest:  '09ad44e85ac190e2d1c3ceb4efbea10ded34d0de961fe4ee268132c48e38660e6cf585bfffb8f7b00b0fad1514312b63'
	},
	SHA384TestCase{
		name:    'test case 25'
		message: '71fe1ba5d299495d2a56039c64032ec6263d437f55e3f5bedb'
		digest:  'b41a5d3b4af6d4b9c349e0788538e9a0311086894df7b72cf5aaf4091a7e039e4e89cc77a123474e6d1bac438e5e9f88'
	},
	SHA384TestCase{
		name:    'test case 26'
		message: '4ebe07d03c93e849b4bbfe9f2d2294bf6ccab457f76d3f99cb64'
		digest:  'beba464d7065185587fad89bfcea9635bf0ab775c3eb8c147b5b2bd8601db6dba0590b50dd1068733f20dc68e004a090'
	},
	SHA384TestCase{
		name:    'test case 27'
		message: '918ac0a97ec1632908489e5242ba284bc811aa7197242cf7226fcd'
		digest:  'c4baf6397a4c6e26492b63a4aab7dffdd0051d8f51938ac24cfd8dae2f7afed1a4aa2430d7aeb0be2a72b21a6c50198c'
	},
	SHA384TestCase{
		name:    'test case 28'
		message: '97477f7272d8a89e38e796c533e9f8a8ae4c92ccaa5d907ed26a1a15'
		digest:  'd1ad524ebe908d7c5aff50e6cb780fd3a70e87c914a36b93c4e35f5b2cb03850b122b480ef8587d4a44f22467f4c480c'
	},
	SHA384TestCase{
		name:    'test case 29'
		message: '718e0cfe1386cb1421b4799b15788b862bf03a8072bb30d02303888032'
		digest:  '6d8b8a5bc7ea365ea07f11d3b12e95872a9633684752495cc431636caf1b273a35321044af31c974d8575d38711f56c6'
	},
	SHA384TestCase{
		name:    'test case 30'
		message: 'd3b07f0fd5d4cd3188aead8dc8338de42056e2e8487eca51ec37ef2daf27'
		digest:  'adcc2e954c91db3db2d71d0dee1f030e723bee1a23816fe003ac5dc862a0872ef51ff386c18be6ebcaa493f32d1195b9'
	},
	SHA384TestCase{
		name:    'test case 31'
		message: '695b9efe1809abd5d44eae957ddf9c2cd3c75fae2f522855712a07c639c0b9'
		digest:  '3bb95d164d94595a1187f77fc26c280ffbb08e74ec7947aa3e5b38bec7c6f8115c4d880788c2402dbb3e5b94afd130ee'
	},
	SHA384TestCase{
		name:    'test case 32'
		message: 'be01e520e69f04174ccf95455b1c81445298264d9adc4958574a52843d95b8ba'
		digest:  'c5cf54b8e3105b1c7bf7a43754d915b0947f28b6dc94a019182929b5c848e11441c9e4e90c7449f4c3cd12954f0f5d99'
	},
	SHA384TestCase{
		name:    'test case 33'
		message: '98ef7301f957d73d4e821d5873e8a9b5970fbd219d5cf74ec2291b8381181391b4'
		digest:  'b2564bbb159c3aeadbae0e4a4437f7c5111020e9ad0f4eb508147a961ac22a01e1a26df046b14ee5e8a49d9ed22b8cd1'
	},
	SHA384TestCase{
		name:    'test case 34'
		message: '873ba7f8b71517ec50297b21cf94cdb7a58abbb8829206f0d3f328ff8a6939ac1d1d'
		digest:  '7405fdd557d2b5d4f65e9e85f508d3791495f1820d37cabfc8dbb74d7b41df8613d995c612d378dd88337e00951d0280'
	},
	SHA384TestCase{
		name:    'test case 35'
		message: 'e3bd4bc3a60cddd26c20aa86364bd44f4a07f3302825ad0ac127881de4eafbccf988cb'
		digest:  '199d5423a0e26438f4cea0081a89e0b6c84ca93f7c3120c8104b51c6edc04e0f6a203bb77d59973a7411a0efbe93a09d'
	},
	SHA384TestCase{
		name:    'test case 36'
		message: '8716e4b86deff9da2a8ed55baa43582a7586ec9cd38ac3a933156158cd8e5b7887585e91'
		digest:  '0d2306d9c0a8ce57bc7869b439376c07ce352a41d86ab6cf4a5654cccd5c724fe1b62b2c1101c986222f5264ab3fdd66'
	},
	SHA384TestCase{
		name:    'test case 37'
		message: 'f8a503aaa25ef2cea25e31930c3a90db468cd3a862f4a93aab5de2777e82dc905cb03ee23c'
		digest:  '773ee958fe93dfd1b73af24d27ddce33144a9249d5a671682a56df30d0bbf92b9327130022075185d396de752959304f'
	},
	SHA384TestCase{
		name:    'test case 38'
		message: '669025175ea917cdd7a71ff4ec0c45bf1246d2a6f031c00b71de701e17939bfe92128b21911e'
		digest:  '9ff6be3f02c7c5d0206f4b944c0843cb68bea8f9b7c8cc0b729503db5005c7cd5cb14e3457d8f5eabf733fca9084f16b'
	},
	SHA384TestCase{
		name:    'test case 39'
		message: 'b35fb2262edfa14938a0fba03eb2a25d377974b11f556491a781d0ba2b3c0ff3e42749925fef8b'
		digest:  '835b05a4bf00c2594c3c8c13da6c273a0d9efdea0da72b71b19d326bf5ce968c2e577a7d99fc0f985afd23b46423129d'
	},
	SHA384TestCase{
		name:    'test case 40'
		message: '9d86b45df8d7dae0cf6b0bc208666ee1163a39e6116d6d240c9dc1c3a3c1db1dd3b1c6680fe9a196'
		digest:  'a84c469c24696f81d7df4ee8cd76aa584f8c9960eaa9908d3e3ebc5eea7d0b50afdded39deb94fd59323a21a6539e93f'
	},
	SHA384TestCase{
		name:    'test case 41'
		message: '414f5619f6dfd45853bbabd224cc305d77350ad253358910a74f3a4381a9b86680b3c4068c089849c4'
		digest:  '848d481e3bbf5dd726f625cf6a444d995b36262c9f80d583b77accf1707e3f49bb3dc480a560694d769aa1ce65d69428'
	},
	SHA384TestCase{
		name:    'test case 42'
		message: 'e2658324821ae7b0faa0cdd63ee9efb9fcbe82092d04696feb3da92c82521dfdc98f6b41b3ef365d219a'
		digest:  '3ea5d0799f1a4dcab9149a40ab74bec9c8d76d8e392c1e63e080ddec2ec535f80be9f00927be281ec97ac0c882bb0bbf'
	},
	SHA384TestCase{
		name:    'test case 43'
		message: '7e80271bb5f2cc7ddae4158658e4e8d06e04a39385da0ecac1cb8e91d68a9bd21ddb7320e79d10e3110758'
		digest:  'fa00bc0359a642dcb3559656094eb2fd4f63bc57f0d34abff26df5c54cc63dbeb4eac75905296e7fb69f871e134083f6'
	},
	SHA384TestCase{
		name:    'test case 44'
		message: '43d2828e86f7856b78c66cfa3d602387c290975afd021a8b76af0918069cac35dec45de3cc52edc4ba14432e'
		digest:  '6c9e367e066032ce47ba2575565932002cc786f533c5551656abfe7391e7dcb5f9d9e047adace23d32f8acedfd0cafc5'
	},
	SHA384TestCase{
		name:    'test case 45'
		message: '3f49bb645cced7530b8b82e6cf07fbf670f7ef0ba0583d16debafc639bdfbfc99b8417249f7f5a05410aa3a71f'
		digest:  '2b301a14647a67429cc3e7da02c4093a739640f7b47a305251d2855e75e09e60e262b279a073077d1fb6d0f04788f2b8'
	},
	SHA384TestCase{
		name:    'test case 46'
		message: '31aac06a59b74bf478617c1637fa6c5593df168b8d58b1e923bf3e3d80e55d7170b16454160ab29ee1f7412ebc05'
		digest:  'ddd245c9b29ceac60506fb6bd6e8037889cb73d6ecc669fd129060a8a8f58971ac572d3ec9b44404f81381d0fd35a649'
	},
	SHA384TestCase{
		name:    'test case 47'
		message: 'c10b2852054d8034e07906c7fce3ce99402321a648bb881f13fb276afc224c6aecc64800cd767ed2429db94b95a9c3'
		digest:  'a44640fb4ce6dfd4a10290a0aecdb453054a9b54f2583e97bb7dc2b005e5fa2b4fda17b1f75902f51c18c0caad35833c'
	},
	SHA384TestCase{
		name:    'test case 48'
		message: 'b1eeef324b499f19eba322215fe3ce19c9f000b698d2b2dab7145015046cc86d049ee15ad59dcd1564f30112e06444cb'
		digest:  '38742d18bfa6e918b888d68d1034e61f65dec0759172c2dbf08cf1e132b217eaf4ec29e15db7f4b07e08a70cc5662012'
	},
	SHA384TestCase{
		name:    'test case 49'
		message: '790dbba09965c9774dd60a32e010c50d6d518968a220141dc33e7410f2da6c08ad0419bd9864d5327d2c5c44914b2e83f9'
		digest:  '9174958bc8f4ed4731eced999bea2f63032f52bc8c46bcd903232f3fbc5046f0d6c203d43a078b822fc05101404f2635'
	},
	SHA384TestCase{
		name:    'test case 50'
		message: 'f7b577f1396b23c27eb637e53d3d92460270b001cc612fd3b4d68bcdd09c2d50571ea4350636324cc2428a087e7bd8785f82'
		digest:  '80afe111e44ad9aff9e39c4cf9e6b4c520072b4550e62b1740160a04f8d530612dc098917a556b44977d0e73df518bee'
	},
	SHA384TestCase{
		name:    'test case 51'
		message: '7370d9b453936955b9c9d336f4b283237986232de007bf412fb426ff5b4093c80c428c19a12e0b187484dc6d5f4746537fb1ed'
		digest:  '6cd29159820d34e5706dd867e6363758d312660d4daca8d2abf677f234746e97a0a6224eb054066a0b74e18c70965368'
	},
	SHA384TestCase{
		name:    'test case 52'
		message: 'e8620170f0f39328bdf8888148cfd17730f314ea68d8fea02d16d98a3cca61484139d3ee92b748091dc841dda08483f1184025ce'
		digest:  '29c408a6a5045f397b56dfb5292c7c16028c63f068e699b86a891ff8501208ec9398dbaf463c00f39af7b2cbe45bac15'
	},
	SHA384TestCase{
		name:    'test case 53'
		message: '75d4216bad77943bfe82be216157843b0da0fd16eeee847153a00b43e707b2ffe2c898168081f0bdb3af58f214cf67b920c385aca1'
		digest:  '0170357385a20865a8d30c2df39406903ff88c7f70fa1a7a5aaa86711d64046c432a1b139668ae5abed637d1dc4107b7'
	},
	SHA384TestCase{
		name:    'test case 54'
		message: '2fa90c2210e3096caed122b74eb9559977120e5d9a97eeb3f99bcba6c19cf8cf791ac6c8a0a94ae49246611dace7f24eb05673a36b3e'
		digest:  '6c2ced3fae94dbd92f4170b63f1ff6fcd8194f60937b22b4f3c95fc9e104b77148f9bc6c16a890de86d9ef1554c96fa0'
	},
	SHA384TestCase{
		name:    'test case 55'
		message: 'a8de55170c6dc0d80de32f508bf49b7046aeea4b975a511b5ea3dc853bfa4b1e0138202d6785f6b3017914a86f824288d586dc0e8bc924'
		digest:  '2bc3b10c148200f7919b57afe1d7db773ffd235e04fec6897dd94f13ad9c437ef50900a40937f82a39daf2aa2b3dfd68'
	},
	SHA384TestCase{
		name:    'test case 56'
		message: 'accd9d05fb7ef3043470836137554af117440b3ccca7a280285494f90dfaea60dcbf40b230271932cd3875b1d3dca60d38865ff874180efa'
		digest:  'b9e02df93e9254180d6a15288d77088b5a5ce517644109b4e2532be315f08dee43491608a1127dcdf69397406e23d231'
	},
	SHA384TestCase{
		name:    'test case 57'
		message: '32b835c180cc4006c11a61c65b03c099510e1d4f0a94b63d54bd6bd5a8ab207ab0f4639206564edc3fa6af03280a67744f68106dc51ee35723'
		digest:  'df97a1c5dda6f9dde749f213e429db84f0dcd481d43bf58e6142968d629ecf05b262830a7dac87f67f4383975f3e821d'
	},
	SHA384TestCase{
		name:    'test case 58'
		message: '9409f9efadbf190b253367629f8f368c9d5ac262e94ab86f3559f9a1fe1a9b44b64e313121b34d43001c430bedc62fc586ea398acd8f17c7cfa2'
		digest:  'e1a69388ee6b6d234108ec29402cd0afd74957d990c7bdb544cf11e8eb2ccd170b6b5a74431be70364d7a31b926ff53c'
	},
	SHA384TestCase{
		name:    'test case 59'
		message: '289586baf8daced50db14c936529a0a6438eb5da8d3d469172b6a06f4ff3a956d4f9219563ac285cb8e70074cfcc152c02593a97733c36f4a9e97f'
		digest:  '509e996c1e11611c243021b8b78f2ad90c5a9263bbf35910db7c8ec102aa7c518066fff8ce88562fec2cd6dfe04056ae'
	},
	SHA384TestCase{
		name:    'test case 60'
		message: '156530cd6ed3baf1fd7232c7ff204f3c7d4d106016afa3bdff3786e84843ec556115626fdc84b2e874f1074e4f7d53e08079ee9fd01f80a8be7f20c0'
		digest:  '7b8a598029ca0ed475a72c0644ac81c63d72fd51305dada07b0ab4a29e47422f59e12643179269ca3d7d10446b372b2c'
	},
	SHA384TestCase{
		name:    'test case 61'
		message: '30655a6b5a5965db992e7248d24141055e988d726abb8e729dc5c21ffcbaedbc0b1b5fea35b8751f6ec6625517312fff2234014176269b60959723787c'
		digest:  'cfaf443e95deeb3cc1910771a2c0692a54b18b3633dc5414e71ae08877f0804818f67f7196c52e26b762dd12bb7a86ca'
	},
	SHA384TestCase{
		name:    'test case 62'
		message: '345c3c022e20144e135604078762ef5c8a8f038cf1b1d6a91709b59dd068396a9e971ab628f74886e765384a23607c1a1e6e973f8fbb0ff55104c46f5db3'
		digest:  'bfb1d5ee3a0b629058ecc521c706c2f9241c48cda3dcfdba660a2601d832a7a872a2bb840f3b98d21c37e28f9041a5b2'
	},
	SHA384TestCase{
		name:    'test case 63'
		message: '0b94a0f43a92408963a59ded01a9338283a6ff1bfbacd9051a0104445c7f041e8037afde3b5a87d22d5a4796144cbc944091d6cc47b5ffd1f997ab1496ca31'
		digest:  '07a045c9590e9901d0598e604c4649554a823de996fa438cc81a634344eeb98e5f3c0c234ba30e2285a4d7ab568f2610'
	},
	SHA384TestCase{
		name:    'test case 64'
		message: '93035d3a13ae1b06dd033e764aca0124961da79c366c6c756bc4bcc11850a3a8d120854f34290fff7c8d6d83531dbdd1e81cc4ed4246e00bd4113ef451334daa'
		digest:  '8d46cc84b6c2deb206aa5c861798798751a26ee74b1daf3a557c41aebd65adc027559f7cd92b255b374c83bd55568b45'
	},
	SHA384TestCase{
		name:    'test case 65'
		message: 'bfb94dfbe0d9a509b78d164a722050054dad91c9a8e260545d037eb450321aac48ed4459fdd8a41572bd6c9c84d18b6ec339247482cc3ee52a1bbd6bd4ae918216'
		digest:  '13af0be02986ea3176e8c65534ec9f32c23b53c93a73b15c26b9ecbd8a1181ae184a372e9f5e0596cd6606849aeae8e0'
	},
	SHA384TestCase{
		name:    'test case 66'
		message: '1c8924a16fa7c602aff5ee961798bd44fe53798bf44c3d6b0d13ef837de07377651c1e94ed236eb79349f86ac31ba151a7e711c5407e65beb63824f6ec39754b58f3'
		digest:  '5be6482851ddafde582f2804071a702ae39bacb688741b7c37bbae99821ce4d3f47d5b097fd8eefa0ef9248a34f5d3ce'
	},
	SHA384TestCase{
		name:    'test case 67'
		message: '184215145da49db417e8bdd573d6282de073e674c3dea86b6c78591d4947f5655a9d9eb0e5f4ed046b1d8642da9aefa80448a299504160a1b000c9b4d3c62ab69b3d96'
		digest:  '8995cd7fc0956e124075440686beece17a6256b282e7988a0c998f790e3995c974383179893477bcc32d1f114129b496'
	},
	SHA384TestCase{
		name:    'test case 68'
		message: 'ca7a63adf41f4da33142910c967706b5c8a093350eb3e6d3aabe69a46a2872f47a39bbe77cdc1160daa450225b0e8e36f506978ce3ac9ae5f75721ef30da46b28f07242c'
		digest:  'b89cc12b11e3afa58908580c47b25407abbf584f8e8d4b5631e9f450464c7e53cfd7e9f9d3cf35e587a6f02957ce4c28'
	},
	SHA384TestCase{
		name:    'test case 69'
		message: '1da41a0af202b079521deb6109e312c2ade48544d2b498c07e91a102dd4650ce354f3f201b3ecab8e85e21d667959b43d08f4e90fa18dca2ccca8f6ff5e9a902dc8bf5c5da'
		digest:  '5c297e20c307aab7f325939fd4e2883b034fd547f1dd17fb6b97ade8b148e06ebbf3ff60cbf469e4933d5f48f0166cb7'
	},
	SHA384TestCase{
		name:    'test case 70'
		message: 'dece42c8849be40c78b8de6da96c2a8d7e940545b9f3f39aa1ca03ec60a85471aa84d8e29f095874f331b90a4c157da9eb048d2c8fd235399672707366c766f10bb833f02183'
		digest:  'bb509e33e9ffcc4c01233146226ee9364cdac5658132460a76edf617a035b197c86434ee889438581458102618769382'
	},
	SHA384TestCase{
		name:    'test case 71'
		message: '952008ebdedd480449bb96a025576c5f617bbb8307958a010767e0d736ffe5a196ea4467d8a5d3ba1f5476ff07b6410ae659dcef520a2c14e3902f8b399a289f41f5fdadb502dd'
		digest:  '9b63d9145bc714a8253dcdb8341b2f5714eb58b9d4b22ce45aae07f51297a3dc9c5b691a8a3cd438dc5bd18be400af21'
	},
	SHA384TestCase{
		name:    'test case 72'
		message: '100132c315bfc9c4fb93023f5d3500d7208a68acb4d2c63096232c361a161c4c67c0a74bc3e4d72c11664b1d970321d405401924b3a0f6ce2b1a2899e7caa9a55ce725fc37f55d6a'
		digest:  'b6ca04467ed3e623dba36f2e0248cefbe134cf555fdc14731175eaaf08e244ab0b15fca2f173a0ec98feaf359fb84a11'
	},
	SHA384TestCase{
		name:    'test case 73'
		message: '99cba4019f5478789e674e08fe5d6ceadd698b0757ca39c605457c22c3d3b8ffb797d2be8f12960f099a5606b908d47207b2636a779948282de3661bb08b1b37ee576590800a492730'
		digest:  'e5378c7c251ae96f0359a30b3134fd77d61d0db68c42a1a2aac293195a596df42f677e6cb98abec90d6722baac63fc86'
	},
	SHA384TestCase{
		name:    'test case 74'
		message: 'bb327a0bcb2574df47080e8c0d8a45ee1c0424ae0414dc0a9b8717d9f27d8ac987c7c9ecbc946073884d1fb96dbdb583aa758186b16fa429dbf15b8d5bb48cca71469e7ce0ad8e7fa14d'
		digest:  '0f75e65ff8494ae28d9a0a2e65959653275fc34b2fa27b9e10faafff07c45addef3b8f25953d5a2e54e31ebe6d429d26'
	},
	SHA384TestCase{
		name:    'test case 75'
		message: '7fd9eeb5ff368040d299fd17a943b21d65deb2eccf6128d18a33eb174693538935374c32c333a867821dba08636f20022c2ce01826c7b7e41640ad186f90ed0ac647d47086744867e5c54b'
		digest:  '007251a2a577add048b1edc79d96c7df8fd5b5fa0d7264f122e4cb54c50bc316a8bc5f4f9dfd4469e29e9b030f563a6d'
	},
	SHA384TestCase{
		name:    'test case 76'
		message: '7ca9e369e82186984d5fc729e111a7e5d8ec19c5d74e13b5ab22e4993b05c88ebba6ba72237389a6e0722e12c96c5d6a54515ab00ad80efb38665a76e831abab0fa5cf020807078441585de5'
		digest:  '3ee8c4184de9ceaecd0d3aea16271835f3d45c873358c93a515539c38e819414ea63b08d0a109346793d5e0f703125eb'
	},
	SHA384TestCase{
		name:    'test case 77'
		message: '5b4d945d55dea22e37821ec396476a4bfb617d2f392ad93afe67bcfda9cd9b725bc4ccdf516a83fd71dbff5a22b005fc61c58e471240bd2193ce13539730e63232f70f80308be48dab7266a1dd'
		digest:  'df82d242e4cdc2eb40bf3db6a56e1aa0a66e553f1914bedc65c8cc6ad9564b6e85df59f4c443cbe4e0aee05986f7d690'
	},
	SHA384TestCase{
		name:    'test case 78'
		message: 'e865f4a42bbbd0b73fe275b8ab90d3a9fb74ec5070192d38f60efef9564498b9adb716f31d50cf77c20ae4b2e85515307bb8d95fbeb9ad964001ac550dbc60cf213fd8a522edfaf54e5b1b93b2b2'
		digest:  '091fa9ae2184e2268ef9ef23c7c809efad244536e00aa9e8b3a6c228d90e31da051b40f268a13bd6f62e69c91ae8cd2d'
	},
	SHA384TestCase{
		name:    'test case 79'
		message: '1d408c7b68e168f41bb46f9b2e9c8b04f968e4080252546814cc1cb2917dd5690886a9600a09c2673aec0329a4daf655508b06fc1646ef3bb3a472191d964db214a96a96fa89576ce4c4f6dbf1d176'
		digest:  '7e23472c03431925f3b4559d886e8d5d837b3d39b8efe1b7a91e61a13810c4dbc2439634d7c6ababfc66e9b18e6541db'
	},
	SHA384TestCase{
		name:    'test case 80'
		message: '54ae030a4e27a05c1ea4a12e69c67544af9b4044cf157dc8cebbe8b2d49f9bc0779077603c90c5c55b891d3ac33b87b65e79e1b19695813718191b3bd8b7e42d5583f7cf1e60f84495b8f869f3719969'
		digest:  'cb65f823585773cb8802b6339182f13752a82864c898b445be5a11a969657ac2dc4a3bbeb87ac0abb232a2b124171096'
	},
	SHA384TestCase{
		name:    'test case 81'
		message: 'f73cd386f73d0c6ade05771b33117117c602e52693f05b47e90032eacc39295f9793258fe6512eeab291baa0be222e143295a28e8697e42fa27ec02b44217f32a1edae2f4f35213562ca37b6d6cc5ef72d'
		digest:  'f665c4d17a83d65a7ff16bfce279b58558250d76af68b8eb943753e411a57ceb31c1a131e54bcb7672584416e3d5719e'
	},
	SHA384TestCase{
		name:    'test case 82'
		message: '1d259612e6867e7d788c71d03c5136864ad6d84f24eaf913a34e69333116f812395288d4dcee6665e6d7dabd005ffc6327e3ca305cab78569d1107a115e619fc90110436317925066726774d1da3639c31a6'
		digest:  '5dcf512e2b93d6ecdf7c3304534554ea79d22392e59bbe90df21e978c9fa3b34ff82e6dcfe8fe2236aa4af4e662e2a9d'
	},
	SHA384TestCase{
		name:    'test case 83'
		message: 'da8734414c45fc1d5a75a3cbacadb1bfb523d6fc391f882d0db0eef21f9ffd78b6a1e14cfad09e71b65cf7b05d7e8f2f4bae4e454e16068d65465639c729cfa92738563d37edc9676b7be604ffbc68ec3b6b72'
		digest:  '8b328a31adf67dc7aeb864a359628410d5814a2f0cc683303f61432ce32177e1f538feead7e5000343916c7042f8b3cd'
	},
	SHA384TestCase{
		name:    'test case 84'
		message: 'b228c75903d80fbc6d1cf629ff1d14a92ec4bf0e121fd97bd306ed265efe7a5d5c5d8fc764af98ed6f5978f88d7cd8bcd71cbef6a58261d201de3cb15b3161287e6a104cc2cf882d839f1da0d3f68b426cf08ab9'
		digest:  'fc92ba4eac9a1bf120a7b6c2cc30335b9615b1a98e55d14854ff872966e71040737401c6bc08db5842ceace14cb7e7ea'
	},
	SHA384TestCase{
		name:    'test case 85'
		message: 'c90d473a6fd30be9a98bf442a9ad65a697d4629c33cd517dbbed02710fa8ee991360bc8e557b0a0bf0b869e6b0c3a9457607580edec3859f2060c9c0340289d53a5d755918ca54876599045a86a9bcb8163795ea8c'
		digest:  '807582b2520e990cfb74367343268b9148b2519b9e7cd9182edb3db9ae7afebedfe8ca118130e2ef9d31af9081da8222'
	},
	SHA384TestCase{
		name:    'test case 86'
		message: '6df8c5c28d1728975a0b766cd7de63bbe7f48c3db3e6fd5a4b8df6e3905cef0351f3d973b4f2a7eed80b0de5b85c877353fb9e930ad2679149ad4cbe69910e68d5500b096c5abdbf27d684fcfcf1a57f02769283d5a0'
		digest:  '7bda57d21a4434aada6758e282e612a4c0f41b242f9c790804d5bee25b81a821dc6f2a0ba56f1b3704802c9a6e153d85'
	},
	SHA384TestCase{
		name:    'test case 87'
		message: '2cfc76f88cb6fb90927b69526ad5f03d6bd335f4f75b52b6a3c21e8f989ab0d03acb1ebe07e68a87c1b5607acf17d976e10ac4a3d30a8561d49a5e7ec720edace9f5f632b4bd63e104f4894a79caad2e1c31c736453485'
		digest:  'e16670ea837c259e418d3c0e1eaad4948c3457e15b1573056e24da25bff5c66b7e95d24c6bc1b8d6c2b812f64adc9553'
	},
	SHA384TestCase{
		name:    'test case 88'
		message: '3f05108c2f33d39b3aa9e73efbad4b011b4e9e9fba409b7611e7e03956b2f3e5e0aa86f68c4bfada5f9223a66d574b08f9dd797cdda8f3c32d8e01921711f4870dec676027ecc56fc2010b496e95cfbf071c820f21edf25b'
		digest:  'b272bab680f3ab27de72d94df384323f8555f1d17facd2588ac8648def2451f82f9b99c05ead8316fd181a2cfb97483a'
	},
	SHA384TestCase{
		name:    'test case 89'
		message: '1ffbe1aff0a1e7fa3e68be31a74612a1519b59397e7007ef61fc015f316d55b57be528cebcc2f09a2f22e3c5e4a6ae9612776b17ae87cd763c1a9eabe6846c5bcb347ffc99f10e3b5e64b29a9bd71a5e9b3c01a802715de2a9'
		digest:  'f08bda9d6762607519d53fecb0bffbfd3ff2924854833a759d631e910c42ca86741fc2e290af42e94b94898609b91390'
	},
	SHA384TestCase{
		name:    'test case 90'
		message: 'f755d6b5642378f2847893901d9aa91c54a4b7abb97c5c7184063e8f1e97aa2de4ad7ac927dd3cce770c906921e2d298f67cf9844e61bf104db803b265b86b821c5f4d901067d07b38764e3f6c95fd4f28e3cfe48d8a9694a8f3'
		digest:  'f85e98ea054455242280854e97c4ed399b85ee7bc5c5fc3d62910a76f3a9600c3d904c832b70b58d7d998db8dc978135'
	},
	SHA384TestCase{
		name:    'test case 91'
		message: '773577f3a642c4f13b1cb1f4103e9f6b2da86268a52f449cbb174c8349e3c0dc636ce85c373115a337eee26f7b70ba1060a79a1c76fd186399e6a5255db80f83b0be4a34ba876f7908840553ead380f3195507729d067ac2ee8eb4'
		digest:  'cc27869cd7e63695d19082446b068b77dde4e8604f8c0e9ce20a1b71aa9eff1460f32d5a54476275bdee8e7621491f46'
	},
	SHA384TestCase{
		name:    'test case 92'
		message: '651589927e17e1aef780690f3100a377f0179b18b31fd5b4418c84038573fc559b496a782beec3dcf6e9faf5aef676e10bbec34b1be5888fda49b91e02890d2524c5b369f8a54175f29dedf8156fff690cf186ec77104a798315033b'
		digest:  'da846042fb908eee5f5defd1055ff3e57103708278d379a8681f58bedc6ef89670b9f957c4e0edcaa42dfd8cd49df6ea'
	},
	SHA384TestCase{
		name:    'test case 93'
		message: '678652600eee42580f73623412e9c011cc02dec4d4cc1b79b27b6f9939695bf2185b2012ab0630f317d2e2de95dd69890e430783e99d7ed121c7c8da9ae70780b5aabf9022d1435cf5ed6da6fc6692c050c2b5f22b24fb1cf9135f9cb2'
		digest:  '8a6ae41c9bccc16eac4860bd5fa91205a86fbfd09692578f7f36b3c135d96f9e9001c192dbeda975f7375bd43a23ba68'
	},
	SHA384TestCase{
		name:    'test case 94'
		message: '416d3fb7b401fa5e78cd96d479d8860df147eef03adf13fce1c61131fb89cc2ebc63289745bd7db9bef14571a55318496572dbe52b9b349ef59f406cecd68909f364325380bb75f3aa62503c84f47a55aa6b9c9b199ebe414409ff3964cd'
		digest:  'c5f20542e0c0ac1eb433de6229fe5baccfd4502e2c2275439385efda6374a1d0fc50cd9bba4233d470ad91a3356ea315'
	},
	SHA384TestCase{
		name:    'test case 95'
		message: '6f09e876c0b83c9934ffb777f006338c5142a31375e9b21cfea9a7de12998c4ea6708ff1fdf5a8ee6bb67c675ffd8209a10064e2d758a8734eb48f07f7cf3d43b09f1bfdc5d07a52b77079f23cec28bf863bed97c859276df7f7129fce71eb'
		digest:  'b3c968f3025f87dbd5cd3d364bf673e62827c35889532431becd87cfbe2cc75b7ef45696d19cd3452d0e7c2b69d09544'
	},
	SHA384TestCase{
		name:    'test case 96'
		message: '0dc2b226b3431c69a76addc018fcbda22bd72c8ff01ed6549596798bd950f361c489a09c95cee2dcfd6401208ae6368d6630026b417cc4718ccb8b42e8872937de66895fd09142c42f066bf0ef3ab2b03803a8185fb65fc7148c376ddd4bf58a'
		digest:  'aa645a4f8f602411260ace24d381f3f5dff0000c246343eb528e3dd027cd743815737906ac5c74ea83c2755e56b99509'
	},
	SHA384TestCase{
		name:    'test case 97'
		message: '8dc71c84c8772753c86ab6afd80e8d1df9b0d7e8d69ebe67fa883a82412c26738c3399cab95573b4d3c4367c85c81852d5a6564c0fc7caaafe16c05e62aa06cc9fa542ceb35c88fb6ab82c29d5dcd530f807d3f1c3bcb3974421101d1aa6ac112d'
		digest:  '12239813097124e6248e7dbec985a6a25f622b1d07295cfcfbaff33b847df7fd94265e439fa535f3becbdb576922ac41'
	},
	SHA384TestCase{
		name:    'test case 98'
		message: '3df3edd9fc93be9960b5a632e2847b30b10187c8f83de5b45fcb2e3ed475569a8b2ed0784348f9dacce7b323c6b65071abd8b32d1022b1e12787bd4989d3c5ac329d576ccd7608dd336716532e9b4c7f825826fb2e343623ef85c6270619bf5e3b27'
		digest:  'f36590f5211a9cf84eeb0a3b2e5dc1164e813191cda7cb883f3f4a074605ce6780cf2f1a105658706fbd2829db8a2a58'
	},
	SHA384TestCase{
		name:    'test case 99'
		message: 'ced0ec6500cb891e6433d104ba5b1c1ebca397f3a5eeeaa0f0561729621ea50d4ae7ff1d0827178dccd84e4ca06d9891a90adbb7a9f4994ac947cf6296e71d2f49b826d64b123a7bf86f339fa4679caddbdf19cfed7d0206aa5f527a6b0cc00f52aa2b'
		digest:  'c2c2d7d65d0b9108648e3233d15fc4e4cb62ed8fee9cdd18ab44b8486e2100fbe45ddcf74f46c15eb77fb1c893c12202'
	},
	SHA384TestCase{
		name:    'test case 100'
		message: 'afa4a2c4fbaffe838dd149c78ea7851ea9396304b41806a093a90aae59c0c5bdb170cc9a7d22b90cbce52cc1b105108942df20c29ef3a913223b915e7ebc98ef135adefaa0f0a6441ea05920e868ce9d1ff6c8fe4dbec06a4849e5e55ad0627f9e09dfcb'
		digest:  'cf6ef91d8567414f5c7f0b1f4ad09a976afc7c8327a382fca90f5a136b19be33100a664390a377f8d8a3015fb882125b'
	},
	SHA384TestCase{
		name:    'test case 101'
		message: '00f65a485bfd381113d6e79bf9e0d5e518c891988c073ba198ac3a20f25c2c81619723e88a3c0ed3075075fbbafb6a7b61d3bc336a5e6d6f08d166c4861e6a3bdc2e49b2806b567e7e821a55cb674a6cd699f7dc61a7054a8ff3dec73eb667f59644346be2'
		digest:  '809c6b5d41da7cd10df90b02b193ac7d40cf2e46c139e9dbd208a988da2b25002cdbad1db2ecc1322da20b7d054e5fe6'
	},
	SHA384TestCase{
		name:    'test case 102'
		message: 'b9ce382e1e82a873cc444248a3008c2cf64d18759057abe8f91c9d87f5dc83aa4eca0c51d30829b9a1d2712da1fac31f52942d77c9f20c2bf6d3751028d7d4f0d336d3dc92b27ec368caa4444b3180c1e37e98b58f25e647a9a6361f0b04cf78d17955766168'
		digest:  '18cd10b3ea907b3770e8eb91c974666e2da2525afe7020b872b3ec6689e5e1cd0059dd4fd49ce44d75dc4c8430c322d6'
	},
	SHA384TestCase{
		name:    'test case 103'
		message: '6778d82f3a98eecdfac55ddeebc52476a070094fbd65831801fdd60f837d80d23b90d472c5f4e5ca6273a50f40154ea8fb94013f6310ad18800433a1d379c84bdf799a99e8c7b676fbcd29cc2ed66552297de7a6e565179bb42b70d48299e0925a1d72ca2c792a'
		digest:  '71f08d9333df5cb885fd23d6cbb1db84f9b55908d069df50fa4795cc713a18439bcab8daca078356f5c75a619f2f8782'
	},
	SHA384TestCase{
		name:    'test case 104'
		message: 'ba3a54a77d7c2b8ccec6d53136cd48827c87acdd1cd86ad1f56e862642ea2e1dcb4093f85d60f7bd77160738462e6c3fd3dd9d3a7c5cf7e2a1d60f489f84471902179f21f656ce0fff089278ea14441e04e7af71891622565f44c428044728fcc686212a32a5d809'
		digest:  '3cc154f0542d8e3cacf9d79f231416816178a7ef2275fb257a48a2f763ffa2e15a33c27b970a416a057925aa0412d268'
	},
	SHA384TestCase{
		name:    'test case 105'
		message: '7eec4f4f491b4eeaeb1cdbdb95e9511c2872372bf64a1f61cda1cd8032729c8beafd1edabf78036d80023c814ad8606106cb4e7f33f214c3e69c0f230e885474fd594f7f2444aa581e0c70ebf13073d89063eb81a43c5f608b2fc99fa1bcf5e2bfe62a6802e70c52ce'
		digest:  '2f8c5682a07438043e55f0b7759fe7eea5d9bdfc8b0f89800ebcf777bc05a941ea7f3cac45d4659de0f505d814590b6b'
	},
	SHA384TestCase{
		name:    'test case 106'
		message: 'f3715b9e3ddd7862e15ee87aa23f1aaa0580591e55cff3fee9b49b42aa0c0cc8cfb8efa3eb96ffb72ab06b83d7b47b3d22a5772421cfc51214005150edf532af10138ad45758add459908601eccc3703e810002a2e4c6202e98d84281475d55d3de9f3d98809cce1f665'
		digest:  '04e7d55b0eb4bc3d3a21cfd2941dbb4dc44706588967186b40da54902aeea97b262c97f75e37ebe3cd60a804e7b9feca'
	},
	SHA384TestCase{
		name:    'test case 107'
		message: 'dfd7d792e162bf7a889109550a0fc4c415232af0c0d72dcbc2595299e1a1c2aeae549f7970e994c15e0ab02f113d740d38c32a4d8ec079cd099d37d954ab7ef2800902cdf7c7a19fb14b3c98aaf4c6ad93fe9a9bc7a61229828e55ad4d6270d1bdbca9975d450f9be91e56'
		digest:  '08e5ef57d0c2aa23edfc75cfae39e6bc1a43b5db08b2e27bc9823114edf760367db9cf3cd9c3779755f6d39e219b7079'
	},
	SHA384TestCase{
		name:    'test case 108'
		message: 'ffbc7c47f52e69f5c667f4ed578b46ff4592048f789081f3fb39321d0aa4627a6d4f261905649410a53a301c231fa787ae55c04f615a8f84196cecf2844d23007b44edd892649fc8ed10a2e855bf23fe8afd0b9edbb33296f5a7cf89f94634d9d1a2b8cac3b7f4e546f2329b'
		digest:  'be10c7baf94608408a0accfbc8ce95e159d08d8ca75dd6c273f935947a7ec3463e10a58d3ceaa0b2198b0887a3a24a29'
	},
	SHA384TestCase{
		name:    'test case 109'
		message: 'a39f202d866e8e96765fbb53b6772537dec043322f4a7475247036d7495c987850cef2a46218d3fab36e3bcd595c0aca5e98b9db14fa484ca8c9772dfa3839f7ac3066727a50b0d5c933d82f82f1220720e8063f08bc283f199c8a4f85c70043df4fe55e751d0d71df36fa43d8'
		digest:  '3b2664ccb555a1b1f3ec996860146ea75ef7f3bd62028a19c26f63339399f4275a07f3c064d34766ebe8e4dd532f6629'
	},
	SHA384TestCase{
		name:    'test case 110'
		message: 'b2c8261853e2218dfa135cb5387810352b8962e94e9fdc8695b41e7dba6ad122d14fdd0d2360dcc039ccce8b37fa0ead6ccc85bc26261d47cbaa78b925c6e380fef1856fed31dc616fe16b2039b1ac85cdee4ce04c0497998b41321868db08e35f358606585e0bb8c3da9a3be7a6'
		digest:  '45b286f49fd05c45c921b7bfdbe2cb024441c372e07394dcccae0de834cd541f13a79dbb3e5078896e88438542bd2f12'
	},
	SHA384TestCase{
		name:    'test case 111'
		message: 'a04f390a9cc2effad05db80d9076a8d4b6cc8bba97b27b423670b290b8e69c2b187230011c1481ac88d090f39154659494db5e410851c6e8b2b8a93717cae76037e0881978124fe7e1a0929d8891491f4e99646cc94062dc82411fa66130eda46560e75b98048236439465125e737b'
		digest:  'e7089d72945cef851e689b4409cfb63d135f0b5cdfb0dac6c3a292dd70371ab4b79da1997d7992906ac7213502662920'
	},
	SHA384TestCase{
		name:    'test case 112'
		message: 'f419494c3c6d0727b3395a483a2167182a7252f4fd099c2d4b71b053f94bb8b3adf3b51e8460cfec084ce9415c95798fbae4975c208c544645b54c44d2b97f2ecfce5c805be61f5ba1d35dcc07afdd51a87baa990506668cf710e18be9b0ebf943f366fa29c69f7a6616de72a3353b66'
		digest:  'aead8688c58c6ba4e9cadb4756b465dce0fb06f1cfaa478197f2ea89414e47e9572034adfed160703c79b82b3fd7ab78'
	},
	SHA384TestCase{
		name:    'test case 113'
		message: 'aaf7584d53006cbf2d2040e51b7feebd2bbf1e9f6d817cd8062a6a9680e7f10464eefeb50b07cb46b14b9b3fcb2caa3b9ab664490115d5919456613bf172b58c5388fd52646a5783535b88212717ef605314b70b8a085024d4ab1fcbe2be74609e4cbdec0730fabd3cd77151d647a3767b'
		digest:  'e6e79d8c61d0ea9fc70dd4dec1fa432849c3396e717b170badbd87a4c7974efc590ab8c1183a6232beff14534f004b02'
	},
	SHA384TestCase{
		name:    'test case 114'
		message: 'a467f77369730201f2812204fd63ad0d2757be580d937dfeb221a06b21ed3213531d936152a0c1f09f0ad5fed19fd11e80ad982c61203e86b2508279d91d99fa483e2e97a3d6a6ad2548a8da404dddb58344f4bdc1c9ea907088885e4f532d9c4c73cdfda43c3a9e4ce5a2809096593cfac1'
		digest:  '5a7508c2cc096bf65a4d4d337aea22008edb9a3bae869f94e09fb526a52c3368e9b28576fb950f078b7e43b5562120e6'
	},
	SHA384TestCase{
		name:    'test case 115'
		message: '01abc90e9180fc9bb8ea67a405073ed6848bf33048076566476c55836bcb19d3e55e9400c5cc657bc7a95f1d703c390f5a8687e7cd7fe9138ea3837bfcadad6258a3eb8d65121fa8319bfde532aec0e694961bddd2b673f284124be5781100f40381b6ff99db92ea9cc82a4372e53924dac398'
		digest:  '96b209d7cb2c2033b38350744767fa5c253e1bfdb99fe8418bff83804df02248140fe3b77b0bfd4a79b51f70405a434b'
	},
	SHA384TestCase{
		name:    'test case 116'
		message: 'b555d99056362bfc2bac2a1bbb71ba112d644e50b82b015e5a1ce3d9cd5e90b8b74b08d32119baa62abae251fc0015e400051ada4ecafce3681e5de727c20d47f5cadc663d46ac682022ca396a4b7ed1c413e0b72bd7eec4a0dfdc2a2185abb5d99afd50940528ca75ad89daeb9a1b61e15747f0'
		digest:  'abd39f79d72c6cd2e8e130f3603032fe3cef4177c3563930096df1f10b87e79cd4e2059cf1b9f8252184bb26f659a5da'
	},
	SHA384TestCase{
		name:    'test case 117'
		message: '14fb01ae9d6015ecb3e56d6ecdfa4bc0533186adf8457f5e4a5c57c687895f3db395d06ae7ffbd67ec41452009550dfc1878eec0df2eeab09e8665f7e59f9148a86b2bc695b36521a55b2302f2e869aac83f14d6feafc9e587322c3c44f052ea1c0578884f84f56307bc6dde31ba48118a0f62b6fd'
		digest:  'fc9b9a95a8ce1c157720cb63101a7594df24f4cc74baf735b0ccf6abb925478ad507cd048d30cde1c788806f43ed3a81'
	},
	SHA384TestCase{
		name:    'test case 118'
		message: '11ae0cbfee7bb3df90ce585f09b9cf8ff5bea69a68eeb6c22553f8ed118c9a61e7b752cc2c94f38766e63e1b891dfa05b23347b617d42fde3ec17eea6e76d3cb640bf8fa46586fb9dd5c4d9bfee04c4649571b781709f848ad7081afb6e2c746f071a551251050fd5df72ee65248ecdc24f2cbe74ed5'
		digest:  '3214b5feec925059149fa852e3ae285a6eb377df926504e2f824572a3aebd2050a20144e7bede7e7fe238ee83e69f72c'
	},
	SHA384TestCase{
		name:    'test case 119'
		message: 'a5c4a47a04f4714269d5d922ba4694060aa2df49193720c819fac93bb8787ec55a107ac9a6602f0045fd2cc8e66744bf863ced91eeabe60e7d2c1d80276ecf3bbe91f1757096cf589214f3569c2c48bd74be7f8befddb28395814780a47c180a58b0d0276a7e9873d682f473e27de7275c925ede23b6cc'
		digest:  '6bd9e1303579d815f58e8c6c9855850133251778a632f7b312c4b3163b29b5ef6cb9511a08a31a237d9a7604afbfa056'
	},
	SHA384TestCase{
		name:    'test case 120'
		message: '75264774af69ec7ee3125e205bd6d1cb8fdb22f7ea6dbe72d1f2c0f7e2205902796d75e379c79b11498615c21c9f52b8761a885eecc69d132b2b48c63bc074c3055ee5cc13f51d6c987e8188b030b837e8f754d40122b451f15b28cd2bdd576920e1de5806593a36d8e1e89b9ef3caefee5acd80b3e9c9d1'
		digest:  'ffa9e4e856d06227c1ccb959be558309cc10633173f4b66ceb382923b52b9150acfb08a7393500477a6ee4425a827e76'
	},
	SHA384TestCase{
		name:    'test case 121'
		message: '791a36d748695e62db5003a8ad367df1f051c1ac6a21d711823e8e069b546e3fa06ceeaae06de70a1de249e1dffd0d940edc6acac00c4c15504c02d4b0933658005423455f00023b01cdc5b681b6083379c24595518a47c654f5e1a10947df10c05a3d716b2a973faf98e1ee3b675816598bb8d4c2a3b06eb7'
		digest:  'f8d33369680524ed6c6a716d4c502de3eac891f340f40e82e37501be1a90fb61d26e5daafe92bc6ef5ec0ae431168842'
	},
	SHA384TestCase{
		name:    'test case 122'
		message: '74cd86bbed14d895301d8a54b2956b1c5cd1451eebab620b978d4ecef2cbdf7a14367381f5ee79281a773337740fb9f5853f4253c4b19f684341081d8f561b2ad773224151099588da90e04dddd565f67596c536d64c5b87e9480ad43601397507ad1b61ca0e349fb88f19feb48f770676fd562ee8259f50d0c9'
		digest:  '73ee8d29c30821dcdfa4441639f037fb6ba3a9ca596dc43428043785756608f6207d80b7f78e573174fb9dfd42f0b8cd'
	},
	SHA384TestCase{
		name:    'test case 123'
		message: '46612e1a4d016c41700a3b5ccb38323353bd8da5b9942c9c9212df40b4bee06be362a15dad62c8b2924d789168b2d325fe35bd5100e1e29f1ac0fa7a60a94c9eee5a70cccbc75ac214b1946a5679cb523b378d5c690751b7a7a3b80d413712feae7024ce71d6295a3d5d16515c3622a052eb862ebdab81ca7fe3a0'
		digest:  'cac13a3784225be03d526f9abc1eb50a762e72c0e01172a15d578801089e5c9f26e53cc00ff755909453e2964d7df838'
	},
	SHA384TestCase{
		name:    'test case 124'
		message: '1a857c1f105d068ceab0b1e12494890ec196362a48b0200a0d75d712b18fb14bec6bb5b68a33b7e0b4fdc5b77142c29c6d9151b9f884f59551f476e5256986a653d4a468f28141ed954721f2cd02054df0438738194545ed70234173ac4988b7d62812de4f2feada14f68e3b41bc9948d4139f4fb4da5939f26c0261'
		digest:  'b75d92b5cd3772846f7b68064a3567ae43e5010099f2b649f35087e7592aeec176646fc8c2629288944261cd35b5fcba'
	},
	SHA384TestCase{
		name:    'test case 125'
		message: '9d36818d0c5a008be7904d1917aa3eccb5ef4f38cecb8c4e63c4b2e9b4b091a3bf25b4ed0332445f894c2a4c258b749afa17fad03cdd41713a869f899ba9a085e73fa9474a58db7a950d3a2386b60f79495d8bf73e72acaffdbf65e1989ff9cc206ba8c46a368d8512bac7c7c191d713aca949d45df297b1b6594a1a33'
		digest:  'a88da844579f3e3725d00daa8e1e287da4bfbb2d931ebe8d3b16021154be503341d6371d382ada744f86f5bbb56cdcfa'
	},
	SHA384TestCase{
		name:    'test case 126'
		message: '4ae50ed626ee60dc5ea556e3ce0d3c18b9e6225b5620814e8b9621acf8f939dd370ad9c7620d85e6d67a229f37f517d1b580acae8df0b5c9d29d756f6d5ebd3b63b554e556469b5b4f8e7113bad1559fb254ca827fcd00425d18b0be7f2b48c2544c48d90982ec624f490be65e893fa93ac9467f35a0a8e1b56d9a403748'
		digest:  'f8cd943f429333c7c8d30a8576827f92c92ae18e0dbcae770601b79687bccf8c23e9e589dfeb45c3b9bcafdd545e45e7'
	},
	SHA384TestCase{
		name:    'test case 127'
		message: 'dbed7612448d46cbe0a384d1c93233f02ffd1c984ba765299518656d3723b766c1658d4b1e7047cdc729459e366ef9349efc40cbd990f2a9a24db7a5045e1dea12dce8f9d9f2aaed933f93031e7b8959ac5e7bf6bbbdf30b48f7eb783f8fe292371a2f245c5c94b4acae160767a20ce7c0ea7723d97691d8eedda9efd1fe2d'
		digest:  'fb531a1ed181c732311e56f4b56ed91dcacc0dd6bf1eb4a44be6f87dd7cb1ef9dfb0310f4a79eaaa3f32bf3914d8624e'
	},
	SHA384TestCase{
		name:    'test case 128'
		message: '3bf52cc5ee86b9a0190f390a5c0366a560b557000dbe5115fd9ee11630a62769011575f15881198f227876e8fe685a6939bc8b89fd48a34ec5e71e131462b2886794dffa68ccc6d564733e67ffef25e627c6f4b5460796e3bce67bf58ca6e8e555bc916a8531697ac948b90dc8616f25101db90b50c3d3dbc9e21e42ff387187'
		digest:  '12b6cb35eda92ee37356ddee77781a17b3d90e563824a984faffc6fdd1693bd7626039635563cfc3b9a2b00f9c65eefd'
	},
]

fn test_short_messages() {
	for c in short_cases {
		message := hex.decode(c.message)!
		expected_result := hex.decode(c.digest)!

		actual_result := sha512.sum384(message)

		assert actual_result == expected_result, 'failed ${c.name}'
	}
}
