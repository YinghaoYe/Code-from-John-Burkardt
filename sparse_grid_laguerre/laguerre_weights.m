function weight = laguerre_weights ( order )

%*****************************************************************************80
%
%% LAGUERRE_WEIGHTS returns weights for certain Gauss-Laguerre quadrature rules.
%
%  Discussion:
%
%    The allowed orders are 1, 3, 7, 15, 31, 63 or 127.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    11 October 2007
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Milton Abramowitz, Irene Stegun,
%    Handbook of Mathematical Functions,
%    National Bureau of Standards, 1964,
%    ISBN: 0-486-61272-4,
%    LC: QA47.A34.
%
%    Arthur Stroud, Don Secrest,
%    Gaussian Quadrature Formulas,
%    Prentice Hall, 1966,
%    LC: QA299.4G3S7.
%
%  Parameters:
%
%    Input, integer ORDER, the order of the rule.
%    ORDER must be 1, 3, 7, 15, 31, 63, or 127.
%
%    Output, real WEIGHT(ORDER), the weights.
%    The weights are positive, symmetric and should sum to 1.
%
  if ( order == 1 )

    weight(1) = 1.0E+00;

  elseif ( order == 3 )

    weight(1) =  0.711093009929173015449590191143E+00;
    weight(2) =  0.278517733569240848801444888457E+00;
    weight(3) =  0.103892565015861357489649204007E-01;

  elseif ( order == 7 )

    weight(1) =  0.409318951701273902130432880018E+00;
    weight(2) =  0.421831277861719779929281005417E+00;
    weight(3) =  0.147126348657505278395374184637E+00;
    weight(4) =  0.206335144687169398657056149642E-01;
    weight(5) =  0.107401014328074552213195962843E-02;
    weight(6) =  0.158654643485642012687326223234E-04;
    weight(7) =  0.317031547899558056227132215385E-07;

  elseif ( order == 15 )

    weight(1) =  0.218234885940086889856413236448E+00;
    weight(2) =  0.342210177922883329638948956807E+00;
    weight(3) =  0.263027577941680097414812275022E+00;
    weight(4) =  0.126425818105930535843030549378E+00;
    weight(5) =  0.402068649210009148415854789871E-01;
    weight(6) =  0.856387780361183836391575987649E-02;
    weight(7) =  0.121243614721425207621920522467E-02;
    weight(8) =  0.111674392344251941992578595518E-03;
    weight(9) =  0.645992676202290092465319025312E-05;
    weight(10) = 0.222631690709627263033182809179E-06;
    weight(11) = 0.422743038497936500735127949331E-08;
    weight(12) = 0.392189726704108929038460981949E-10;
    weight(13) = 0.145651526407312640633273963455E-12;
    weight(14) = 0.148302705111330133546164737187E-15;
    weight(15) = 0.160059490621113323104997812370E-19;

  elseif ( order == 31 )

    weight(  1) =   0.11252789550372583820847728082801E+00;
    weight(  2) =   0.21552760818089123795222505285045E+00;
    weight(  3) =   0.23830825164569654731905788089234E+00;
    weight(  4) =   0.19538830929790229249915303390711E+00;
    weight(  5) =   0.12698283289306190143635272904602E+00;
    weight(  6) =   0.67186168923899300670929441993508E-01;
    weight(  7) =   0.29303224993879487404888669311974E-01;
    weight(  8) =   0.10597569915295736089529380314433E-01;
    weight(  9) =   0.31851272582386980320974842433019E-02;
    weight( 10) =   0.79549548307940382922092149012477E-03;
    weight( 11) =   0.16480052126636687317862967116412E-03;
    weight( 12) =   0.28229237864310816393860971468993E-04;
    weight( 13) =   0.39802902551008580387116174900106E-05;
    weight( 14) =   0.45931839841801061673729694510289E-06;
    weight( 15) =   0.43075545187731100930131457465897E-07;
    weight( 16) =   0.32551249938271570855175749257884E-08;
    weight( 17) =   0.19620246675410594996247151593142E-09;
    weight( 18) =   0.93190499086617587129534716431331E-11;
    weight( 19) =   0.34377541819411620520312597898311E-12;
    weight( 20) =   0.96795247130446716997405035776206E-14;
    weight( 21) =   0.20368066110115247398010624219291E-15;
    weight( 22) =   0.31212687280713526831765358632585E-17;
    weight( 23) =   0.33729581704161052453395678308350E-19;
    weight( 24) =   0.24672796386616696011038363242541E-21;
    weight( 25) =   0.11582201904525643634834564576593E-23;
    weight( 26) =   0.32472922591425422434798022809020E-26;
    weight( 27) =   0.49143017308057432740820076259666E-29;
    weight( 28) =   0.34500071104808394132223135953806E-32;
    weight( 29) =   0.87663710117162041472932760732881E-36;
    weight( 30) =   0.50363643921161490411297172316582E-40;
    weight( 31) =   0.19909984582531456482439549080330E-45;

  elseif ( order == 63 )

    weight(  1) =   0.57118633213868979811587283390476E-01;
    weight(  2) =   0.12067476090640395283319932036351E+00;
    weight(  3) =   0.15925001096581873723870561096472E+00;
    weight(  4) =   0.16875178327560799234596192963585E+00;
    weight(  5) =   0.15366641977668956696193711310131E+00;
    weight(  6) =   0.12368770614716481641086652261948E+00;
    weight(  7) =   0.89275098854848671545279150057422E-01;
    weight(  8) =   0.58258485446105944957571825725160E-01;
    weight(  9) =   0.34546657545992580874717085812508E-01;
    weight( 10) =   0.18675685985714656798286552591203E-01;
    weight( 11) =   0.92233449044093536528490075241649E-02;
    weight( 12) =   0.41671250684839592762582663470209E-02;
    weight( 13) =   0.17238120299900582715386728541955E-02;
    weight( 14) =   0.65320845029716311169340559359043E-03;
    weight( 15) =   0.22677644670909586952405173207471E-03;
    weight( 16) =   0.72127674154810668410750270234861E-04;
    weight( 17) =   0.21011261180466484598811536851241E-04;
    weight( 18) =   0.56035500893357212749181536071292E-05;
    weight( 19) =   0.13673642785604888017836641282292E-05;
    weight( 20) =   0.30507263930195817240736097189550E-06;
    weight( 21) =   0.62180061839309763559981775409241E-07;
    weight( 22) =   0.11566529551931711260022448996296E-07;
    weight( 23) =   0.19614588267565478081534781863335E-08;
    weight( 24) =   0.30286171195709411244334756404054E-09;
    weight( 25) =   0.42521344539400686769012963452599E-10;
    weight( 26) =   0.54202220578073819334698791381873E-11;
    weight( 27) =   0.62627306838597672554166850420603E-12;
    weight( 28) =   0.65474443156573322992307089591924E-13;
    weight( 29) =   0.61815575808729181846302500000047E-14;
    weight( 30) =   0.52592721363507381404263991342633E-15;
    weight( 31) =   0.40230920092646484015391506025408E-16;
    weight( 32) =   0.27600740511819536505013824207729E-17;
    weight( 33) =   0.16936946756968296053322009855265E-18;
    weight( 34) =   0.92689146872177087314963772462726E-20;
    weight( 35) =   0.45093739060365632939780140603959E-21;
    weight( 36) =   0.19435162876132376573629962695374E-22;
    weight( 37) =   0.73926270895169207037999639194513E-24;
    weight( 38) =   0.24714364154434632615980126000066E-25;
    weight( 39) =   0.72288649446741597655145390616476E-27;
    weight( 40) =   0.18407617292614039362985209905608E-28;
    weight( 41) =   0.40583498566841960105759537058880E-30;
    weight( 42) =   0.77000496416438368114463925286343E-32;
    weight( 43) =   0.12488505764999334328843314866038E-33;
    weight( 44) =   0.17185000226767010697663950619912E-35;
    weight( 45) =   0.19896372636672396938013975755522E-37;
    weight( 46) =   0.19199671378804058267713164416870E-39;
    weight( 47) =   0.15278588285522166920459714708240E-41;
    weight( 48) =   0.99054752688842142955854138884590E-44;
    weight( 49) =   0.51597523673029211884228858692990E-46;
    weight( 50) =   0.21249846664084111245693912887783E-48;
    weight( 51) =   0.67903852766852910591172042494884E-51;
    weight( 52) =   0.16466654148296177467908300517887E-53;
    weight( 53) =   0.29509065402691055027053659375033E-56;
    weight( 54) =   0.37838420647571051984882241014675E-59;
    weight( 55) =   0.33358130068542431878174667995217E-62;
    weight( 56) =   0.19223461022273880981363303073329E-65;
    weight( 57) =   0.67812696961083016872779388922288E-69;
    weight( 58) =   0.13404752802440604607620468935693E-72;
    weight( 59) =   0.13109745101805029757648048223928E-76;
    weight( 60) =   0.52624863881401787388694579143866E-81;
    weight( 61) =   0.63780013856587414257760666006511E-86;
    weight( 62) =   0.12997078942372924566347473916943E-91;
    weight( 63) =   0.10008511496968754063443740168421E-98;

  elseif ( order == 127 )

    weight(  1) =   0.28773246692000124355770010301506E-01;
    weight(  2) =   0.63817468175134649363480949265236E-01;
    weight(  3) =   0.91919669721570571389864194652717E-01;
    weight(  4) =   0.11054167914413766381245463002967E+00;
    weight(  5) =   0.11879771633375850188328329422643E+00;
    weight(  6) =   0.11737818530052695148804451630074E+00;
    weight(  7) =   0.10819305984180551488335145581193E+00;
    weight(  8) =   0.93827075290489628080377261401107E-01;
    weight(  9) =   0.76966450960588843995822485928431E-01;
    weight( 10) =   0.59934903912939714332570730063476E-01;
    weight( 11) =   0.44417742073889001371708316272923E-01;
    weight( 12) =   0.31385080966252320983009372215062E-01;
    weight( 13) =   0.21172316041924506411370709025015E-01;
    weight( 14) =   0.13650145364230541652171185564626E-01;
    weight( 15) =   0.84172852710599172279366657385445E-02;
    weight( 16) =   0.49674990059882760515912858620175E-02;
    weight( 17) =   0.28069903895001884631961957446400E-02;
    weight( 18) =   0.15192951003941952460445341057817E-02;
    weight( 19) =   0.78789028751796084086217287140548E-03;
    weight( 20) =   0.39156751064868450584507324648999E-03;
    weight( 21) =   0.18652434268825860550093566260060E-03;
    weight( 22) =   0.85173160415576621908809828160247E-04;
    weight( 23) =   0.37285639197853037712145321577724E-04;
    weight( 24) =   0.15648416791712993947447805296768E-04;
    weight( 25) =   0.62964340695224829035692735524979E-05;
    weight( 26) =   0.24288929711328724574541379938222E-05;
    weight( 27) =   0.89824607890051007201922871545035E-06;
    weight( 28) =   0.31844174740760353710742966328091E-06;
    weight( 29) =   0.10821272905566839211861807542741E-06;
    weight( 30) =   0.35245076750635536015902779085340E-07;
    weight( 31) =   0.11001224365719347407063839761738E-07;
    weight( 32) =   0.32904079616717932125329343003261E-08;
    weight( 33) =   0.94289145237889976419772700772988E-09;
    weight( 34) =   0.25882578904668318184050195309296E-09;
    weight( 35) =   0.68047437103370762630942259017560E-10;
    weight( 36) =   0.17131398805120837835399564475632E-10;
    weight( 37) =   0.41291744524052865469443922304935E-11;
    weight( 38) =   0.95264189718807273220707664873469E-12;
    weight( 39) =   0.21032604432442425932962942047474E-12;
    weight( 40) =   0.44427151938729352860940434285789E-13;
    weight( 41) =   0.89760500362833703323319846405449E-14;
    weight( 42) =   0.17341511407769287074627948346848E-14;
    weight( 43) =   0.32028099548988356631494379835210E-15;
    weight( 44) =   0.56531388950793682022660742095189E-16;
    weight( 45) =   0.95329672799026591234588044025896E-17;
    weight( 46) =   0.15353453477310142565288509437552E-17;
    weight( 47) =   0.23608962179467365686057842132176E-18;
    weight( 48) =   0.34648742794456611332193876653230E-19;
    weight( 49) =   0.48515241897086461320126957663545E-20;
    weight( 50) =   0.64786228633519813428137373790678E-21;
    weight( 51) =   0.82476020965403242936448553126316E-22;
    weight( 52) =   0.10005361880214719793491658282977E-22;
    weight( 53) =   0.11561395116207304954233181263632E-23;
    weight( 54) =   0.12719342731167922655612134264961E-24;
    weight( 55) =   0.13316584714165372967340004160814E-25;
    weight( 56) =   0.13261218454678944033646108509198E-26;
    weight( 57) =   0.12554995447643949807286074138324E-27;
    weight( 58) =   0.11294412178579462703240913107219E-28;
    weight( 59) =   0.96491020279562119228500608131696E-30;
    weight( 60) =   0.78241846768302099396733076955632E-31;
    weight( 61) =   0.60181503542219626658249939076636E-32;
    weight( 62) =   0.43882482704961741551510518054138E-33;
    weight( 63) =   0.30314137647517256304035802501863E-34;
    weight( 64) =   0.19826016543944539545224676057020E-35;
    weight( 65) =   0.12267623373665926559013654872402E-36;
    weight( 66) =   0.71763931692508888943812834967620E-38;
    weight( 67) =   0.39659378833836963584113716149270E-39;
    weight( 68) =   0.20688970553868040099581951696677E-40;
    weight( 69) =   0.10179587017979517245268418427523E-41;
    weight( 70) =   0.47200827745986374625714293679649E-43;
    weight( 71) =   0.20606828985553374825744353490744E-44;
    weight( 72) =   0.84627575907305987245899032156188E-46;
    weight( 73) =   0.32661123687088798658026998931647E-47;
    weight( 74) =   0.11833939207883162380564134612682E-48;
    weight( 75) =   0.40211209123895013807243250164050E-50;
    weight( 76) =   0.12799824394111125389430292847476E-51;
    weight( 77) =   0.38123877747548846504399051365162E-53;
    weight( 78) =   0.10612057542701156767898551949650E-54;
    weight( 79) =   0.27571446947200403594113572720812E-56;
    weight( 80) =   0.66772544240928492881306904862856E-58;
    weight( 81) =   0.15052438383868234954068178600268E-59;
    weight( 82) =   0.31538986800113758526689068500772E-61;
    weight( 83) =   0.61326614299483180785237418887960E-63;
    weight( 84) =   0.11048510030324810567549119229368E-64;
    weight( 85) =   0.18410563538091348076979665543900E-66;
    weight( 86) =   0.28323926570052832195543883237652E-68;
    weight( 87) =   0.40154409843763655508670978777418E-70;
    weight( 88) =   0.52351530215683708779772201956106E-72;
    weight( 89) =   0.62634476665005100555787696642851E-74;
    weight( 90) =   0.68612210535666530365348093803922E-76;
    weight( 91) =   0.68651298840956019297134099761855E-78;
    weight( 92) =   0.62581388433728084867318704240915E-80;
    weight( 93) =   0.51833271237514904046803469968027E-82;
    weight( 94) =   0.38893621571918443533108973497673E-84;
    weight( 95) =   0.26357711379476932781525533730623E-86;
    weight( 96) =   0.16078851293917979699005509638883E-88;
    weight( 97) =   0.87978042070968939637972577886624E-91;
    weight( 98) =   0.43013405077495109903408697802188E-93;
    weight( 99) =   0.18713435881342838527144321803729E-95;
    weight(100) =   0.72125744708060471675805761366523E-98;
    weight(101) =   0.24508746062177874383231742333023E-100;
    weight(102) =   0.73042094619470875777647865078327E-103;
    weight(103) =   0.18983290818383463537886818579820E-105;
    weight(104) =   0.42757400244246684123093264825902E-108;
    weight(105) =   0.82894681420515755691423485228897E-111;
    weight(106) =   0.13729432219324400013067050156048E-113;
    weight(107) =   0.19265464126404973222043166489406E-116;
    weight(108) =   0.22693344503301354826140809941334E-119;
    weight(109) =   0.22209290603717355061909071271535E-122;
    weight(110) =   0.17851087685544512662856555121755E-125;
    weight(111) =   0.11630931990387164467431190485525E-128;
    weight(112) =   0.60524443584652392290952805077893E-132;
    weight(113) =   0.24729569115063528647628375096400E-135;
    weight(114) =   0.77789065006489410364997205809045E-139;
    weight(115) =   0.18409738662712607039570678274636E-142;
    weight(116) =   0.31900921131079114970179071968597E-146;
    weight(117) =   0.39179487139174199737617666077555E-150;
    weight(118) =   0.32782158394188697053774429820559E-154;
    weight(119) =   0.17793590713138888062819640128739E-158;
    weight(120) =   0.58882353408932623157467835381214E-163;
    weight(121) =   0.10957236509071169877747203273886E-167;
    weight(122) =   0.10281621114867000898285076975760E-172;
    weight(123) =   0.41704725557697758145816510853967E-178;
    weight(124) =   0.58002877720316101774638319601971E-184;
    weight(125) =   0.18873507745825517106171619101120E-190;
    weight(126) =   0.69106601826730911682786705950895E-198;
    weight(127) =   0.43506813201105855628383313334402E-207;

  else

    fprintf ( 1, '\n' );
    fprintf ( 1, 'LAGUERRE_WEIGHTS - Fatal error!\n' );
    fprintf ( 1, '  Illegal value of ORDER = %d\n', order );
    fprintf ( 1, '  Legal values are 1, 3, 7, 15, 31, 63 or 127.\n' );
    error ( 'LAGUERRE_WEIGHTS - Fatal error!' );

  end

  return
end
