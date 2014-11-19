require 'spec_helper'
require 'gettysburg'

RSpec.describe "A string patched by Gettysburg" do
  it "titlecases a normal address with street type written out" do
    expect("510 TERRACE DRIVE".titlecase).to eq "510 Terrace Drive"
  end
  it "titlecases an address with an abbreviated street type" do
    expect("1826 COLORADO AVE".titlecase).to eq "1826 Colorado Ave"
  end
  it "titlecases an address with a suite number" do
    expect("1086 COMMERCE BLVD., SUITE 570".titlecase).to eq "1086 Commerce Blvd., Suite 570"
  end
  it "titlecases an address with a cardinal direction" do
    expect("161 E THIRD ST".titlecase).to eq "161 E Third St"
  end
  it "titlcases an address on a route" do
    expect("11225 OLD RT. 245".titlecase).to eq "11225 Old Rt. 245"
  end
  it "titlecases an address with single letters (not otherwise meaningful)" do
    expect("283 A & B DEACON STREET".titlecase).to eq "283 A & B Deacon Street"
  end
  it "titlecases an address with a numeric street name" do
    expect("985 E 394TH ST".titlecase).to eq "985 E 394th St"
  end
  it "titlecases an address with a unit named with a letter" do
    expect("1056 MAIN CENTRAL SQ UNIT C".titlecase).to eq "1056 Main Central Sq Unit C"
  end
  it "titlecases a street name containing an apostrophe" do
    expect("12887 O'MALLEY WAY".titlecase).to eq "12887 O'Malley Way"
  end
  it "does not titlecase a word with mixed letters and numbers" do
    expect("1183 CHERRY LANE APT1154".titlecase).to eq "1183 Cherry Lane APT1154"
  end
  it "titlecases P.O. boxes" do
    expect("P.O. BOX 81704524".titlecase).to eq "P.O. Box 81704524"
  end
  it "titlecases 'PO' with no periods" do
    expect("PO BOX 113804196".titlecase).to eq "PO Box 113804196"
  end
  it "titlecases a rural road" do
    expect("SEC. 1031079, TWP. 841, RG. 87, RT 1079".titlecase).to eq "Sec. 1031079, Twp. 841, Rg. 87, Rt 1079"
  end
  it "titlecases a cardinal direction with two letters" do
    expect("63881 NW 958 RD".titlecase).to eq "63881 NW 958 Rd"
  end
  it "leaves 'INC' as uppercase" do
    expect("HARRISON HOME RENTALS INC.".titlecase).to eq "Harrison Home Rentals Inc."
  end
  it "leaves 'LLC' as uppercase" do
    expect("ESTHER MAE SMITH LLC".titlecase).to eq "Esther Mae Smith LLC"
  end
  it "leaves 'NA' and 'ISAOA' as uppercase" do
    expect("ALLIANCE BANK, NA, ISAOA".titlecase).to eq "Alliance Bank, NA, ISAOA"
  end
  it "leaves 'ATIMA' uppercase" do
    expect("BANK OF AMERICA ISAOA ATIMA".titlecase).to eq "Bank of America ISAOA ATIMA"
  end
  it "leaves 'ISAOAATIMA' uppercase" do
    expect("BANK OF AMERICA, NA, ISAOAATIMA".titlecase).to eq "Bank of America, NA, ISAOAATIMA"
  end
  it "leaves 'FSB' as uppercase" do
    expect("ELMIRA SAVINGS BANK, FSB".titlecase).to eq "Elmira Savings Bank, FSB"
  end
  it "leaves 'FA' as uppercase" do
    expect("ELMIRA SAVINGS & LOAN, FA".titlecase).to eq "Elmira Savings & Loan, FA"
  end
  it "leaves 'FCU' as uppercase" do
    expect("EMPOWER FCU".titlecase).to eq "Empower FCU"
  end
  it "leaves 'III' in uppercase" do
    expect("FRANKLIN J. SMITH III".titlecase).to eq "Franklin J. Smith III"
  end
  it "leaves 'HSBC' and 'USA' uppercase" do
    expect("HSBC BANK (USA), ISAOA".titlecase).to eq "HSBC Bank (USA), ISAOA"
  end
  it "leaves 'CTA' as uppercase" do
    expect("FRANKLIN B. SMITH AS ADMINISTRATOR CTA OF".titlecase).to eq "Franklin B. Smith as Administrator CTA of"
  end
end
