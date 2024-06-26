-- HACK for setting gui AND 256colors
local colors_256_to_hex = {
  [16] = '#000000',
  [17] = '#00005f',
  [18] = '#000087',
  [19] = '#0000af',
  [20] = '#0000d7',
  [21] = '#0000ff',
  [22] = '#006F00',
  [23] = '#007173',
  [24] = '#007299',
  [25] = '#0074BE',
  [26] = '#005fd7',
  [27] = '#005fff',
  [28] = '#008700',
  [29] = '#00875f',
  [30] = '#009799',
  [31] = '#0099BD',
  [32] = '#0087d7',
  [33] = '#0087ff',
  [34] = '#00af00',
  [35] = '#00af5f',
  [36] = '#00af87',
  [37] = '#00afaf',
  [38] = '#00BDDF',
  [39] = '#00afff',
  [40] = '#00d700',
  [41] = '#00d75f',
  [42] = '#00d787',
  [43] = '#00d7af',
  [44] = '#00d7d7',
  [45] = '#00d7ff',
  [46] = '#00ff00',
  [47] = '#00ff5f',
  [48] = '#00ff87',
  [49] = '#00ffaf',
  [50] = '#00ffd7',
  [51] = '#00ffff',
  [52] = '#730B00',
  [53] = '#5f005f',
  [54] = '#5f0087',
  [55] = '#5f00af',
  [56] = '#5f00d7',
  [57] = '#5f00ff',
  [58] = '#727100',
  [59] = '#727272',
  [60] = '#5f5f87',
  [61] = '#5f5faf',
  [62] = '#5f5fd7',
  [63] = '#5f5fff',
  [64] = '#5f8700',
  [65] = '#719872',
  [66] = '#719899',
  [67] = '#7299BC',
  [68] = '#719CDF',
  [69] = '#5f87ff',
  [70] = '#5faf00',
  [71] = '#5faf5f',
  [72] = '#5faf87',
  [73] = '#6FBCBD',
  [74] = '#70BDDF',
  [75] = '#5fafff',
  [76] = '#5fd700',
  [77] = '#5fd75f',
  [78] = '#5fd787',
  [79] = '#5fd7af',
  [80] = '#5fd7d7',
  [81] = '#5fd7ff',
  [82] = '#5fff00',
  [83] = '#5fff5f',
  [84] = '#5fff87',
  [85] = '#5fffaf',
  [86] = '#5fffd7',
  [87] = '#5fffff',
  [88] = '#9B1300',
  [89] = '#9B1D72',
  [90] = '#870087',
  [91] = '#8700af',
  [92] = '#8700d7',
  [93] = '#8700ff',
  [94] = '#9A7200',
  [95] = '#9A7372',
  [96] = '#9A7599',
  [97] = '#875faf',
  [98] = '#875fd7',
  [99] = '#875fff',
  [100] = '#878700',
  [101] = '#999872',
  [102] = '#878787',
  [103] = '#999ABD',
  [104] = '#8787d7',
  [105] = '#8787ff',
  [106] = '#87af00',
  [107] = '#87af5f',
  [108] = '#98BC99',
  [109] = '#98BCBD',
  [110] = '#98BEDE',
  [111] = '#87afff',
  [112] = '#87d700',
  [113] = '#87d75f',
  [114] = '#87d787',
  [115] = '#87d7af',
  [116] = '#97DDDF',
  [117] = '#87d7ff',
  [118] = '#87ff00',
  [119] = '#87ff5f',
  [120] = '#87ff87',
  [121] = '#87ffaf',
  [122] = '#87ffd7',
  [123] = '#87ffff',
  [124] = '#af0000',
  [125] = '#BF2172',
  [126] = '#af0087',
  [127] = '#af00af',
  [128] = '#af00d7',
  [129] = '#af00ff',
  [130] = '#af5f00',
  [131] = '#BE7572',
  [132] = '#af5f87',
  [133] = '#af5faf',
  [134] = '#af5fd7',
  [135] = '#af5fff',
  [136] = '#af8700',
  [137] = '#BE9873',
  [138] = '#af8787',
  [139] = '#af87af',
  [140] = '#af87d7',
  [141] = '#af87ff',
  [142] = '#afaf00',
  [143] = '#BDBB72',
  [144] = '#BDBC98',
  [145] = '#BDBDBD',
  [146] = '#afafd7',
  [147] = '#afafff',
  [148] = '#afd700',
  [149] = '#afd75f',
  [150] = '#afd787',
  [151] = '#BCDDBD',
  [152] = '#BCDEDE',
  [153] = '#BCE0FF',
  [154] = '#afff00',
  [155] = '#afff5f',
  [156] = '#afff87',
  [157] = '#afffaf',
  [158] = '#afffd7',
  [159] = '#afffff',
  [160] = '#d70000',
  [161] = '#E12672',
  [162] = '#d70087',
  [163] = '#d700af',
  [164] = '#d700d7',
  [165] = '#d700ff',
  [166] = '#d75f00',
  [167] = '#d75f5f',
  [168] = '#E17899',
  [169] = '#d75faf',
  [170] = '#d75fd7',
  [171] = '#d75fff',
  [172] = '#d78700',
  [173] = '#E19972',
  [174] = '#E09B99',
  [175] = '#d787af',
  [176] = '#d787d7',
  [177] = '#d787ff',
  [178] = '#d7af00',
  [179] = '#DFBC72',
  [180] = '#d7af87',
  [181] = '#E0BEBC',
  [182] = '#d7afd7',
  [183] = '#d7afff',
  [184] = '#DEDC00',
  [185] = '#d7d75f',
  [186] = '#DEDD99',
  [187] = '#DFDEBD',
  [188] = '#d7d7d7',
  [189] = '#DFDFFF',
  [190] = '#d7ff00',
  [191] = '#d7ff5f',
  [192] = '#d7ff87',
  [193] = '#d7ffaf',
  [194] = '#d7ffd7',
  [195] = '#d7ffff',
  [196] = '#ff0000',
  [197] = '#ff005f',
  [198] = '#ff0087',
  [199] = '#ff00af',
  [200] = '#ff00d7',
  [201] = '#ff00ff',
  [202] = '#ff5f00',
  [203] = '#ff5f5f',
  [204] = '#ff5f87',
  [205] = '#ff5faf',
  [206] = '#ff5fd7',
  [207] = '#ff5fff',
  [208] = '#ff8700',
  [209] = '#ff875f',
  [210] = '#ff8787',
  [211] = '#ff87af',
  [212] = '#ff87d7',
  [213] = '#ff87ff',
  [214] = '#ffaf00',
  [215] = '#ffaf5f',
  [216] = '#FFBD98',
  [217] = '#FFBFBD',
  [218] = '#FFC0DE',
  [219] = '#ffafff',
  [220] = '#FFDD00',
  [221] = '#ffd75f',
  [222] = '#FFDE99',
  [223] = '#ffd7af',
  [224] = '#FFDFDF',
  [225] = '#ffd7ff',
  [226] = '#ffff00',
  [227] = '#ffff5f',
  [228] = '#ffff87',
  [229] = '#ffffaf',
  [230] = '#FFFFDF',
  [231] = '#FFFFFF',
  [232] = '#060606',
  [233] = '#171717',
  [234] = '#252525',
  [235] = '#333233',
  [236] = '#3F3F3F',
  [237] = '#4B4B4B',
  [238] = '#565656',
  [239] = '#616161',
  [240] = '#6B6B6B',
  [241] = '#757575',
  [242] = '#6c6c6c',
  [243] = '#767676',
  [244] = '#808080',
  [245] = '#8a8a8a',
  [246] = '#949494',
  [247] = '#9e9e9e',
  [248] = '#a8a8a8',
  [249] = '#BFBFBF',
  [250] = '#C8C8C8',
  [251] = '#D1D0D1',
  [252] = '#D9D9D9',
  [253] = '#E1E1E1',
  [254] = '#E9E9E9',
  [255] = '#F1F1F1'
}
return colors_256_to_hex
