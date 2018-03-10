library DrawMap;

uses graphABC;
///������� ������������ �����
function PaintMap(s: string; c1: array of integer; c2: array of integer; c3: array of integer; x: array of integer; y: array of integer):string;
begin
  //s - ��� ����� �� ����
  //p - �����
  var p:=new picture(s);
  window.Width :=p.width;
  window.Height:=p.height;
  p.draw(0,0);
  for var i:=0 to c1.Length-1 do
    floodfill(x[i],y[i], RGB(c1[i],c2[i],c3[i]));
  var NameFile:='Map stats.png';
  Window.Save(NameFile);
  result:=NameFile;
  Window.Minimize;
end;

///������ ����� �������
function LengthOfLegend(c1:array of integer):integer;
begin
  result:=880;//���������, ��� ���������� ����� �������
  if c1.Length<11 then
    if c1.Length<=5 then
      result:=400//������ ������ ������ ������ ���
    else
      result:=400 + (c1.Length-5)*80;
end;

///����������� ����� (1 000 000 >>> 1 000�)
function NumbersOfLegend(a:real):string;
begin
  var b:=0;
  var l:='';
  if a<100000 then
    l:=a.ToString
  else
  begin
    b:=Trunc(a) div 1000;
    l:=b.ToString+'K';
  end;
  if b>100000 then
  begin
    b:=b div 1000;
    l:=b.ToString+'M';
  end;
  result:=l;
end;

///������ �������
function PaintLegend( c1: array of integer; c2: array of integer; c3: array of integer; a: array of real):picture;
begin
  var w:=LengthOfLegend(c1);//����� �������
  var h:=35;                //������ ������
  var N := c1.Length;       //���-�� ������
  var MyScale:= w div N;    //������� ����� ����� �����
  Result := new Picture(w, 45);//������� ��������
  font.Size := 9;
  //��������������
  for var i := 0 to N - 1 do
  begin
    Brush.Color := RGB(c1[i],c2[i],c3[i]);
    result.Fillrectangle(i * MyScale, 0, (i + 1) * MyScale, (h div 3) * 2);
  end;
  Brush.Color:=color.White;
  
  //�����
  var t:=NumbersOfLegend(a[0]); //����� ��� ������� �����
  result.TextOut(0, (h div 3) * 2 + 5, t);//(h div 3) * 2 + 5. ��������� 5, ���� ���� ���� ���� �������
  for var i := 1 to N - 1 do
  begin
    t:=NumbersOfLegend(a[i]); //����� ��� ������� �����
    result.TextOut(i * MyScale - (TextWidth(t) div 2), (h div 3) * 2 + 5, t);//����� ��������� 5
    //- (TextWidth(t) div 2) ����� ����� ��� �������� ���� �� ������ �������
  end;
  t:=NumbersOfLegend(a[n]);
  result.TextOut(MyScale*N - (TextWidth(t)), (h div 3) * 2 + 5, t);
end;
end.