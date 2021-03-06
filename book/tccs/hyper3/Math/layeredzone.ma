Layered Orthorhombic model
ClearAll[c11,c12,c13,c12,c23,c22,c33,c44,c55,c66,n1,n2,n3,two,trace,G,H,angle,vhelbig,vpphase,vecdiff,vpgroup,vpg,pn12,pn22,pn32]


Extra two layers from the same model as the standard model
matortho = {{c11(1-δn),c12(1-δn),c13(1-δn),0,0,0},{c12(1-δn),c11(1-δn c12^2/c11^2),c13(1-δn c12/c11),0,0,0},{c13(1-δn),c13(1-δn c12/c11),c33(1-δn c13^2/(c11 c33)),0,0,0},{0,0,0,c44,0,0},{0,0,0,0,c44(1-δv),0},{0,0,0,0,0,c66(1-δh)}};
matortho/.{δn->1/10,δv->1/5,δh->3/11,c11->11,c12->3,c13->2,c33->5,c44->2.5,c66->3.5}//N//MatrixForm
(9.9	2.7	1.8	0.	0.	0.
2.7	10.9182	1.94545	0.	0.	0.
1.8	1.94545	4.96364	0.	0.	0.
0.	0.	0.	2.5	0.	0.
0.	0.	0.	0.	2.	0.
0.	0.	0.	0.	0.	2.54545

)

matortho/.{δn->1/10,δv->1/5,δh->3/11,c11->14,c12->3,c13->3.5,c33->9,c44->2.5,c66->3}//N//MatrixForm
(12.6	2.7	3.15	0.	0.	0.
2.7	13.9357	3.425	0.	0.	0.
3.15	3.425	8.9125	0.	0.	0.
0.	0.	0.	2.5	0.	0.
0.	0.	0.	0.	2.	0.
0.	0.	0.	0.	0.	2.18182

)

Exact velocity
p1=.;p2=.;p3=.;
azi = 0 Pi/180; (*Bottom*)
azi2 = 0 Pi/180; (*Middle*)
mat = {{c11,c12,c13,0,0,0},{c12,c22,c23,0,0,0},{c13,c23,c33,0,0,0},{0,0,0,c44,0,0},{0,0,0,0,c55,0},{0,0,0,0,0,c66}};
matn = {{n1,0,0,0,n3,n2},{0,n2,0,n3,0,n1},{0,0,n3,n2,n1,0}} ;
bond = {{Cos[azi]^2,Sin[azi]^2,0,0,0,-Sin[2azi]},{Sin[azi]^2,Cos[azi]^2,0,0,0,Sin[2azi]},{0,0,1,0,0,0},{0,0,0,Cos[azi],Sin[azi],0},{0,0,0,-Sin[azi],Cos[azi],0},{Sin[2azi]/2,-Sin[2azi]/2,0,0,0,Cos[2azi]}};
bond2 = {{Cos[azi2]^2,Sin[azi2]^2,0,0,0,-Sin[2azi2]},{Sin[azi2]^2,Cos[azi2]^2,0,0,0,Sin[2azi2]},{0,0,1,0,0,0},{0,0,0,Cos[azi2],Sin[azi2],0},{0,0,0,-Sin[azi2],Cos[azi2],0},{Sin[2azi2]/2,-Sin[2azi2]/2,0,0,0,Cos[2azi2]}};
matb= bond.mat.Transpose[bond];
matb2= bond2.mat.Transpose[bond2];

chris = matn.mat.Transpose[matn];
chrisp = chris/.{n1->p1 ,n2->p2 ,n3->p3};
det = Det[chrisp-IdentityMatrix[3]];

chrisb = matn.matb.Transpose[matn];
chrispb = chrisb /.{n1->p1 ,n2->p2 ,n3->p3};
detb = Det[chrispb-IdentityMatrix[3]];

chrisb2 = matn.matb2.Transpose[matn];
chrispb2 = chrisb2 /.{n1->p1 ,n2->p2 ,n3->p3};
detb2 = Det[chrispb2-IdentityMatrix[3]];

Hamiltonian to derive coefficients
F = det//Simplify(*Hamiltonian*)
Fb = detb;
Fb2 = detb2 //N;
(c13+c55) p1^2 p3^2 ((c23+c44) (c12+c66) p2^2-(c13+c55) (-1+c66 p1^2+c22 p2^2+c44 p3^2))-(c23+c44) p2^2 p3^2 (-(c13+c55) (c12+c66) p1^2+(c23+c44) (-1+c11 p1^2+c66 p2^2+c55 p3^2))+(-1+c55 p1^2+c44 p2^2+c33 p3^2) (-(c12+c66)^2 p1^2 p2^2+(-1+c66 p1^2+c22 p2^2+c44 p3^2) (-1+c11 p1^2+c66 p2^2+c55 p3^2))
DON'T FORGET TO CHECK WHICH ROOT IS THE RIGHT ONE FOR qP
p3sqf=Abs[p3sq/.Solve[0==F/.p3->Sqrt[p3sq],p3sq][[1]]]; (*Orthorhombic qP*)
p3sqfb=Abs[p3sq/.Solve[0==Fb/.p3->Sqrt[p3sq],p3sq][[1]]]; 
p3sqfb2=Abs[p3sq/.Solve[0==Fb2/.p3->Sqrt[p3sq],p3sq][[2]]]; 

p3sqf1=p3sqf/.{c11->9,c22->9.84,c33->5.9375,c44->2,c55->1.6,c66->2.182,c12->3.6,c23->2.4,c13->2.25};
p3sqf2 = p3sqfb2/.{c11->11.7,c22->13.5,c33->9,c44->1.728,c55->1.44,c66->2.246,c12->8.824,c23->5.981,c13->5.159};
p3sqf3=p3sqfb/.{c11->12.6,c22->13.94,c33->8.9125,c44->2.5,c55->2,c66->2.18182,c12->2.7,c23->3.425,c13->3.15};
DON'T FORGET A FACTOR OF  ΔZ  MULTIPLYING THE DERIVATIVES
dxdσ = D[F,p1]; (*Top*)
dydσ = D[F,p2];
dzdσ = D[F,p3];

dxdσb = D[Fb,p1]; (*Bottom*)
dydσb = D[Fb,p2];
dzdσb = D[Fb,p3];

dxdσb2 = D[Fb2,p1]; (*Middle*)
dydσb2 = D[Fb2,p2];
dzdσb2 = D[Fb2,p3];

dx1 =Δd1 dxdσ /dzdσ /.{p3->Sqrt[p3sqf1]}/.{c11->9,c22->9.84,c33->5.9375,c44->2,c55->1.6,c66->2.182,c12->3.6,c23->2.4,c13->2.25};
dx2 =Δd2 dxdσb2 /dzdσb2 /.{p3->Sqrt[p3sqf2]}/.{c11->11.7,c22->13.5,c33->9,c44->1.728,c55->1.44,c66->2.246,c12->8.824,c23->5.981,c13->5.159};
dx3 =Δd3 dxdσb /dzdσb /.{p3->Sqrt[p3sqf3]}/.{c11->12.6,c22->13.94,c33->8.9125,c44->2.5,c55->2,c66->2.18182,c12->2.7,c23->3.425,c13->3.15};
dy1 = Δd1 dydσ /dzdσ /.{p3->Sqrt[p3sqf1]}/.{c11->9,c22->9.84,c33->5.9375,c44->2,c55->1.6,c66->2.182,c12->3.6,c23->2.4,c13->2.25};
dy2 = Δd2 dydσb2 /dzdσb2 /.{p3->Sqrt[p3sqf2]}/.{c11->11.7,c22->13.5,c33->9,c44->1.728,c55->1.44,c66->2.246,c12->8.824,c23->5.981,c13->5.159};
dy3 = Δd3 dydσb /dzdσb /.{p3->Sqrt[p3sqf3]}/.{c11->12.6,c22->13.94,c33->8.9125,c44->2.5,c55->2,c66->2.18182,c12->2.7,c23->3.425,c13->3.15};
dt1 =Δd1 ((p1 dxdσ+p2 dydσ)/dzdσ +p3)/.{p3->Sqrt[p3sqf1]}/.{c11->9,c22->9.84,c33->5.9375,c44->2,c55->1.6,c66->2.182,c12->3.6,c23->2.4,c13->2.25};
dt2 =Δd2 ((p1 dxdσb2+p2 dydσb2)/dzdσb2 +p3)/.{p3->Sqrt[p3sqf2]}/.{c11->11.7,c22->13.5,c33->9,c44->1.728,c55->1.44,c66->2.246,c12->8.824,c23->5.981,c13->5.159};
dt3 =Δd3 ((p1 dxdσb+p2 dydσb)/dzdσb +p3)/.{p3->Sqrt[p3sqf3]}/.{c11->12.6,c22->13.94,c33->8.9125,c44->2.5,c55->2,c66->2.18182,c12->2.7,c23->3.425,c13->3.15};
dx = dx1 + dx2 + dx3;
dy = dy1 + dy2 + dy3;
dt = dt1 + dt2 + dt3;
Exact Traveltime (θ controls slowness not azimuth)
depth1 = 0.25; depth2 = 0.45;depth3=0.3; (*depth in km*)
depth = depth1 + depth2+depth3;

vert=({2dt1,2dt2,2dt3})/.{Δd1->depth1,Δd2->depth2,Δd3->depth3}/.{p1->0,p2->0};
vertt= (2dt)/.{Δd1->depth1,Δd2->depth2,Δd3->depth3}/.{p1->0,p2->0};
vertn= vert/vertt;

vyav = Sqrt[vertn.{9.84,13.5,13.94}];
vxav = Sqrt[vertn.{9,11.7,12.6}];

maxx = 0.85/vxav ;
maxy = 0.85/vyav;
maxr = R maxx maxy/Sqrt[(maxy^2 Cos[theta]^2 + maxx^2 Sin[theta]^2)]; (*Ellipse in polar*)
xoffset =(2 dx)/.{Δd1->depth1,Δd2->depth2,Δd3->depth3}/.{p1->maxr Cos[theta],p2->maxr Sin[theta]};//Simplify
yoffset = (2dy)/.{Δd1->depth1,Δd2->depth2,Δd3->depth3}/.{p1->maxr Cos[theta],p2->maxr Sin[theta]};//Simplify
exacttime = (2dt)/.{Δd1->depth1,Δd2->depth2,Δd3->depth3}/.{p1->maxr Cos[theta],p2->maxr Sin[theta]};

NMO Ellipse
δ2L1=((c13+c55)^2-(c33-c55)^2)/(2*c33*(c33-c55))/.{c11->9,c22->9.84,c33->5.9375,c44->2,c55->1.6,c66->2.182,c12->3.6,c23->2.4,c13->2.25};
δ1L1=((c23+c44)^2-(c33-c44)^2)/(2*c33*(c33-c44))/.{c11->9,c22->9.84,c33->5.9375,c44->2,c55->1.6,c66->2.182,c12->3.6,c23->2.4,c13->2.25};

δ2L2=((c13+c55)^2-(c33-c55)^2)/(2*c33*(c33-c55))/.{c11->11.7,c22->13.5,c33->9,c44->1.728,c55->1.44,c66->2.246,c12->8.824,c23->5.981,c13->5.159};
δ1L2=((c23+c44)^2-(c33-c44)^2)/(2*c33*(c33-c44))/.{c11->11.7,c22->13.5,c33->9,c44->1.728,c55->1.44,c66->2.246,c12->8.824,c23->5.981,c13->5.159};

δ2L3=((c13+c55)^2-(c33-c55)^2)/(2*c33*(c33-c55))/.{c11->12.6,c22->13.94,c33->8.9125,c44->2.5,c55->2,c66->2.18182,c12->2.7,c23->3.425,c13->3.15};
δ1L3=((c23+c44)^2-(c33-c44)^2)/(2*c33*(c33-c44))/.{c11->12.6,c22->13.94,c33->8.9125,c44->2.5,c55->2,c66->2.18182,c12->2.7,c23->3.425,c13->3.15};

rortho = Sqrt[xoffset^2+yoffset^2];
c = xoffset/rortho;
s = yoffset/rortho;
cb = c Cos[azi]+ s Sin[azi];
sb = s Cos[azi]-c Sin[azi];
cm = c Cos[azi2]+ s Sin[azi2];
sm = s Cos[azi2]-c Sin[azi2];

A2L1 = (1/(5.9375(1+2δ2L1)))c^2 +(1/(5.9375(1+2δ1L1)))s^2;
A2L2 =(1/(9(1+2δ2L2)))cm^2 +(1/(9(1+2δ1L2)))sm^2;
A2L3 =(1/(8.9125(1+2δ2L3)))cb^2 +1/(8.9125(1+2δ1L3))sb^2;
Q2 =1/(vertn.{1/A2L1,1/A2L2,1/A2L3});

orthoell = t0^2 + Q2 rortho^2 /.t0->2 (depth1/Sqrt[5.9375]+depth2/Sqrt[9]+depth3/Sqrt[8.9125]);
lynmorms[radius_,angle_]:= 100Abs[Sqrt[orthoell]/exacttime-1]/.{theta->angle}/.{p1->maxr Cos[angle],p2->maxr Sin[angle],R->radius};

Sripanich and Fomel (2014)

vnmoxav = 1/Sqrt[0.16186768356869694];
vnmoxyav = Infinity;
vnmoyav = 1/Sqrt[0.11785094741741599];

x4coeff = - (1-2S32f(Q12f+1)+Q32f(4S32f+Q32f-2))/(2S32f Q32f^2 t0^2 vnmox^4)/.{S32f->1/(2(1+Q32f))}/.{Q12f->Q32f/(0.8373406986+0.1580976683 Q32f)}/.{vnmox ->vnmoxav,vnmoxy->Infinity,vnmoy->vnmoyav}/.t0->2 (depth1/Sqrt[5.9375]+depth2/Sqrt[9]+depth3/Sqrt[8.9125]);
xy4coeff =  (S31f (Q32f-1)^2-S32f(Q32f-1)(Q32f+2Q31f-3)-2S32f^2(Q32f+Q31f-Q13f-1))/(2S32f^2 Q31f Q32f t0^2 vnmox^2 vnmoy^2)/.{S32f->1/(2(1+Q32f)),S31f->1/(2(1+Q31f))}/.{vnmox ->vnmoxav,vnmoxy->Infinity,vnmoy->vnmoyav}/.t0->2 (depth1/Sqrt[5.9375]+depth2/Sqrt[9]+depth3/Sqrt[8.9125]);
y4coeff = - (1-2S31f(Q21f+1)+Q31f(4S31f+Q31f-2))/(2S31f Q31f^2 t0^2 vnmoy^4)/.{S31f->1/(2(1+Q31f))}/.{Q21f->Q31f/(0.8373406986+0.1580976683 Q31f)}/.{vnmox ->vnmoxav,vnmoxy->Infinity,vnmoy->vnmoyav}/.t0->2 (depth1/Sqrt[5.9375]+depth2/Sqrt[9]+depth3/Sqrt[8.9125]);
{Q32,Q31,Q13}={Q32f,Q31f,Q13f}/.NSolve[{-0.038905391211164195 == x4coeff,-0.031790004734663674==xy4coeff,-0.0135746142048085==y4coeff},{Q32f,Q31f,Q13f}][[5]]
{1.68472,1.4447,1.61812}
Q12 = Q32/(0.8373406986+0.1580976683 Q32);
Q21 = Q31/(0.8373406986+0.1580976683 Q31);
Q23 = Q13;
S32=1/(2(1+Q32));
S12=1/(2(1+Q32));
S31=1/(2(1+Q31));
S21=1/(2(1+Q31));
S13=1/(2(1+Q13));
S23=1/(2(1+Q13));
Hortho =t0^2 + x^2/(Q32 vnmox^2) + y^2/(Q31 vnmoy^2);
S1h = (S13 y^2/(Q31 vnmoy^2) + S12 t0^2)/(y^2/(Q31 vnmoy^2) + t0^2);
S2h = (S23 x^2/(Q32 vnmox^2) + S21 t0^2)/(x^2/(Q32 vnmox^2) + t0^2);
S3h = (S32 x^2/(Q32 vnmox^2) + S31 y^2/(Q31 vnmoy^2))/(x^2/(Q32 vnmox^2) + y^2/(Q31 vnmoy^2));
Shat =   (S1h x^2/(Q32 vnmox^2)  + S2h y^2 /(Q31 vnmoy^2) + S3h t0^2)/(x^2/(Q32 vnmox^2)  + y^2 /(Q31 vnmoy^2) + t0^2);

Q1h = (Q21 y^2/(Q31 vnmoy^2) + Q31 t0^2)/(y^2/(Q31 vnmoy^2) + t0^2);
Q2h = (Q12 x^2/(Q32 vnmox^2) + Q32 t0^2)/(x^2/(Q32 vnmox^2) + t0^2);
Q3h = (Q13 x^2/(Q32 vnmox^2) + Q23 y^2/(Q31 vnmoy^2))/(x^2/(Q32 vnmox^2) + y^2/(Q31 vnmoy^2));

zone = Hortho(1-Shat) + Shat Sqrt[Hortho^2 +2/Shat(((Q1h-1)t0^2 y^2 )/(Q31 vnmoy^2) +((Q2h-1)t0^2 x^2)/(Q32 vnmox^2) +((Q3h-1)x^2 y^2)/((Q32 vnmox^2)(Q31 vnmoy^2)))]/.{x->xoffset,y->yoffset}/.{vnmox ->vnmoxav,vnmoxy->Infinity,vnmoy->vnmoyav}/.t0->2 (depth1/Sqrt[5.9375]+depth2/Sqrt[9]+depth3/Sqrt[8.9125]);
zonerms[radius_,angle_]:= 100Abs[Sqrt[zone]/exacttime-1]/.{theta->angle}/.{p1->maxr Cos[angle],p2->maxr Sin[angle],R->radius};
layeredzone = Rasterize[ParametricPlot3D[{xoffset,yoffset,100Abs[Sqrt[zone]/exacttime-1]}/.{p1->maxr Cos[theta],p2->maxr Sin[theta]},{R,0,1},{theta,0,2Pi},PlotRange->{All,All,All},Boxed->False,BoxRatios->{1,1,0.3},Axes->{True,True,False},AxesLabel->{"x/H","y/H"},Ticks->{{-3,-2,-1,0,1,2,3},{-3,-2,-1,0,1,2,3}},ColorFunctionScaling->False,ColorFunction->ColorData[{"DarkRainbow",{0,2.5}}],Lighting->{{"Ambient",White,{0,0,5}}},ViewPoint->{0,0,Infinity},LabelStyle->{Black,FontSize->22,FontFamily->"Times",Bold},TicksStyle->Directive[Thick,20],Mesh->19,ImageSize->500,PlotLegends->BarLegend[Automatic,LegendLabel->Placed["Error %",Above],LabelStyle->Directive[FontSize->22,FontFamily->"Times",Black,Bold]]]]
(*Export["~/Desktop/layeredzone.eps",%]*)

Export["junk_ma.eps",layeredzone,"EPS"]
