function [ ampl, phi ] = r8_admp ( x )

%*****************************************************************************80
%
%% R8_ADMP: modulus and phase of the derivative of the Airy function.
%
%  Description:
%
%    This function must only be called when X <= -1.0.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    28 September 2011
%
%  Author:
%
%    Original FORTRAN77 version by Wayne Fullerton.
%    MATLAB version by John Burkardt.
%
%  Reference:
%
%    Wayne Fullerton,
%    Portable Special Function Routines,
%    in Portability of Numerical Software,
%    edited by Wayne Cowell,
%    Lecture Notes in Computer Science, Volume 57,
%    Springer 1977,
%    ISBN: 978-3-540-08446-4,
%    LC: QA297.W65.
%
%  Parameters:
%
%    Input, real X, the argument.
%
%    Output, real AMPL, PHI, the modulus and phase of the
%    derivative of the Airy function.
%
  persistent an20cs
  persistent an21cs
  persistent an22cs
  persistent aph0cs
  persistent aph1cs
  persistent aph2cs
  persistent nan20
  persistent nan21
  persistent nan22
  persistent naph0
  persistent naph1
  persistent naph2
  persistent pi34
  persistent xsml

  if ( isempty ( nan20 ) )

    an20cs = [ ...
        0.0126732217145738027154610751034240, ...
       -0.0005212847072615621184780942309478, ...
       -0.0000052672111140370429809074052969, ...
       -0.0000001628202185026483752632460680, ...
       -0.0000000090991442687371386325973075, ...
       -0.0000000007438647126242192890685403, ...
       -0.0000000000795494751591469486122822, ...
       -0.0000000000104050944288303742803960, ...
       -0.0000000000015932425598414551523990, ...
       -0.0000000000002770648272341913946674, ...
       -0.0000000000000535342629237606295104, ...
       -0.0000000000000113061541781728314051, ...
       -0.0000000000000025772190078943167788, ...
       -0.0000000000000006278033116032485076, ...
       -0.0000000000000001621295400189939757, ...
       -0.0000000000000000440992985240675353, ...
       -0.0000000000000000125655516553258972, ...
       -0.0000000000000000037336906988015204, ...
       -0.0000000000000000011524626926724671, ...
       -0.0000000000000000003683081499099144, ...
       -0.0000000000000000001215206965331797, ...
       -0.0000000000000000000412916177724016, ...
       -0.0000000000000000000144177364239347, ...
       -0.0000000000000000000051631842875864, ...
       -0.0000000000000000000018931242668250, ...
       -0.0000000000000000000007096054668569, ...
       -0.0000000000000000000002715406646904, ...
       -0.0000000000000000000001059486979400, ...
       -0.0000000000000000000000421030035685, ...
       -0.0000000000000000000000170233781664, ...
       -0.0000000000000000000000069966677028, ...
       -0.0000000000000000000000029206643813, ...
       -0.0000000000000000000000012373128203, ...
       -0.0000000000000000000000005315871095, ...
       -0.0000000000000000000000002314622618, ...
       -0.0000000000000000000000001020779922, ...
       -0.0000000000000000000000000455706227, ...
       -0.0000000000000000000000000205831071, ...
       -0.0000000000000000000000000094015189, ...
       -0.0000000000000000000000000043405874, ...
       -0.0000000000000000000000000020247792, ...
       -0.0000000000000000000000000009539214, ...
       -0.0000000000000000000000000004537234, ...
       -0.0000000000000000000000000002178016, ...
       -0.0000000000000000000000000001054823, ...
       -0.0000000000000000000000000000515242, ...
       -0.0000000000000000000000000000253763, ...
       -0.0000000000000000000000000000125983, ...
       -0.0000000000000000000000000000063030, ...
       -0.0000000000000000000000000000031771, ...
       -0.0000000000000000000000000000016131, ...
       -0.0000000000000000000000000000008248, ...
       -0.0000000000000000000000000000004246, ...
       -0.0000000000000000000000000000002200, ...
       -0.0000000000000000000000000000001147, ...
       -0.0000000000000000000000000000000602, ...
       -0.0000000000000000000000000000000318 ]';
    an21cs = [ ...
        0.0198313155263169394420342483165643, ...
       -0.0029376249067087533460593745594484, ...
       -0.0001136260695958195549872611137182, ...
       -0.0000100554451087156009750981645918, ...
       -0.0000013048787116563250421785598252, ...
       -0.0000002123881993150664830666079609, ...
       -0.0000000402270833384269040347850109, ...
       -0.0000000084996745953161799142201792, ...
       -0.0000000019514839426178614099532934, ...
       -0.0000000004783865343840384282992480, ...
       -0.0000000001236733992099450501137105, ...
       -0.0000000000334137486398754232219789, ...
       -0.0000000000093702823540766329897780, ...
       -0.0000000000027130128156139564687240, ...
       -0.0000000000008075953800583479535949, ...
       -0.0000000000002463214304700125252160, ...
       -0.0000000000000767655689109321564410, ...
       -0.0000000000000243882598807354919791, ...
       -0.0000000000000078831466358760308462, ...
       -0.0000000000000025882400995585864077, ...
       -0.0000000000000008619457862945690828, ...
       -0.0000000000000002907994739663128534, ...
       -0.0000000000000000992846796122890484, ...
       -0.0000000000000000342720229187774480, ...
       -0.0000000000000000119511048205515026, ...
       -0.0000000000000000042069729043678359, ...
       -0.0000000000000000014939697762818400, ...
       -0.0000000000000000005348981161589517, ...
       -0.0000000000000000001929877577826238, ...
       -0.0000000000000000000701313701018203, ...
       -0.0000000000000000000256585738509682, ...
       -0.0000000000000000000094475894562734, ...
       -0.0000000000000000000034996401941465, ...
       -0.0000000000000000000013037622466397, ...
       -0.0000000000000000000004883334163346, ...
       -0.0000000000000000000001838477586152, ...
       -0.0000000000000000000000695527324058, ...
       -0.0000000000000000000000264351910209, ...
       -0.0000000000000000000000100918094655, ...
       -0.0000000000000000000000038688924289, ...
       -0.0000000000000000000000014892036525, ...
       -0.0000000000000000000000005754342426, ...
       -0.0000000000000000000000002231725971, ...
       -0.0000000000000000000000000868607480, ...
       -0.0000000000000000000000000339220403, ...
       -0.0000000000000000000000000132910128, ...
       -0.0000000000000000000000000052239309, ...
       -0.0000000000000000000000000020594383, ...
       -0.0000000000000000000000000008142614, ...
       -0.0000000000000000000000000003228473, ...
       -0.0000000000000000000000000001283529, ...
       -0.0000000000000000000000000000511622, ...
       -0.0000000000000000000000000000204451, ...
       -0.0000000000000000000000000000081901, ...
       -0.0000000000000000000000000000032886, ...
       -0.0000000000000000000000000000013235, ...
       -0.0000000000000000000000000000005338, ...
       -0.0000000000000000000000000000002158, ...
       -0.0000000000000000000000000000000874, ...
       -0.0000000000000000000000000000000355 ]';
    an22cs = [ ...
        0.0537418629629794329091103360917783, ...
       -0.0126661435859883193466312085036450, ...
       -0.0011924334106593006840848916913681, ...
       -0.0002032327627275654552687155176363, ...
       -0.0000446468963075163979516164905945, ...
       -0.0000113359036053123490416997893086, ...
       -0.0000031641352378546107356671355827, ...
       -0.0000009446708886148939120888532442, ...
       -0.0000002966562236471765527900905456, ...
       -0.0000000969118892024367799908661433, ...
       -0.0000000326822538653274091533072559, ...
       -0.0000000113144618963583865900447294, ...
       -0.0000000040042691001741501738278050, ...
       -0.0000000014440333683907423778522199, ...
       -0.0000000005292853746152611585663541, ...
       -0.0000000001967763373707889528245726, ...
       -0.0000000000740800095755849858816731, ...
       -0.0000000000282016314294661982842740, ...
       -0.0000000000108440066463128331337590, ...
       -0.0000000000042074800682644236920617, ...
       -0.0000000000016459149670634819724739, ...
       -0.0000000000006486826705121018896077, ...
       -0.0000000000002574095003354105832300, ...
       -0.0000000000001027889029407822132143, ...
       -0.0000000000000412845827195222720128, ...
       -0.0000000000000166711029332862509726, ...
       -0.0000000000000067656696165608023403, ...
       -0.0000000000000027585448232693576823, ...
       -0.0000000000000011296397915297168938, ...
       -0.0000000000000004644848225457314333, ...
       -0.0000000000000001917198035033912928, ...
       -0.0000000000000000794197570111893530, ...
       -0.0000000000000000330116492300368930, ...
       -0.0000000000000000137658057726549714, ...
       -0.0000000000000000057578093720012791, ...
       -0.0000000000000000024152700858632017, ...
       -0.0000000000000000010159301700933666, ...
       -0.0000000000000000004284434955330055, ...
       -0.0000000000000000001811344052168016, ...
       -0.0000000000000000000767602045619422, ...
       -0.0000000000000000000326026346758614, ...
       -0.0000000000000000000138773806682627, ...
       -0.0000000000000000000059191627103729, ...
       -0.0000000000000000000025297256431944, ...
       -0.0000000000000000000010832077293819, ...
       -0.0000000000000000000004646674880404, ...
       -0.0000000000000000000001996797783865, ...
       -0.0000000000000000000000859524108705, ...
       -0.0000000000000000000000370584152073, ...
       -0.0000000000000000000000160027503479, ...
       -0.0000000000000000000000069208124999, ...
       -0.0000000000000000000000029974448994, ...
       -0.0000000000000000000000013000356362, ...
       -0.0000000000000000000000005646100942, ...
       -0.0000000000000000000000002455341103, ...
       -0.0000000000000000000000001069119686, ...
       -0.0000000000000000000000000466095090, ...
       -0.0000000000000000000000000203441579, ...
       -0.0000000000000000000000000088900866, ...
       -0.0000000000000000000000000038891813, ...
       -0.0000000000000000000000000017032637, ...
       -0.0000000000000000000000000007467295, ...
       -0.0000000000000000000000000003277097, ...
       -0.0000000000000000000000000001439618, ...
       -0.0000000000000000000000000000633031, ...
       -0.0000000000000000000000000000278620, ...
       -0.0000000000000000000000000000122743, ...
       -0.0000000000000000000000000000054121, ...
       -0.0000000000000000000000000000023884, ...
       -0.0000000000000000000000000000010549, ...
       -0.0000000000000000000000000000004663, ...
       -0.0000000000000000000000000000002063, ...
       -0.0000000000000000000000000000000913, ...
       -0.0000000000000000000000000000000405 ]';
    aph0cs = [ ...
       -0.0855849241130933256920124260179491, ...
        0.0011214378867065260735786722471124, ...
        0.0000042721029353664113951573742015, ...
        0.0000000817607381483243644018062323, ...
        0.0000000033907645000492724207816418, ...
        0.0000000002253264422619113939845276, ...
        0.0000000000206284209229015251256990, ...
        0.0000000000023858762828130887627258, ...
        0.0000000000003301618105886705480628, ...
        0.0000000000000527009648508328581123, ...
        0.0000000000000094555482203813492868, ...
        0.0000000000000018709426951344836908, ...
        0.0000000000000004023980041825392741, ...
        0.0000000000000000930192879258983167, ...
        0.0000000000000000229038635402379945, ...
        0.0000000000000000059634359822083386, ...
        0.0000000000000000016320279659403399, ...
        0.0000000000000000004671145658861339, ...
        0.0000000000000000001392334415363502, ...
        0.0000000000000000000430642670285155, ...
        0.0000000000000000000137781416318755, ...
        0.0000000000000000000045476710480396, ...
        0.0000000000000000000015448420203026, ...
        0.0000000000000000000005389770551212, ...
        0.0000000000000000000001927726737155, ...
        0.0000000000000000000000705659320166, ...
        0.0000000000000000000000263985084827, ...
        0.0000000000000000000000100791301805, ...
        0.0000000000000000000000039228928481, ...
        0.0000000000000000000000015547422955, ...
        0.0000000000000000000000006268306372, ...
        0.0000000000000000000000002568563962, ...
        0.0000000000000000000000001068858883, ...
        0.0000000000000000000000000451347253, ...
        0.0000000000000000000000000193267262, ...
        0.0000000000000000000000000083865369, ...
        0.0000000000000000000000000036857386, ...
        0.0000000000000000000000000016396202, ...
        0.0000000000000000000000000007379298, ...
        0.0000000000000000000000000003358392, ...
        0.0000000000000000000000000001544891, ...
        0.0000000000000000000000000000718013, ...
        0.0000000000000000000000000000337026, ...
        0.0000000000000000000000000000159710, ...
        0.0000000000000000000000000000076382, ...
        0.0000000000000000000000000000036855, ...
        0.0000000000000000000000000000017935, ...
        0.0000000000000000000000000000008800, ...
        0.0000000000000000000000000000004353, ...
        0.0000000000000000000000000000002170, ...
        0.0000000000000000000000000000001090, ...
        0.0000000000000000000000000000000551, ...
        0.0000000000000000000000000000000281 ]';
    aph1cs = [ ...
       -0.1024172908077571694021123321813917, ...
        0.0071697275146591248047211649144704, ...
        0.0001209959363122328589813856491397, ...
        0.0000073361512841219912080297845684, ...
        0.0000007535382954271607069982903869, ...
        0.0000001041478171741301926885109155, ...
        0.0000000174358728518545691858907606, ...
        0.0000000033399795033346451660184961, ...
        0.0000000007073075174363527083399508, ...
        0.0000000001619187515189773266792272, ...
        0.0000000000394539981881954889879668, ...
        0.0000000000101192281734227133292631, ...
        0.0000000000027092778259520332198030, ...
        0.0000000000007523806418422548885854, ...
        0.0000000000002156368733008966357328, ...
        0.0000000000000635282777126068410174, ...
        0.0000000000000191756972641501729345, ...
        0.0000000000000059143072446464891558, ...
        0.0000000000000018597128517275028357, ...
        0.0000000000000005950444923946103668, ...
        0.0000000000000001934229956430180252, ...
        0.0000000000000000637843021489504324, ...
        0.0000000000000000213127290087312393, ...
        0.0000000000000000072081380656728500, ...
        0.0000000000000000024652494144769247, ...
        0.0000000000000000008519110570266154, ...
        0.0000000000000000002972384468491170, ...
        0.0000000000000000001046426648811446, ...
        0.0000000000000000000371493036347327, ...
        0.0000000000000000000132923247793472, ...
        0.0000000000000000000047912837925909, ...
        0.0000000000000000000017390619859336, ...
        0.0000000000000000000006353585173501, ...
        0.0000000000000000000002335643614263, ...
        0.0000000000000000000000863643881606, ...
        0.0000000000000000000000321123006944, ...
        0.0000000000000000000000120031540983, ...
        0.0000000000000000000000045091488699, ...
        0.0000000000000000000000017020228580, ...
        0.0000000000000000000000006453744630, ...
        0.0000000000000000000000002457788564, ...
        0.0000000000000000000000000939897684, ...
        0.0000000000000000000000000360863150, ...
        0.0000000000000000000000000139077884, ...
        0.0000000000000000000000000053797184, ...
        0.0000000000000000000000000020882551, ...
        0.0000000000000000000000000008133371, ...
        0.0000000000000000000000000003178080, ...
        0.0000000000000000000000000001245700, ...
        0.0000000000000000000000000000489742, ...
        0.0000000000000000000000000000193099, ...
        0.0000000000000000000000000000076349, ...
        0.0000000000000000000000000000030269, ...
        0.0000000000000000000000000000012032, ...
        0.0000000000000000000000000000004795, ...
        0.0000000000000000000000000000001915, ...
        0.0000000000000000000000000000000767, ...
        0.0000000000000000000000000000000308 ]';
    aph2cs = [ ...
       -0.2057088719781465106973648665602125, ...
        0.0422196961357771921673114980369460, ...
        0.0020482560511207275042660577813334, ...
        0.0002607800735165005631187879922652, ...
        0.0000474824268004728875381750519293, ...
        0.0000105102756431611743473630026955, ...
        0.0000026353534014667945109314041983, ...
        0.0000007208824863499147299790783731, ...
        0.0000002103236664473352859749477082, ...
        0.0000000644975634555295598437362273, ...
        0.0000000205802377264368507978116888, ...
        0.0000000067836273920906428963513918, ...
        0.0000000022974015284009400168343792, ...
        0.0000000007961306765491187534883226, ...
        0.0000000002813860609741591719003632, ...
        0.0000000001011749056931973922841793, ...
        0.0000000000369306737952476559097060, ...
        0.0000000000136615066127098031778842, ...
        0.0000000000051142751416045045119388, ...
        0.0000000000019351688931706516247975, ...
        0.0000000000007393606916493224217271, ...
        0.0000000000002849792219222743597555, ...
        0.0000000000001107280782459648335733, ...
        0.0000000000000433412199370134633169, ...
        0.0000000000000170800825265670367471, ...
        0.0000000000000067733080195631114673, ...
        0.0000000000000027016904789262414108, ...
        0.0000000000000010834720751810782141, ...
        0.0000000000000004367060312970286167, ...
        0.0000000000000001768511738053366608, ...
        0.0000000000000000719359213093645717, ...
        0.0000000000000000293823610002933154, ...
        0.0000000000000000120482811525848357, ...
        0.0000000000000000049586659491091389, ...
        0.0000000000000000020479438315847217, ...
        0.0000000000000000008486019944410629, ...
        0.0000000000000000003527351765384506, ...
        0.0000000000000000001470563996804903, ...
        0.0000000000000000000614817826902188, ...
        0.0000000000000000000257737706565077, ...
        0.0000000000000000000108323903590042, ...
        0.0000000000000000000045638898024998, ...
        0.0000000000000000000019273635403662, ...
        0.0000000000000000000008157668569775, ...
        0.0000000000000000000003460202828346, ...
        0.0000000000000000000001470726482427, ...
        0.0000000000000000000000626356074088, ...
        0.0000000000000000000000267261292780, ...
        0.0000000000000000000000114246948763, ...
        0.0000000000000000000000048923460516, ...
        0.0000000000000000000000020985807810, ...
        0.0000000000000000000000009016618807, ...
        0.0000000000000000000000003880129464, ...
        0.0000000000000000000000001672282170, ...
        0.0000000000000000000000000721790800, ...
        0.0000000000000000000000000311982573, ...
        0.0000000000000000000000000135035015, ...
        0.0000000000000000000000000058524861, ...
        0.0000000000000000000000000025397686, ...
        0.0000000000000000000000000011035457, ...
        0.0000000000000000000000000004800788, ...
        0.0000000000000000000000000002090956, ...
        0.0000000000000000000000000000911743, ...
        0.0000000000000000000000000000397998, ...
        0.0000000000000000000000000000173923, ...
        0.0000000000000000000000000000076083, ...
        0.0000000000000000000000000000033316, ...
        0.0000000000000000000000000000014604, ...
        0.0000000000000000000000000000006407, ...
        0.0000000000000000000000000000002814, ...
        0.0000000000000000000000000000001237, ...
        0.0000000000000000000000000000000544 ]';

    eta = 0.1 * r8_mach ( 3 );
    nan20 = r8_inits ( an20cs, 57, eta );
    nan21 = r8_inits ( an21cs, 60, eta );
    nan22 = r8_inits ( an22cs, 74, eta );
    naph0 = r8_inits ( aph0cs, 53, eta );
    naph1 = r8_inits ( aph1cs, 58, eta );
    naph2 = r8_inits ( aph2cs, 72, eta );
    xsml = - ( 128.0 / r8_mach ( 3 ) )^0.3333;

  end

  if ( x < xsml )
    z = 1.0;
    ampl = 0.3125 + r8_csevl ( z, an20cs, nan20 );
    phi = - 0.625 + r8_csevl ( z, aph0cs, naph0 );
  elseif ( x < - 4.0 )
    z = 128.0 / x / x / x + 1.0;
    ampl = 0.3125 + r8_csevl ( z, an20cs, nan20 );
    phi = - 0.625 + r8_csevl ( z, aph0cs, naph0 );
  elseif ( x < - 2.0 )
    z = ( 128. / x / x / x + 9.0 ) / 7.0;
    ampl = 0.3125 + r8_csevl ( z, an21cs, nan21 );
    phi = - 0.625 + r8_csevl ( z, aph1cs, naph1 );
  elseif ( x <= - 1.0 )
    z = ( 16.0 / x / x / x + 9.0 ) / 7.0;
    ampl = 0.3125 + r8_csevl ( z, an22cs, nan22 );
    phi = - 0.625 + r8_csevl ( z, aph2cs, naph2 );
  else
    fprintf ( 1, '\n' );
    fprintf ( 1, 'R8_ADMP - Fatal error!\n' );
    fprintf ( 1, '  - 1.0 < X.\n' );
    error ( 'R8_ADMP - Fatal error!' )
  end

  sqrtx = sqrt ( - x );
  ampl = sqrt ( ampl * sqrtx );
  phi = 0.75 * pi - x * sqrtx * phi;

  return
end
