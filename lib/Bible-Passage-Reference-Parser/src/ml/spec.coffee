bcv_parser = require("../../js/ml_bcv_parser.js").bcv_parser

describe "Parsing", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.options.osis_compaction_strategy = "b"
		p.options.sequence_combination_strategy = "combine"

	it "should round-trip OSIS references", ->
		p.set_options osis_compaction_strategy: "bc"
		books = ["Gen","Exod","Lev","Num","Deut","Josh","Judg","Ruth","1Sam","2Sam","1Kgs","2Kgs","1Chr","2Chr","Ezra","Neh","Esth","Job","Ps","Prov","Eccl","Song","Isa","Jer","Lam","Ezek","Dan","Hos","Joel","Amos","Obad","Jonah","Mic","Nah","Hab","Zeph","Hag","Zech","Mal","Matt","Mark","Luke","John","Acts","Rom","1Cor","2Cor","Gal","Eph","Phil","Col","1Thess","2Thess","1Tim","2Tim","Titus","Phlm","Heb","Jas","1Pet","2Pet","1John","2John","3John","Jude","Rev"]
		for book in books
			bc = book + ".1"
			bcv = bc + ".1"
			bcv_range = bcv + "-" + bc + ".2"
			expect(p.parse(bc).osis()).toEqual bc
			expect(p.parse(bcv).osis()).toEqual bcv
			expect(p.parse(bcv_range).osis()).toEqual bcv_range

	it "should round-trip OSIS Apocrypha references", ->
		p.set_options osis_compaction_strategy: "bc", ps151_strategy: "b"
		p.include_apocrypha true
		books = ["Tob","Jdt","GkEsth","Wis","Sir","Bar","PrAzar","Sus","Bel","SgThree","EpJer","1Macc","2Macc","3Macc","4Macc","1Esd","2Esd","PrMan","Ps151"]
		for book in books
			bc = book + ".1"
			bcv = bc + ".1"
			bcv_range = bcv + "-" + bc + ".2"
			expect(p.parse(bc).osis()).toEqual bc
			expect(p.parse(bcv).osis()).toEqual bcv
			expect(p.parse(bcv_range).osis()).toEqual bcv_range
		p.set_options ps151_strategy: "bc"
		expect(p.parse("Ps151.1").osis()).toEqual "Ps.151"
		expect(p.parse("Ps151.1.1").osis()).toEqual "Ps.151.1"
		expect(p.parse("Ps151.1-Ps151.2").osis()).toEqual "Ps.151.1-Ps.151.2"
		p.include_apocrypha false
		for book in books
			bc = book + ".1"
			expect(p.parse(bc).osis()).toEqual ""

	it "should handle a preceding character", ->
		expect(p.parse(" Gen 1").osis()).toEqual "Gen.1"
		expect(p.parse("Matt5John3").osis()).toEqual "Matt.5,John.3"
		expect(p.parse("1Ps 1").osis()).toEqual ""
		expect(p.parse("11Sam 1").osis()).toEqual ""

describe "Localized book Gen (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Gen (ml)", ->
		`
		expect(p.parse("ഉല്പ്പത്തി 1:1").osis()).toEqual("Gen.1.1")
		expect(p.parse("ഉല്പത്തി 1:1").osis()).toEqual("Gen.1.1")
		expect(p.parse("ഉല്പ 1:1").osis()).toEqual("Gen.1.1")
		expect(p.parse("Gen 1:1").osis()).toEqual("Gen.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഉല്പ്പത്തി 1:1").osis()).toEqual("Gen.1.1")
		expect(p.parse("ഉല്പത്തി 1:1").osis()).toEqual("Gen.1.1")
		expect(p.parse("ഉല്പ 1:1").osis()).toEqual("Gen.1.1")
		expect(p.parse("GEN 1:1").osis()).toEqual("Gen.1.1")
		`
		true
describe "Localized book Exod (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Exod (ml)", ->
		`
		expect(p.parse("പുറപ്പാടു് 1:1").osis()).toEqual("Exod.1.1")
		expect(p.parse("പുറപ്പാട് 1:1").osis()).toEqual("Exod.1.1")
		expect(p.parse("Exod 1:1").osis()).toEqual("Exod.1.1")
		expect(p.parse("പുറ 1:1").osis()).toEqual("Exod.1.1")
		p.include_apocrypha(false)
		expect(p.parse("പുറപ്പാടു് 1:1").osis()).toEqual("Exod.1.1")
		expect(p.parse("പുറപ്പാട് 1:1").osis()).toEqual("Exod.1.1")
		expect(p.parse("EXOD 1:1").osis()).toEqual("Exod.1.1")
		expect(p.parse("പുറ 1:1").osis()).toEqual("Exod.1.1")
		`
		true
describe "Localized book Bel (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Bel (ml)", ->
		`
		expect(p.parse("Bel 1:1").osis()).toEqual("Bel.1.1")
		`
		true
describe "Localized book Lev (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Lev (ml)", ->
		`
		expect(p.parse("ലേവ്യപുസ്തകം 1:1").osis()).toEqual("Lev.1.1")
		expect(p.parse("Lev 1:1").osis()).toEqual("Lev.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ലേവ്യപുസ്തകം 1:1").osis()).toEqual("Lev.1.1")
		expect(p.parse("LEV 1:1").osis()).toEqual("Lev.1.1")
		`
		true
describe "Localized book Num (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Num (ml)", ->
		`
		expect(p.parse("സംഖ്യാപുസ്തകം 1:1").osis()).toEqual("Num.1.1")
		expect(p.parse("സംഖ്യാ 1:1").osis()).toEqual("Num.1.1")
		expect(p.parse("Num 1:1").osis()).toEqual("Num.1.1")
		p.include_apocrypha(false)
		expect(p.parse("സംഖ്യാപുസ്തകം 1:1").osis()).toEqual("Num.1.1")
		expect(p.parse("സംഖ്യാ 1:1").osis()).toEqual("Num.1.1")
		expect(p.parse("NUM 1:1").osis()).toEqual("Num.1.1")
		`
		true
describe "Localized book Sir (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Sir (ml)", ->
		`
		expect(p.parse("Sir 1:1").osis()).toEqual("Sir.1.1")
		`
		true
describe "Localized book Wis (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Wis (ml)", ->
		`
		expect(p.parse("Wis 1:1").osis()).toEqual("Wis.1.1")
		`
		true
describe "Localized book Lam (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Lam (ml)", ->
		`
		expect(p.parse("വിലാപങ്ങൾ 1:1").osis()).toEqual("Lam.1.1")
		expect(p.parse("Lam 1:1").osis()).toEqual("Lam.1.1")
		p.include_apocrypha(false)
		expect(p.parse("വിലാപങ്ങൾ 1:1").osis()).toEqual("Lam.1.1")
		expect(p.parse("LAM 1:1").osis()).toEqual("Lam.1.1")
		`
		true
describe "Localized book EpJer (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: EpJer (ml)", ->
		`
		expect(p.parse("EpJer 1:1").osis()).toEqual("EpJer.1.1")
		`
		true
describe "Localized book Rev (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Rev (ml)", ->
		`
		expect(p.parse("വെളിപ്പാടു 1:1").osis()).toEqual("Rev.1.1")
		expect(p.parse("വെളിപാട് 1:1").osis()).toEqual("Rev.1.1")
		expect(p.parse("വെളി 1:1").osis()).toEqual("Rev.1.1")
		expect(p.parse("Rev 1:1").osis()).toEqual("Rev.1.1")
		p.include_apocrypha(false)
		expect(p.parse("വെളിപ്പാടു 1:1").osis()).toEqual("Rev.1.1")
		expect(p.parse("വെളിപാട് 1:1").osis()).toEqual("Rev.1.1")
		expect(p.parse("വെളി 1:1").osis()).toEqual("Rev.1.1")
		expect(p.parse("REV 1:1").osis()).toEqual("Rev.1.1")
		`
		true
describe "Localized book PrMan (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: PrMan (ml)", ->
		`
		expect(p.parse("PrMan 1:1").osis()).toEqual("PrMan.1.1")
		`
		true
describe "Localized book Deut (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Deut (ml)", ->
		`
		expect(p.parse("ആവർത്തനപുസ്തകം 1:1").osis()).toEqual("Deut.1.1")
		expect(p.parse("ആവർത്തനം 1:1").osis()).toEqual("Deut.1.1")
		expect(p.parse("Deut 1:1").osis()).toEqual("Deut.1.1")
		expect(p.parse("ആവർ 1:1").osis()).toEqual("Deut.1.1")
		expect(p.parse("ആവ 1:1").osis()).toEqual("Deut.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ആവർത്തനപുസ്തകം 1:1").osis()).toEqual("Deut.1.1")
		expect(p.parse("ആവർത്തനം 1:1").osis()).toEqual("Deut.1.1")
		expect(p.parse("DEUT 1:1").osis()).toEqual("Deut.1.1")
		expect(p.parse("ആവർ 1:1").osis()).toEqual("Deut.1.1")
		expect(p.parse("ആവ 1:1").osis()).toEqual("Deut.1.1")
		`
		true
describe "Localized book Josh (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Josh (ml)", ->
		`
		expect(p.parse("യോശുവ 1:1").osis()).toEqual("Josh.1.1")
		expect(p.parse("Josh 1:1").osis()).toEqual("Josh.1.1")
		p.include_apocrypha(false)
		expect(p.parse("യോശുവ 1:1").osis()).toEqual("Josh.1.1")
		expect(p.parse("JOSH 1:1").osis()).toEqual("Josh.1.1")
		`
		true
describe "Localized book Judg (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Judg (ml)", ->
		`
		expect(p.parse("ന്യായാധിപന്മാർ 1:1").osis()).toEqual("Judg.1.1")
		expect(p.parse("Judg 1:1").osis()).toEqual("Judg.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ന്യായാധിപന്മാർ 1:1").osis()).toEqual("Judg.1.1")
		expect(p.parse("JUDG 1:1").osis()).toEqual("Judg.1.1")
		`
		true
describe "Localized book Ruth (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Ruth (ml)", ->
		`
		expect(p.parse("രൂത്ത് 1:1").osis()).toEqual("Ruth.1.1")
		expect(p.parse("Ruth 1:1").osis()).toEqual("Ruth.1.1")
		p.include_apocrypha(false)
		expect(p.parse("രൂത്ത് 1:1").osis()).toEqual("Ruth.1.1")
		expect(p.parse("RUTH 1:1").osis()).toEqual("Ruth.1.1")
		`
		true
describe "Localized book 1Esd (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1Esd (ml)", ->
		`
		expect(p.parse("1Esd 1:1").osis()).toEqual("1Esd.1.1")
		`
		true
describe "Localized book 2Esd (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2Esd (ml)", ->
		`
		expect(p.parse("2Esd 1:1").osis()).toEqual("2Esd.1.1")
		`
		true
describe "Localized book Isa (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Isa (ml)", ->
		`
		expect(p.parse("യെശയ്യാവു 1:1").osis()).toEqual("Isa.1.1")
		expect(p.parse("യെശയ്യാവ് 1:1").osis()).toEqual("Isa.1.1")
		expect(p.parse("യെശയ്യാ 1:1").osis()).toEqual("Isa.1.1")
		expect(p.parse("Isa 1:1").osis()).toEqual("Isa.1.1")
		expect(p.parse("യെശ 1:1").osis()).toEqual("Isa.1.1")
		p.include_apocrypha(false)
		expect(p.parse("യെശയ്യാവു 1:1").osis()).toEqual("Isa.1.1")
		expect(p.parse("യെശയ്യാവ് 1:1").osis()).toEqual("Isa.1.1")
		expect(p.parse("യെശയ്യാ 1:1").osis()).toEqual("Isa.1.1")
		expect(p.parse("ISA 1:1").osis()).toEqual("Isa.1.1")
		expect(p.parse("യെശ 1:1").osis()).toEqual("Isa.1.1")
		`
		true
describe "Localized book 2Sam (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2Sam (ml)", ->
		`
		expect(p.parse("2.. ശമൂവേൽ 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2. ശമൂവേൽ 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2 ശമൂവേൽ 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2.. ശമു 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2. ശമു 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2 ശമു 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2Sam 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2ശമു 1:1").osis()).toEqual("2Sam.1.1")
		p.include_apocrypha(false)
		expect(p.parse("2.. ശമൂവേൽ 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2. ശമൂവേൽ 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2 ശമൂവേൽ 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2.. ശമു 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2. ശമു 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2 ശമു 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2SAM 1:1").osis()).toEqual("2Sam.1.1")
		expect(p.parse("2ശമു 1:1").osis()).toEqual("2Sam.1.1")
		`
		true
describe "Localized book 1Sam (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1Sam (ml)", ->
		`
		expect(p.parse("1.. ശമൂവേൽ 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1. ശമൂവേൽ 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1 ശമൂവേൽ 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1.. ശമു 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1. ശമു 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1 ശമു 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1Sam 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1ശമു 1:1").osis()).toEqual("1Sam.1.1")
		p.include_apocrypha(false)
		expect(p.parse("1.. ശമൂവേൽ 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1. ശമൂവേൽ 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1 ശമൂവേൽ 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1.. ശമു 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1. ശമു 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1 ശമു 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1SAM 1:1").osis()).toEqual("1Sam.1.1")
		expect(p.parse("1ശമു 1:1").osis()).toEqual("1Sam.1.1")
		`
		true
describe "Localized book 2Kgs (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2Kgs (ml)", ->
		`
		expect(p.parse("2.. രാജാക്കന്മാർ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2. രാജാക്കന്മാർ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2 രാജാക്കന്മാർ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2.. രാജാ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2. രാജാ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2 രാജാ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2Kgs 1:1").osis()).toEqual("2Kgs.1.1")
		p.include_apocrypha(false)
		expect(p.parse("2.. രാജാക്കന്മാർ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2. രാജാക്കന്മാർ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2 രാജാക്കന്മാർ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2.. രാജാ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2. രാജാ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2 രാജാ 1:1").osis()).toEqual("2Kgs.1.1")
		expect(p.parse("2KGS 1:1").osis()).toEqual("2Kgs.1.1")
		`
		true
describe "Localized book 1Kgs (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1Kgs (ml)", ->
		`
		expect(p.parse("1.. രാജാക്കന്മാർ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1. രാജാക്കന്മാർ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1 രാജാക്കന്മാർ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1.. രാജാ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1. രാജാ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1 രാജാ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1Kgs 1:1").osis()).toEqual("1Kgs.1.1")
		p.include_apocrypha(false)
		expect(p.parse("1.. രാജാക്കന്മാർ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1. രാജാക്കന്മാർ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1 രാജാക്കന്മാർ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1.. രാജാ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1. രാജാ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1 രാജാ 1:1").osis()).toEqual("1Kgs.1.1")
		expect(p.parse("1KGS 1:1").osis()).toEqual("1Kgs.1.1")
		`
		true
describe "Localized book 2Chr (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2Chr (ml)", ->
		`
		expect(p.parse("2.. ദിനവൃത്താന്തം 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2. ദിനവൃത്താന്തം 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2 ദിനവൃത്താന്തം 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2.. ദിന 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2. ദിന 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2 ദിന 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2Chr 1:1").osis()).toEqual("2Chr.1.1")
		p.include_apocrypha(false)
		expect(p.parse("2.. ദിനവൃത്താന്തം 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2. ദിനവൃത്താന്തം 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2 ദിനവൃത്താന്തം 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2.. ദിന 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2. ദിന 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2 ദിന 1:1").osis()).toEqual("2Chr.1.1")
		expect(p.parse("2CHR 1:1").osis()).toEqual("2Chr.1.1")
		`
		true
describe "Localized book 1Chr (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1Chr (ml)", ->
		`
		expect(p.parse("1.. ദിനവൃത്താന്തം 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1. ദിനവൃത്താന്തം 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1 ദിനവൃത്താന്തം 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1.. ദിന 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1. ദിന 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1 ദിന 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1Chr 1:1").osis()).toEqual("1Chr.1.1")
		p.include_apocrypha(false)
		expect(p.parse("1.. ദിനവൃത്താന്തം 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1. ദിനവൃത്താന്തം 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1 ദിനവൃത്താന്തം 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1.. ദിന 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1. ദിന 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1 ദിന 1:1").osis()).toEqual("1Chr.1.1")
		expect(p.parse("1CHR 1:1").osis()).toEqual("1Chr.1.1")
		`
		true
describe "Localized book Ezra (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Ezra (ml)", ->
		`
		expect(p.parse("എസ്രാ 1:1").osis()).toEqual("Ezra.1.1")
		expect(p.parse("Ezra 1:1").osis()).toEqual("Ezra.1.1")
		p.include_apocrypha(false)
		expect(p.parse("എസ്രാ 1:1").osis()).toEqual("Ezra.1.1")
		expect(p.parse("EZRA 1:1").osis()).toEqual("Ezra.1.1")
		`
		true
describe "Localized book Neh (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Neh (ml)", ->
		`
		expect(p.parse("നെഹെമ്യാവു 1:1").osis()).toEqual("Neh.1.1")
		expect(p.parse("Neh 1:1").osis()).toEqual("Neh.1.1")
		p.include_apocrypha(false)
		expect(p.parse("നെഹെമ്യാവു 1:1").osis()).toEqual("Neh.1.1")
		expect(p.parse("NEH 1:1").osis()).toEqual("Neh.1.1")
		`
		true
describe "Localized book GkEsth (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: GkEsth (ml)", ->
		`
		expect(p.parse("GkEsth 1:1").osis()).toEqual("GkEsth.1.1")
		`
		true
describe "Localized book Esth (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Esth (ml)", ->
		`
		expect(p.parse("എസ്ഥേർ 1:1").osis()).toEqual("Esth.1.1")
		expect(p.parse("Esth 1:1").osis()).toEqual("Esth.1.1")
		p.include_apocrypha(false)
		expect(p.parse("എസ്ഥേർ 1:1").osis()).toEqual("Esth.1.1")
		expect(p.parse("ESTH 1:1").osis()).toEqual("Esth.1.1")
		`
		true
describe "Localized book Job (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Job (ml)", ->
		`
		expect(p.parse("ഇയ്യോബ് 1:1").osis()).toEqual("Job.1.1")
		expect(p.parse("ഇയ്യോ 1:1").osis()).toEqual("Job.1.1")
		expect(p.parse("Job 1:1").osis()).toEqual("Job.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഇയ്യോബ് 1:1").osis()).toEqual("Job.1.1")
		expect(p.parse("ഇയ്യോ 1:1").osis()).toEqual("Job.1.1")
		expect(p.parse("JOB 1:1").osis()).toEqual("Job.1.1")
		`
		true
describe "Localized book Ps (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Ps (ml)", ->
		`
		expect(p.parse("സങ്കീർത്തനങ്ങൾ 1:1").osis()).toEqual("Ps.1.1")
		expect(p.parse("സങ്കീ 1:1").osis()).toEqual("Ps.1.1")
		expect(p.parse("Ps 1:1").osis()).toEqual("Ps.1.1")
		p.include_apocrypha(false)
		expect(p.parse("സങ്കീർത്തനങ്ങൾ 1:1").osis()).toEqual("Ps.1.1")
		expect(p.parse("സങ്കീ 1:1").osis()).toEqual("Ps.1.1")
		expect(p.parse("PS 1:1").osis()).toEqual("Ps.1.1")
		`
		true
describe "Localized book PrAzar (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: PrAzar (ml)", ->
		`
		expect(p.parse("PrAzar 1:1").osis()).toEqual("PrAzar.1.1")
		`
		true
describe "Localized book Prov (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Prov (ml)", ->
		`
		expect(p.parse("സദൃശ്യവാക്യങ്ങൾ 1:1").osis()).toEqual("Prov.1.1")
		expect(p.parse("സദൃശവാക്യങ്ങൾ 1:1").osis()).toEqual("Prov.1.1")
		expect(p.parse("Prov 1:1").osis()).toEqual("Prov.1.1")
		expect(p.parse("സദൃശ 1:1").osis()).toEqual("Prov.1.1")
		p.include_apocrypha(false)
		expect(p.parse("സദൃശ്യവാക്യങ്ങൾ 1:1").osis()).toEqual("Prov.1.1")
		expect(p.parse("സദൃശവാക്യങ്ങൾ 1:1").osis()).toEqual("Prov.1.1")
		expect(p.parse("PROV 1:1").osis()).toEqual("Prov.1.1")
		expect(p.parse("സദൃശ 1:1").osis()).toEqual("Prov.1.1")
		`
		true
describe "Localized book Eccl (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Eccl (ml)", ->
		`
		expect(p.parse("സഭാപ്രസംഗി 1:1").osis()).toEqual("Eccl.1.1")
		expect(p.parse("Eccl 1:1").osis()).toEqual("Eccl.1.1")
		p.include_apocrypha(false)
		expect(p.parse("സഭാപ്രസംഗി 1:1").osis()).toEqual("Eccl.1.1")
		expect(p.parse("ECCL 1:1").osis()).toEqual("Eccl.1.1")
		`
		true
describe "Localized book SgThree (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: SgThree (ml)", ->
		`
		expect(p.parse("SgThree 1:1").osis()).toEqual("SgThree.1.1")
		`
		true
describe "Localized book Song (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Song (ml)", ->
		`
		expect(p.parse("ഉത്തമ ഗീതം 1:1").osis()).toEqual("Song.1.1")
		expect(p.parse("ഉത്തമഗീതം 1:1").osis()).toEqual("Song.1.1")
		expect(p.parse("Song 1:1").osis()).toEqual("Song.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഉത്തമ ഗീതം 1:1").osis()).toEqual("Song.1.1")
		expect(p.parse("ഉത്തമഗീതം 1:1").osis()).toEqual("Song.1.1")
		expect(p.parse("SONG 1:1").osis()).toEqual("Song.1.1")
		`
		true
describe "Localized book Jer (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Jer (ml)", ->
		`
		expect(p.parse("യിരെമ്യാവു 1:1").osis()).toEqual("Jer.1.1")
		expect(p.parse("യിരേമ്യാവു 1:1").osis()).toEqual("Jer.1.1")
		expect(p.parse("യിരെ 1:1").osis()).toEqual("Jer.1.1")
		expect(p.parse("Jer 1:1").osis()).toEqual("Jer.1.1")
		p.include_apocrypha(false)
		expect(p.parse("യിരെമ്യാവു 1:1").osis()).toEqual("Jer.1.1")
		expect(p.parse("യിരേമ്യാവു 1:1").osis()).toEqual("Jer.1.1")
		expect(p.parse("യിരെ 1:1").osis()).toEqual("Jer.1.1")
		expect(p.parse("JER 1:1").osis()).toEqual("Jer.1.1")
		`
		true
describe "Localized book Ezek (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Ezek (ml)", ->
		`
		expect(p.parse("യെഹെസ്കേൽ 1:1").osis()).toEqual("Ezek.1.1")
		expect(p.parse("യേഹേസ്കേൽ 1:1").osis()).toEqual("Ezek.1.1")
		expect(p.parse("Ezek 1:1").osis()).toEqual("Ezek.1.1")
		p.include_apocrypha(false)
		expect(p.parse("യെഹെസ്കേൽ 1:1").osis()).toEqual("Ezek.1.1")
		expect(p.parse("യേഹേസ്കേൽ 1:1").osis()).toEqual("Ezek.1.1")
		expect(p.parse("EZEK 1:1").osis()).toEqual("Ezek.1.1")
		`
		true
describe "Localized book Dan (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Dan (ml)", ->
		`
		expect(p.parse("ദാനീയേൽ 1:1").osis()).toEqual("Dan.1.1")
		expect(p.parse("ദാനീ 1:1").osis()).toEqual("Dan.1.1")
		expect(p.parse("Dan 1:1").osis()).toEqual("Dan.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ദാനീയേൽ 1:1").osis()).toEqual("Dan.1.1")
		expect(p.parse("ദാനീ 1:1").osis()).toEqual("Dan.1.1")
		expect(p.parse("DAN 1:1").osis()).toEqual("Dan.1.1")
		`
		true
describe "Localized book Hos (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Hos (ml)", ->
		`
		expect(p.parse("ഹോശേയ 1:1").osis()).toEqual("Hos.1.1")
		expect(p.parse("Hos 1:1").osis()).toEqual("Hos.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഹോശേയ 1:1").osis()).toEqual("Hos.1.1")
		expect(p.parse("HOS 1:1").osis()).toEqual("Hos.1.1")
		`
		true
describe "Localized book Joel (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Joel (ml)", ->
		`
		expect(p.parse("യോവേൽ 1:1").osis()).toEqual("Joel.1.1")
		expect(p.parse("Joel 1:1").osis()).toEqual("Joel.1.1")
		p.include_apocrypha(false)
		expect(p.parse("യോവേൽ 1:1").osis()).toEqual("Joel.1.1")
		expect(p.parse("JOEL 1:1").osis()).toEqual("Joel.1.1")
		`
		true
describe "Localized book Amos (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Amos (ml)", ->
		`
		expect(p.parse("ആമോസ് 1:1").osis()).toEqual("Amos.1.1")
		expect(p.parse("Amos 1:1").osis()).toEqual("Amos.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ആമോസ് 1:1").osis()).toEqual("Amos.1.1")
		expect(p.parse("AMOS 1:1").osis()).toEqual("Amos.1.1")
		`
		true
describe "Localized book Obad (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Obad (ml)", ->
		`
		expect(p.parse("ഓബദ്യാവു 1:1").osis()).toEqual("Obad.1.1")
		expect(p.parse("Obad 1:1").osis()).toEqual("Obad.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഓബദ്യാവു 1:1").osis()).toEqual("Obad.1.1")
		expect(p.parse("OBAD 1:1").osis()).toEqual("Obad.1.1")
		`
		true
describe "Localized book Jonah (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Jonah (ml)", ->
		`
		expect(p.parse("Jonah 1:1").osis()).toEqual("Jonah.1.1")
		expect(p.parse("യോനാ 1:1").osis()).toEqual("Jonah.1.1")
		p.include_apocrypha(false)
		expect(p.parse("JONAH 1:1").osis()).toEqual("Jonah.1.1")
		expect(p.parse("യോനാ 1:1").osis()).toEqual("Jonah.1.1")
		`
		true
describe "Localized book Mic (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Mic (ml)", ->
		`
		expect(p.parse("മീഖാ 1:1").osis()).toEqual("Mic.1.1")
		expect(p.parse("Mic 1:1").osis()).toEqual("Mic.1.1")
		p.include_apocrypha(false)
		expect(p.parse("മീഖാ 1:1").osis()).toEqual("Mic.1.1")
		expect(p.parse("MIC 1:1").osis()).toEqual("Mic.1.1")
		`
		true
describe "Localized book Nah (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Nah (ml)", ->
		`
		expect(p.parse("നഹൂം 1:1").osis()).toEqual("Nah.1.1")
		expect(p.parse("Nah 1:1").osis()).toEqual("Nah.1.1")
		p.include_apocrypha(false)
		expect(p.parse("നഹൂം 1:1").osis()).toEqual("Nah.1.1")
		expect(p.parse("NAH 1:1").osis()).toEqual("Nah.1.1")
		`
		true
describe "Localized book Hab (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Hab (ml)", ->
		`
		expect(p.parse("ഹബക്കൂക്‍ 1:1").osis()).toEqual("Hab.1.1")
		expect(p.parse("ഹബക്കൂൿ 1:1").osis()).toEqual("Hab.1.1")
		expect(p.parse("Hab 1:1").osis()).toEqual("Hab.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഹബക്കൂക്‍ 1:1").osis()).toEqual("Hab.1.1")
		expect(p.parse("ഹബക്കൂൿ 1:1").osis()).toEqual("Hab.1.1")
		expect(p.parse("HAB 1:1").osis()).toEqual("Hab.1.1")
		`
		true
describe "Localized book Zeph (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Zeph (ml)", ->
		`
		expect(p.parse("സെഫന്യാവു 1:1").osis()).toEqual("Zeph.1.1")
		expect(p.parse("Zeph 1:1").osis()).toEqual("Zeph.1.1")
		p.include_apocrypha(false)
		expect(p.parse("സെഫന്യാവു 1:1").osis()).toEqual("Zeph.1.1")
		expect(p.parse("ZEPH 1:1").osis()).toEqual("Zeph.1.1")
		`
		true
describe "Localized book Hag (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Hag (ml)", ->
		`
		expect(p.parse("ഹഗ്ഗായി 1:1").osis()).toEqual("Hag.1.1")
		expect(p.parse("Hag 1:1").osis()).toEqual("Hag.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഹഗ്ഗായി 1:1").osis()).toEqual("Hag.1.1")
		expect(p.parse("HAG 1:1").osis()).toEqual("Hag.1.1")
		`
		true
describe "Localized book Zech (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Zech (ml)", ->
		`
		expect(p.parse("സെഖർയ്യാവു 1:1").osis()).toEqual("Zech.1.1")
		expect(p.parse("സെഖര്യാവു 1:1").osis()).toEqual("Zech.1.1")
		expect(p.parse("സെഖര്യാവ് 1:1").osis()).toEqual("Zech.1.1")
		expect(p.parse("സെഖര്യാ 1:1").osis()).toEqual("Zech.1.1")
		expect(p.parse("Zech 1:1").osis()).toEqual("Zech.1.1")
		p.include_apocrypha(false)
		expect(p.parse("സെഖർയ്യാവു 1:1").osis()).toEqual("Zech.1.1")
		expect(p.parse("സെഖര്യാവു 1:1").osis()).toEqual("Zech.1.1")
		expect(p.parse("സെഖര്യാവ് 1:1").osis()).toEqual("Zech.1.1")
		expect(p.parse("സെഖര്യാ 1:1").osis()).toEqual("Zech.1.1")
		expect(p.parse("ZECH 1:1").osis()).toEqual("Zech.1.1")
		`
		true
describe "Localized book Mal (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Mal (ml)", ->
		`
		expect(p.parse("മലാഖി 1:1").osis()).toEqual("Mal.1.1")
		expect(p.parse("Mal 1:1").osis()).toEqual("Mal.1.1")
		p.include_apocrypha(false)
		expect(p.parse("മലാഖി 1:1").osis()).toEqual("Mal.1.1")
		expect(p.parse("MAL 1:1").osis()).toEqual("Mal.1.1")
		`
		true
describe "Localized book Matt (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Matt (ml)", ->
		`
		expect(p.parse("മത്തായി 1:1").osis()).toEqual("Matt.1.1")
		expect(p.parse("മത്താ 1:1").osis()).toEqual("Matt.1.1")
		expect(p.parse("Matt 1:1").osis()).toEqual("Matt.1.1")
		p.include_apocrypha(false)
		expect(p.parse("മത്തായി 1:1").osis()).toEqual("Matt.1.1")
		expect(p.parse("മത്താ 1:1").osis()).toEqual("Matt.1.1")
		expect(p.parse("MATT 1:1").osis()).toEqual("Matt.1.1")
		`
		true
describe "Localized book Mark (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Mark (ml)", ->
		`
		expect(p.parse("മർക്കൊസ് 1:1").osis()).toEqual("Mark.1.1")
		expect(p.parse("മർക്കൊ 1:1").osis()).toEqual("Mark.1.1")
		expect(p.parse("Mark 1:1").osis()).toEqual("Mark.1.1")
		p.include_apocrypha(false)
		expect(p.parse("മർക്കൊസ് 1:1").osis()).toEqual("Mark.1.1")
		expect(p.parse("മർക്കൊ 1:1").osis()).toEqual("Mark.1.1")
		expect(p.parse("MARK 1:1").osis()).toEqual("Mark.1.1")
		`
		true
describe "Localized book Luke (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Luke (ml)", ->
		`
		expect(p.parse("ലൂക്കൊസ് 1:1").osis()).toEqual("Luke.1.1")
		expect(p.parse("ലൂക്കോസ് 1:1").osis()).toEqual("Luke.1.1")
		expect(p.parse("ലൂക്കൊ 1:1").osis()).toEqual("Luke.1.1")
		expect(p.parse("Luke 1:1").osis()).toEqual("Luke.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ലൂക്കൊസ് 1:1").osis()).toEqual("Luke.1.1")
		expect(p.parse("ലൂക്കോസ് 1:1").osis()).toEqual("Luke.1.1")
		expect(p.parse("ലൂക്കൊ 1:1").osis()).toEqual("Luke.1.1")
		expect(p.parse("LUKE 1:1").osis()).toEqual("Luke.1.1")
		`
		true
describe "Localized book 1John (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1John (ml)", ->
		`
		expect(p.parse("1.. യോഹന്നാൻ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1. യോഹന്നാൻ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1 യോഹന്നാൻ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1.. യോഹ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1. യോഹ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1 യോഹ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1John 1:1").osis()).toEqual("1John.1.1")
		p.include_apocrypha(false)
		expect(p.parse("1.. യോഹന്നാൻ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1. യോഹന്നാൻ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1 യോഹന്നാൻ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1.. യോഹ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1. യോഹ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1 യോഹ 1:1").osis()).toEqual("1John.1.1")
		expect(p.parse("1JOHN 1:1").osis()).toEqual("1John.1.1")
		`
		true
describe "Localized book 2John (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2John (ml)", ->
		`
		expect(p.parse("2.. യോഹന്നാൻ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2. യോഹന്നാൻ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2 യോഹന്നാൻ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2.. യോഹ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2. യോഹ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2 യോഹ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2John 1:1").osis()).toEqual("2John.1.1")
		p.include_apocrypha(false)
		expect(p.parse("2.. യോഹന്നാൻ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2. യോഹന്നാൻ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2 യോഹന്നാൻ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2.. യോഹ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2. യോഹ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2 യോഹ 1:1").osis()).toEqual("2John.1.1")
		expect(p.parse("2JOHN 1:1").osis()).toEqual("2John.1.1")
		`
		true
describe "Localized book 3John (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 3John (ml)", ->
		`
		expect(p.parse("3.. യോഹന്നാൻ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3. യോഹന്നാൻ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3 യോഹന്നാൻ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3.. യോഹ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3. യോഹ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3 യോഹ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3John 1:1").osis()).toEqual("3John.1.1")
		p.include_apocrypha(false)
		expect(p.parse("3.. യോഹന്നാൻ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3. യോഹന്നാൻ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3 യോഹന്നാൻ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3.. യോഹ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3. യോഹ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3 യോഹ 1:1").osis()).toEqual("3John.1.1")
		expect(p.parse("3JOHN 1:1").osis()).toEqual("3John.1.1")
		`
		true
describe "Localized book John (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: John (ml)", ->
		`
		expect(p.parse("യോഹന്നാൻ 1:1").osis()).toEqual("John.1.1")
		expect(p.parse("John 1:1").osis()).toEqual("John.1.1")
		expect(p.parse("യോഹ 1:1").osis()).toEqual("John.1.1")
		p.include_apocrypha(false)
		expect(p.parse("യോഹന്നാൻ 1:1").osis()).toEqual("John.1.1")
		expect(p.parse("JOHN 1:1").osis()).toEqual("John.1.1")
		expect(p.parse("യോഹ 1:1").osis()).toEqual("John.1.1")
		`
		true
describe "Localized book Acts (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Acts (ml)", ->
		`
		expect(p.parse("അപ്പ. പ്രവര്‍ത്തനങ്ങള്‍ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ്പ പ്രവര്‍ത്തനങ്ങള്‍ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ്പൊ. പ്രവൃത്തികൾ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ്പൊ പ്രവൃത്തികൾ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("പ്രവൃത്തികൾ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ. പ്ര 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ പ്ര 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ.പ്ര 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("Acts 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ. പ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ്ര 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ പ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ.പ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ 1:1").osis()).toEqual("Acts.1.1")
		p.include_apocrypha(false)
		expect(p.parse("അപ്പ. പ്രവര്‍ത്തനങ്ങള്‍ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ്പ പ്രവര്‍ത്തനങ്ങള്‍ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ്പൊ. പ്രവൃത്തികൾ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ്പൊ പ്രവൃത്തികൾ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("പ്രവൃത്തികൾ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ. പ്ര 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ പ്ര 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ.പ്ര 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("ACTS 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ. പ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ്ര 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ പ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അ.പ 1:1").osis()).toEqual("Acts.1.1")
		expect(p.parse("അപ 1:1").osis()).toEqual("Acts.1.1")
		`
		true
describe "Localized book Rom (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Rom (ml)", ->
		`
		expect(p.parse("റോമർ 1:1").osis()).toEqual("Rom.1.1")
		expect(p.parse("Rom 1:1").osis()).toEqual("Rom.1.1")
		expect(p.parse("റോമ 1:1").osis()).toEqual("Rom.1.1")
		p.include_apocrypha(false)
		expect(p.parse("റോമർ 1:1").osis()).toEqual("Rom.1.1")
		expect(p.parse("ROM 1:1").osis()).toEqual("Rom.1.1")
		expect(p.parse("റോമ 1:1").osis()).toEqual("Rom.1.1")
		`
		true
describe "Localized book 2Cor (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2Cor (ml)", ->
		`
		expect(p.parse("2.. കൊരിന്ത്യർ 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2. കൊരിന്ത്യർ 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2 കൊരിന്ത്യർ 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2.. കൊരി 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2. കൊരി 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2 കൊരി 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2Cor 1:1").osis()).toEqual("2Cor.1.1")
		p.include_apocrypha(false)
		expect(p.parse("2.. കൊരിന്ത്യർ 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2. കൊരിന്ത്യർ 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2 കൊരിന്ത്യർ 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2.. കൊരി 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2. കൊരി 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2 കൊരി 1:1").osis()).toEqual("2Cor.1.1")
		expect(p.parse("2COR 1:1").osis()).toEqual("2Cor.1.1")
		`
		true
describe "Localized book 1Cor (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1Cor (ml)", ->
		`
		expect(p.parse("1.. കൊരിന്ത്യർ 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1. കൊരിന്ത്യർ 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1 കൊരിന്ത്യർ 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1.. കൊരി 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1. കൊരി 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1 കൊരി 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1Cor 1:1").osis()).toEqual("1Cor.1.1")
		p.include_apocrypha(false)
		expect(p.parse("1.. കൊരിന്ത്യർ 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1. കൊരിന്ത്യർ 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1 കൊരിന്ത്യർ 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1.. കൊരി 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1. കൊരി 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1 കൊരി 1:1").osis()).toEqual("1Cor.1.1")
		expect(p.parse("1COR 1:1").osis()).toEqual("1Cor.1.1")
		`
		true
describe "Localized book Gal (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Gal (ml)", ->
		`
		expect(p.parse("ഗലാത്തിയാ 1:1").osis()).toEqual("Gal.1.1")
		expect(p.parse("ഗലാത്യർ 1:1").osis()).toEqual("Gal.1.1")
		expect(p.parse("Gal 1:1").osis()).toEqual("Gal.1.1")
		expect(p.parse("ഗലാ 1:1").osis()).toEqual("Gal.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഗലാത്തിയാ 1:1").osis()).toEqual("Gal.1.1")
		expect(p.parse("ഗലാത്യർ 1:1").osis()).toEqual("Gal.1.1")
		expect(p.parse("GAL 1:1").osis()).toEqual("Gal.1.1")
		expect(p.parse("ഗലാ 1:1").osis()).toEqual("Gal.1.1")
		`
		true
describe "Localized book Eph (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Eph (ml)", ->
		`
		expect(p.parse("എഫെസ്യർ 1:1").osis()).toEqual("Eph.1.1")
		expect(p.parse("എഫേസോസ് 1:1").osis()).toEqual("Eph.1.1")
		expect(p.parse("Eph 1:1").osis()).toEqual("Eph.1.1")
		expect(p.parse("എഫെ 1:1").osis()).toEqual("Eph.1.1")
		p.include_apocrypha(false)
		expect(p.parse("എഫെസ്യർ 1:1").osis()).toEqual("Eph.1.1")
		expect(p.parse("എഫേസോസ് 1:1").osis()).toEqual("Eph.1.1")
		expect(p.parse("EPH 1:1").osis()).toEqual("Eph.1.1")
		expect(p.parse("എഫെ 1:1").osis()).toEqual("Eph.1.1")
		`
		true
describe "Localized book Phil (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Phil (ml)", ->
		`
		expect(p.parse("ഫിലിപ്പിയർ 1:1").osis()).toEqual("Phil.1.1")
		expect(p.parse("ഫിലിപ്പി 1:1").osis()).toEqual("Phil.1.1")
		expect(p.parse("Phil 1:1").osis()).toEqual("Phil.1.1")
		expect(p.parse("ഫിലി 1:1").osis()).toEqual("Phil.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഫിലിപ്പിയർ 1:1").osis()).toEqual("Phil.1.1")
		expect(p.parse("ഫിലിപ്പി 1:1").osis()).toEqual("Phil.1.1")
		expect(p.parse("PHIL 1:1").osis()).toEqual("Phil.1.1")
		expect(p.parse("ഫിലി 1:1").osis()).toEqual("Phil.1.1")
		`
		true
describe "Localized book Col (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Col (ml)", ->
		`
		expect(p.parse("കൊലൊസ്സ്യർ 1:1").osis()).toEqual("Col.1.1")
		expect(p.parse("കൊളോസോസ് 1:1").osis()).toEqual("Col.1.1")
		expect(p.parse("കൊലൊ 1:1").osis()).toEqual("Col.1.1")
		expect(p.parse("Col 1:1").osis()).toEqual("Col.1.1")
		p.include_apocrypha(false)
		expect(p.parse("കൊലൊസ്സ്യർ 1:1").osis()).toEqual("Col.1.1")
		expect(p.parse("കൊളോസോസ് 1:1").osis()).toEqual("Col.1.1")
		expect(p.parse("കൊലൊ 1:1").osis()).toEqual("Col.1.1")
		expect(p.parse("COL 1:1").osis()).toEqual("Col.1.1")
		`
		true
describe "Localized book 2Thess (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2Thess (ml)", ->
		`
		expect(p.parse("2.. തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2. തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2 തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2.. തെസ്സ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2. തെസ്സ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2 തെസ്സ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2Thess 1:1").osis()).toEqual("2Thess.1.1")
		p.include_apocrypha(false)
		expect(p.parse("2.. തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2. തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2 തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2.. തെസ്സ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2. തെസ്സ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2 തെസ്സ 1:1").osis()).toEqual("2Thess.1.1")
		expect(p.parse("2THESS 1:1").osis()).toEqual("2Thess.1.1")
		`
		true
describe "Localized book 1Thess (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1Thess (ml)", ->
		`
		expect(p.parse("1.. തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1. തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1 തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1.. തെസ്സ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1. തെസ്സ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1 തെസ്സ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1Thess 1:1").osis()).toEqual("1Thess.1.1")
		p.include_apocrypha(false)
		expect(p.parse("1.. തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1. തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1 തെസ്സലൊനീക്യർ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1.. തെസ്സ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1. തെസ്സ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1 തെസ്സ 1:1").osis()).toEqual("1Thess.1.1")
		expect(p.parse("1THESS 1:1").osis()).toEqual("1Thess.1.1")
		`
		true
describe "Localized book 2Tim (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2Tim (ml)", ->
		`
		expect(p.parse("2.. തിമൊഥെയൊസ് 2.. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2. തിമൊഥെയൊസ് 2.. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2.. തിമൊഥെയൊസ് 2. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2 തിമൊഥെയൊസ് 2.. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2. തിമൊഥെയൊസ് 2. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2.. തിമൊഥെയൊസ് 2 തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2 തിമൊഥെയൊസ് 2. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2. തിമൊഥെയൊസ് 2 തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2 തിമൊഥെയൊസ് 2 തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2.. തിമൊഥയൊസ് 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2. തിമൊഥയൊസ് 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2 തിമൊഥയൊസ് 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2Tim 1:1").osis()).toEqual("2Tim.1.1")
		p.include_apocrypha(false)
		expect(p.parse("2.. തിമൊഥെയൊസ് 2.. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2. തിമൊഥെയൊസ് 2.. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2.. തിമൊഥെയൊസ് 2. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2 തിമൊഥെയൊസ് 2.. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2. തിമൊഥെയൊസ് 2. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2.. തിമൊഥെയൊസ് 2 തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2 തിമൊഥെയൊസ് 2. തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2. തിമൊഥെയൊസ് 2 തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2 തിമൊഥെയൊസ് 2 തിമൊ 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2.. തിമൊഥയൊസ് 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2. തിമൊഥയൊസ് 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2 തിമൊഥയൊസ് 1:1").osis()).toEqual("2Tim.1.1")
		expect(p.parse("2TIM 1:1").osis()).toEqual("2Tim.1.1")
		`
		true
describe "Localized book 1Tim (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1Tim (ml)", ->
		`
		expect(p.parse("1.. തിമൊഥെയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1. തിമൊഥെയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1.. തിമൊഥയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1 തിമൊഥെയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1. തിമൊഥയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1 തിമൊഥയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1.. തിമൊ 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1. തിമൊ 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1 തിമൊ 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1Tim 1:1").osis()).toEqual("1Tim.1.1")
		p.include_apocrypha(false)
		expect(p.parse("1.. തിമൊഥെയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1. തിമൊഥെയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1.. തിമൊഥയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1 തിമൊഥെയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1. തിമൊഥയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1 തിമൊഥയൊസ് 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1.. തിമൊ 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1. തിമൊ 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1 തിമൊ 1:1").osis()).toEqual("1Tim.1.1")
		expect(p.parse("1TIM 1:1").osis()).toEqual("1Tim.1.1")
		`
		true
describe "Localized book Titus (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Titus (ml)", ->
		`
		expect(p.parse("തീത്തൊസ് 1:1").osis()).toEqual("Titus.1.1")
		expect(p.parse("തീത്തൊ 1:1").osis()).toEqual("Titus.1.1")
		expect(p.parse("Titus 1:1").osis()).toEqual("Titus.1.1")
		p.include_apocrypha(false)
		expect(p.parse("തീത്തൊസ് 1:1").osis()).toEqual("Titus.1.1")
		expect(p.parse("തീത്തൊ 1:1").osis()).toEqual("Titus.1.1")
		expect(p.parse("TITUS 1:1").osis()).toEqual("Titus.1.1")
		`
		true
describe "Localized book Phlm (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Phlm (ml)", ->
		`
		expect(p.parse("ഫിലേമോൻ 1:1").osis()).toEqual("Phlm.1.1")
		expect(p.parse("Phlm 1:1").osis()).toEqual("Phlm.1.1")
		p.include_apocrypha(false)
		expect(p.parse("ഫിലേമോൻ 1:1").osis()).toEqual("Phlm.1.1")
		expect(p.parse("PHLM 1:1").osis()).toEqual("Phlm.1.1")
		`
		true
describe "Localized book Heb (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Heb (ml)", ->
		`
		expect(p.parse("എബ്രായർ 1:1").osis()).toEqual("Heb.1.1")
		expect(p.parse("എബ്രാ 1:1").osis()).toEqual("Heb.1.1")
		expect(p.parse("Heb 1:1").osis()).toEqual("Heb.1.1")
		p.include_apocrypha(false)
		expect(p.parse("എബ്രായർ 1:1").osis()).toEqual("Heb.1.1")
		expect(p.parse("എബ്രാ 1:1").osis()).toEqual("Heb.1.1")
		expect(p.parse("HEB 1:1").osis()).toEqual("Heb.1.1")
		`
		true
describe "Localized book Jas (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Jas (ml)", ->
		`
		expect(p.parse("യാക്കോബ് 1:1").osis()).toEqual("Jas.1.1")
		expect(p.parse("യാക്കോ 1:1").osis()).toEqual("Jas.1.1")
		expect(p.parse("Jas 1:1").osis()).toEqual("Jas.1.1")
		p.include_apocrypha(false)
		expect(p.parse("യാക്കോബ് 1:1").osis()).toEqual("Jas.1.1")
		expect(p.parse("യാക്കോ 1:1").osis()).toEqual("Jas.1.1")
		expect(p.parse("JAS 1:1").osis()).toEqual("Jas.1.1")
		`
		true
describe "Localized book 2Pet (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2Pet (ml)", ->
		`
		expect(p.parse("2.. പത്രൊസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2. പത്രൊസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2 പത്രൊസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2.. പതാസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2. പതാസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2 പതാസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2Pet 1:1").osis()).toEqual("2Pet.1.1")
		p.include_apocrypha(false)
		expect(p.parse("2.. പത്രൊസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2. പത്രൊസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2 പത്രൊസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2.. പതാസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2. പതാസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2 പതാസ് 1:1").osis()).toEqual("2Pet.1.1")
		expect(p.parse("2PET 1:1").osis()).toEqual("2Pet.1.1")
		`
		true
describe "Localized book 1Pet (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1Pet (ml)", ->
		`
		expect(p.parse("1.. പത്രൊസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1. പത്രൊസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1 പത്രൊസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1.. പതാസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1. പതാസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1 പതാസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1Pet 1:1").osis()).toEqual("1Pet.1.1")
		p.include_apocrypha(false)
		expect(p.parse("1.. പത്രൊസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1. പത്രൊസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1 പത്രൊസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1.. പതാസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1. പതാസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1 പതാസ് 1:1").osis()).toEqual("1Pet.1.1")
		expect(p.parse("1PET 1:1").osis()).toEqual("1Pet.1.1")
		`
		true
describe "Localized book Jude (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Jude (ml)", ->
		`
		expect(p.parse("യുദാസ് 1:1").osis()).toEqual("Jude.1.1")
		expect(p.parse("Jude 1:1").osis()).toEqual("Jude.1.1")
		expect(p.parse("യൂദാ 1:1").osis()).toEqual("Jude.1.1")
		p.include_apocrypha(false)
		expect(p.parse("യുദാസ് 1:1").osis()).toEqual("Jude.1.1")
		expect(p.parse("JUDE 1:1").osis()).toEqual("Jude.1.1")
		expect(p.parse("യൂദാ 1:1").osis()).toEqual("Jude.1.1")
		`
		true
describe "Localized book Tob (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Tob (ml)", ->
		`
		expect(p.parse("Tob 1:1").osis()).toEqual("Tob.1.1")
		`
		true
describe "Localized book Jdt (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Jdt (ml)", ->
		`
		expect(p.parse("Jdt 1:1").osis()).toEqual("Jdt.1.1")
		`
		true
describe "Localized book Bar (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Bar (ml)", ->
		`
		expect(p.parse("Bar 1:1").osis()).toEqual("Bar.1.1")
		`
		true
describe "Localized book Sus (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: Sus (ml)", ->
		`
		expect(p.parse("Sus 1:1").osis()).toEqual("Sus.1.1")
		`
		true
describe "Localized book 2Macc (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 2Macc (ml)", ->
		`
		expect(p.parse("2Macc 1:1").osis()).toEqual("2Macc.1.1")
		`
		true
describe "Localized book 3Macc (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 3Macc (ml)", ->
		`
		expect(p.parse("3Macc 1:1").osis()).toEqual("3Macc.1.1")
		`
		true
describe "Localized book 4Macc (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 4Macc (ml)", ->
		`
		expect(p.parse("4Macc 1:1").osis()).toEqual("4Macc.1.1")
		`
		true
describe "Localized book 1Macc (ml)", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore",book_sequence_strategy: "ignore",osis_compaction_strategy: "bc",captive_end_digits_strategy: "delete"
		p.include_apocrypha true
	it "should handle book: 1Macc (ml)", ->
		`
		expect(p.parse("1Macc 1:1").osis()).toEqual("1Macc.1.1")
		`
		true

describe "Miscellaneous tests", ->
	p = {}
	beforeEach ->
		p = new bcv_parser
		p.set_options book_alone_strategy: "ignore", book_sequence_strategy: "ignore", osis_compaction_strategy: "bc", captive_end_digits_strategy: "delete"
		p.include_apocrypha true

	it "should return the expected language", ->
		expect(p.languages).toEqual ["ml"]

	it "should handle ranges (ml)", ->
		expect(p.parse("Titus 1:1 ടു 2").osis()).toEqual "Titus.1.1-Titus.1.2"
		expect(p.parse("Matt 1ടു2").osis()).toEqual "Matt.1-Matt.2"
		expect(p.parse("Phlm 2 ടു 3").osis()).toEqual "Phlm.1.2-Phlm.1.3"
	it "should handle chapters (ml)", ->
		expect(p.parse("Titus 1:1, അധ്യായം 2").osis()).toEqual "Titus.1.1,Titus.2"
		expect(p.parse("Matt 3:4 അധ്യായം 6").osis()).toEqual "Matt.3.4,Matt.6"
	it "should handle verses (ml)", ->
		expect(p.parse("Exod 1:1 വാക്യം 3").osis()).toEqual "Exod.1.1,Exod.1.3"
		expect(p.parse("Phlm വാക്യം 6").osis()).toEqual "Phlm.1.6"
	it "should handle 'and' (ml)", ->
		expect(p.parse("Exod 1:1 ഒപ്പം 3").osis()).toEqual "Exod.1.1,Exod.1.3"
		expect(p.parse("Phlm 2 ഒപ്പം 6").osis()).toEqual "Phlm.1.2,Phlm.1.6"
	it "should handle titles (ml)", ->
		expect(p.parse("Ps 3 title, 4:2, 5:title").osis()).toEqual "Ps.3.1,Ps.4.2,Ps.5.1"
		expect(p.parse("PS 3 TITLE, 4:2, 5:TITLE").osis()).toEqual "Ps.3.1,Ps.4.2,Ps.5.1"
	it "should handle 'ff' (ml)", ->
		expect(p.parse("Rev 3ff, 4:2ff").osis()).toEqual "Rev.3-Rev.22,Rev.4.2-Rev.4.11"
		expect(p.parse("REV 3 FF, 4:2 FF").osis()).toEqual "Rev.3-Rev.22,Rev.4.2-Rev.4.11"
	it "should handle translations (ml)", ->
		expect(p.parse("Lev 1 (mlb)").osis_and_translations()).toEqual [["Lev.1", "mlb"]]
		expect(p.parse("lev 1 mlb").osis_and_translations()).toEqual [["Lev.1", "mlb"]]
	it "should handle book ranges (ml)", ->
		p.set_options {book_alone_strategy: "full", book_range_strategy: "include"}
		expect(p.parse("1 ടു 3  യോഹ").osis()).toEqual "1John.1-3John.1"
	it "should handle boundaries (ml)", ->
		p.set_options {book_alone_strategy: "full"}
		expect(p.parse("\u2014Matt\u2014").osis()).toEqual "Matt.1-Matt.28"
		expect(p.parse("\u201cMatt 1:1\u201d").osis()).toEqual "Matt.1.1"
